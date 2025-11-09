package com.sbeam.sbeam.consumer;

import com.rabbitmq.client.Channel;
import com.sbeam.sbeam.entity.Cart;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.OrderDetails;
import com.sbeam.sbeam.entity.Sales;
import com.sbeam.sbeam.entity.VO.OrderEvent;
import com.sbeam.sbeam.mapper.CartMapper;
import com.sbeam.sbeam.mapper.MyorderMapper;
import com.sbeam.sbeam.mapper.OrderDetailsMapper;
import com.sbeam.sbeam.mapper.SalesMapper;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.Optional;
import java.util.Set;
import java.util.Collections;
import java.util.concurrent.TimeUnit;
import java.math.BigDecimal;

/**
 * Order MQ Consumer
 * 负责异步处理订单创建，将待支付订单信息写入MySQL
 * 注意：此消费者只处理订单创建，不进行库存扣减操作
 */
@Component
public class OrderMqConsumer {

    @Autowired
    private MyorderMapper myorderMapper;
    
    @Autowired
    private OrderDetailsMapper orderDetailsMapper;
    
    @Autowired
    private CartMapper cartMapper;
    @Autowired
    private SalesMapper salesMapper;
    
    @Autowired
    private RabbitTemplate rabbitTemplate;
    
    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @RabbitListener(queues = "order_queue")
    public void handleOrder(OrderEvent event, Channel channel, Message message) {
        long deliveryTag = message.getMessageProperties().getDeliveryTag();
        System.out.println("开始异步处理订单创建，用户ID: " + event.getUserId());
        
        Integer userId = event.getUserId();
        List<Cart> cartList = event.getCartList();

        try {
            // 1. 创建订单（待支付）
            Myorder myorder = new Myorder();
            myorder.setUserId(userId);
            myorder.setOrderNumber("ORDER" + UUID.randomUUID().toString().replace("-",""));
            
            // 计算订单价格
            BigDecimal originalPrice = cartList.stream()
                .map(cart -> Optional.ofNullable(cart.getGamePrice()).orElse(BigDecimal.ZERO))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            myorder.setOriginalPrice(originalPrice);
            myorder.setFinalPrice(compute_finalPrice(cartList)); // 计算最终支付价格
            myorder.setOrderDate(LocalDateTime.now());
            myorder.setOrderStatus("unpaid");
            myorder.setVersion(1);
            myorder.setStatus(0);
            myorder.setCreatedAt(LocalDateTime.now());
            
            // 保存订单到MySQL
            myorderMapper.insert(myorder);
            System.out.println("订单已创建，订单ID: " + myorder.getOrderId() + "，订单号: " + myorder.getOrderNumber());

            // 2. 创建订单详情（不扣库存）
            for(Cart cart : cartList){
                OrderDetails details = new OrderDetails();
                details.setOrderId(myorder.getOrderId());
                details.setUserId(userId);
                details.setGameId(cart.getGameId());
                details.setDiscountId(cart.getSalesId());
                details.setStatus(0);
                details.setVersion(1);
                details.setCreatedAt(LocalDateTime.now());
                
                // 保存订单详情
                orderDetailsMapper.insert(details);
                System.out.println("订单详情已创建，游戏ID: " + cart.getGameId());
            }
            
            // 3. 更新购物车状态，标记为已下单
            for(Cart cart : cartList) {
                cart.setStatus(1); // 1表示已下单
                cartMapper.updateById(cart);
            }
            
            // 5. 发送订单超时延迟消息（15分钟）
            sendOrderTimeoutMessage(myorder.getOrderId());
            
            System.out.println("订单异步处理完成，用户ID: " + userId + "，订单编号: " + myorder.getOrderNumber());

            channel.basicAck(deliveryTag,false);
        } catch (Exception e) {
            System.err.println("异步处理订单失败: " + e.getMessage());
            e.printStackTrace();
            // 处理失败时，更新Redis状态为失败
            // 这里可以添加错误处理逻辑，如发送失败消息到死信队列
            try {
                // ❌ 处理失败，重回队列（true）
                channel.basicNack(deliveryTag, false, true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    //计算订单价格
    private BigDecimal compute_finalPrice(List<Cart> cartList){
        BigDecimal finalPrice = BigDecimal.ZERO;
        for(Cart cart:cartList){
            BigDecimal gamePrice = cart.getGamePrice();
            BigDecimal discount = selectdiscount(cart.getSalesId());
            BigDecimal itemPrice = gamePrice.multiply(discount);
            // 4. 累加至总价（保留2位小数，四舍五入，避免精度问题）
            finalPrice = finalPrice.add(itemPrice).setScale(2, RoundingMode.HALF_UP);
        }
        return finalPrice;
    }
    //查询salesid的discount
    private BigDecimal selectdiscount(Integer salesId){
        Sales sales = salesMapper.selectById(salesId);
        return BigDecimal.ONE.subtract(sales.getDiscountRate());
    }
    
    /**
     * 发送订单超时延迟消息
     * 设置15分钟后触发订单超时检查
     */
    private void sendOrderTimeoutMessage(Integer orderId) {
        HashMap<String, Object> message = new HashMap<>();
        message.put("orderId", orderId);
        message.put("timestamp", System.currentTimeMillis());

        // 设置15分钟延迟时间
        rabbitTemplate.convertAndSend("sbeam-delayed-exchange", "key3", message, messagePostProcessor -> {
            messagePostProcessor.getMessageProperties().setDelayLong(900000L); // 15分钟 = 900000毫秒
            return messagePostProcessor;
        });
        System.out.println("订单超时消息已发送，订单ID: " + orderId + "，将在15分钟后检查");
    }
}