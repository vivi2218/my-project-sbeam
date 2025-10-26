package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.entity.Cart;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.OrderDetails;
import com.sbeam.sbeam.mapper.CartMapper;
import com.sbeam.sbeam.mapper.GameMapper;
import com.sbeam.sbeam.mapper.MyorderMapper;
import com.sbeam.sbeam.mapper.OrderDetailsMapper;
import com.sbeam.sbeam.service.IMyorderService;
import com.sbeam.sbeam.util.Result;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import static io.lettuce.core.pubsub.PubSubOutput.Type.message;

@Service
public class MyorderServiceImpl extends ServiceImpl<MyorderMapper, Myorder> implements IMyorderService {
    @Autowired
    private MyorderMapper myorderMapper;
    @Autowired
    private OrderDetailsMapper orderDetailsMapper;
    @Autowired
    private CartMapper cartMapper;
    @Autowired
    private GameMapper gameMapper;
    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Override
    public List<Myorder> getOrdersByUserId(Integer userId) {
        QueryWrapper<Myorder> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.orderByDesc("order_date");
        return baseMapper.selectList(queryWrapper);
    }

    @Override
    public List<Myorder> getOrdersByUserIdAndStatus(Integer userId, String status) {
        QueryWrapper<Myorder> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.eq("order_status", status);
        queryWrapper.orderByDesc("order_date");
        return baseMapper.selectList(queryWrapper);
    }

    @Override
    public boolean cancelOrder(Integer orderId) {
        Myorder order = baseMapper.selectById(orderId);
        if (order == null) {
            return false;
        }

        // 只有待支付状态可以取消
        if ("待支付".equals(order.getOrderStatus())) {
            order.setOrderStatus("已取消");
            order.setUpdatedAt(LocalDateTime.now());
            return baseMapper.updateById(order) > 0;
        }
        return false;
    }

    @Override
    public boolean deleteOrder(Integer orderId) {
        // 实际项目中可能需要逻辑删除
        return baseMapper.deleteById(orderId) > 0;
    }

    @Override
    public Result createOrder(Integer userId,BigDecimal finalPrice) {
        //防止重复提交订单
        String lockKey = "order_lock"+userId;
        String orderKey = "processing_order:" + userId;
        if(redisTemplate.hasKey(orderKey)){
            return Result.getFail("您有订单正在处理中，请稍后");
        }

        //获取分布式锁
        Boolean lockAcquired = redisTemplate.opsForValue().setIfAbsent(lockKey, "lock", 30, TimeUnit.SECONDS);
        if(!lockAcquired){
            return Result.getFail("操作过于频繁,请稍后重试");
        }

        //try

        List<Cart> cartList = cartMapper.selectList(new QueryWrapper<Cart>().eq("user_id", userId)
                                                                            .eq("status",0));// 只查询正常状态的购物车项
        if(cartList.isEmpty()){
            return Result.getFail("购物车中没有游戏");
        }
        //计算订单original_Price
        //计算订单final_Price
        //计算订单总价
// 核心：用 Optional 把 null 转为 BigDecimal.ZERO（0值，不影响累加结果）
        BigDecimal originalPrice = cartList.stream()
                .map(cart -> Optional.ofNullable(cart.getGamePrice()).orElse(BigDecimal.ZERO))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
// 创建订单

        Myorder myorder = new Myorder();
        myorder.setUserId(userId);
        myorder.setOrderNumber("ORDER-" + UUID.randomUUID().toString());
        myorder.setOriginalPrice(originalPrice);// 计算原价
        myorder.setFinalPrice(finalPrice); // 最终支付价格
        myorder.setOrderDate(LocalDateTime.now());
        myorder.setOrderStatus("unpaid");// 初始订单状态为未支付
        myorder.setVersion(1);
        myorder.setStatus(0);
        myorder.setCreatedAt(LocalDateTime.now());

        //保存订单
        myorderMapper.insert(myorder);
        System.out.println("生成我的订单:"+myorder);
        //创建订单详情
        ArrayList<OrderDetails> orderDetailsList = new ArrayList<>();
        for(Cart cart : cartList){
            OrderDetails orderDetails = new OrderDetails();
            orderDetails.setOrderId(myorder.getOrderId());
            orderDetails.setUserId(userId);
            orderDetails.setGameId(cart.getGameId());
            orderDetails.setDiscountId(cart.getSalesId());
            orderDetails.setStatus(0);
            orderDetails.setVersion(1);
            orderDetails.setCreatedAt(LocalDateTime.now());
            //保存订单详情
            int rows = orderDetailsMapper.insert(orderDetails);
            boolean add = orderDetailsList.add(orderDetails);
//            if(rows>0){
//                //订单创建成功后发送消息到队列
//                sendOrderToQueue(myorder.getOrderId());
//
//            }
            if(add)
                System.out.println("Order保存添加订单详情成功!!!!");
        }
            // 标记购物车项为已下单状态（可选）  没有支付成功就先不改
             //cartMapper.updateCartStatus(cartItems.stream().map(Cart::getCartId).collect(Collectors.toList()), 1);

            //设置处理中订单标记(15分钟过期)
            redisTemplate.opsForValue().set(orderKey,myorder.getOrderId(),15,TimeUnit.MINUTES);
            //发送延迟消息到RabbitMQ进行超时取消
            sendOrderTimeoutMessage(myorder.getOrderId());
            System.out.println("订单创建成功,订单号:"+myorder.getOrderNumber());
            HashMap<String, Object> result = new HashMap<>();
            result.put("order",myorder);
            result.put("orderDetails",orderDetailsList);
            if(result!=null){
                return Result.saveSuccess(result);
            }
        return Result.saveFail(null);
            //可以finally 释放分布式锁 主动释放资源
        //redisTemplate.delete(lockKey);
    }

    @Override
    public Result getByOrderNumber(String orderNum) {
        QueryWrapper<Myorder> wrapper = new QueryWrapper<>();
        wrapper.eq("order_number",orderNum);
        Myorder myorder = myorderMapper.selectOne(wrapper);
        if(myorder !=null)
            return Result.getSuccess(myorder);
        return Result.getFail(orderNum);
    }

    //发送订单超时消息

    private void sendOrderTimeoutMessage(Integer orderId){
        HashMap<String, Object> message = new HashMap<>();
        message.put("orderId",orderId);
        message.put("timestamp",System.currentTimeMillis());

        //设置15分钟过期时间
        rabbitTemplate.convertAndSend("orderTimeoutExchange", "order.timeout", message, messagePostProcessor -> {
            messagePostProcessor.getMessageProperties().setExpiration("900000"); // 15分钟
            return messagePostProcessor;
        });
        System.out.println("订单超时消息已发送，订单ID: " + orderId);
    }
    //处理订单支付成功
    @Override
    public Result confirmPayment(Integer orderId){
        Myorder myorder = myorderMapper.selectById(orderId);
        if(myorder == null){
            return Result.getFail("dingdan 不存在");
        }
        if(!"unpaid".equals(myorder.getOrderStatus())){
            return Result.getFail("dingdan 状态异常");
        }
        //更新订单状态为已支付
        myorder.setOrderStatus("paid");
        myorder.setUpdatedAt(LocalDateTime.now());
        myorderMapper.updateById(myorder);

        //移除处理中订单标记
        //String orderKey = "processing_order:" + myorder.getUserId();
        //redisTemplate.delete(orderKey);

        //可以添加其他业务处理,如库存扣减,发放游戏
        return Result.updateSuccess("支付成功");
    }

    //处理订单超时取消
    @Override
    public void cancelOrderDueToTimeout(Integer orderId){
        Myorder order = myorderMapper.selectById(orderId);
        if(order !=null && "unpaid".equals(order.getOrderStatus())){
            //更新订单状态为已取消
            order.setOrderStatus("cancelled");
            order.setUpdatedAt(LocalDateTime.now());
            myorderMapper.updateById(order);

            //移除处理中订单标记
            //String orderKey = "processing_order:" + order.getUserId();
            //redisTemplate.delete(orderKey);

            System.out.println("订单超时自动取消，订单ID: " + orderId);
        }
    }

    //发送订单ID到RabbitMQ队列
    private void sendOrderToQueue(Integer orderId){
        // 设置消息的过期时间为7天（TTL）
        rabbitTemplate.convertAndSend("orderExchange", "orderkey", message, messagePostProcessor -> {
            messagePostProcessor.getMessageProperties().setExpiration("604800000");  // 7天的TTL（毫秒）
            return messagePostProcessor;
        });

        System.out.println("Order " + orderId + " sent to queue for migration");
    }


}
