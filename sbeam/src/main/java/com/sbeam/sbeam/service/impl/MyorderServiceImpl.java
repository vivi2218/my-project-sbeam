package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.entity.Cart;
import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.OrderDetails;
import com.sbeam.sbeam.entity.Sales;
import com.sbeam.sbeam.entity.VO.OrderGameVO;
import com.sbeam.sbeam.mapper.*;
import com.sbeam.sbeam.service.IMyorderService;
import com.sbeam.sbeam.service.MqSender;
import com.sbeam.sbeam.util.RedisLuaExecutor;
import com.sbeam.sbeam.util.Result;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
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
    private SalesMapper salesMapper;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Autowired
    private RedisLuaExecutor redisLuaExecutor;
    @Autowired
    private MqSender mqSender;
    @Override
    public List<OrderGameVO> getOrdersByUserId(Integer userId) {
        // 创建查询条件
        QueryWrapper<Myorder> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.eq("status", 0);
        // 根据订单日期降序排序，最近的订单排在前面
        queryWrapper.orderByDesc("order_date");
        
        // 查询用户的订单列表
        List<Myorder> orders = myorderMapper.selectList(queryWrapper);
        
        // 返回包含游戏信息的封装类
        List<OrderGameVO> orderGameList = new ArrayList<>();
        for (Myorder order : orders) {
            OrderGameVO orderGameVO = new OrderGameVO();
            // 复制订单基本信息
            BeanUtils.copyProperties(order, orderGameVO);
            
            // 查询订单详情获取所有关联的游戏ID（一个订单可能包含多个游戏）
            QueryWrapper<OrderDetails> detailsWrapper = new QueryWrapper<>();
            detailsWrapper.eq("order_id", order.getOrderId());
            List<OrderDetails> orderDetailsList = orderDetailsMapper.selectList(detailsWrapper);
            
            if (!orderDetailsList.isEmpty()) {
                // 对于包含多个游戏的订单，我们可以处理第一个游戏信息，或者在VO中添加游戏列表
                // 这里我们处理第一个游戏信息作为示例
                OrderDetails firstOrderDetail = orderDetailsList.get(0);
                if (firstOrderDetail.getGameId() != null) {
                    // 查询游戏信息
                    Game game = gameMapper.selectById(firstOrderDetail.getGameId());
                    if (game != null) {
                        orderGameVO.setGameId(game.getGameId());
                        orderGameVO.setGameName(game.getGameName());
                        orderGameVO.setGameImageUrl(game.getMainImageUrl());
                        // 计算游戏单价（这里简化处理，实际可能需要根据订单详情中的数量等信息计算）
                        orderGameVO.setGamePrice(order.getFinalPrice());
                    }
                }
            }
            
            orderGameList.add(orderGameVO);
        }
        return orderGameList;
    }

    @Override
    public List<OrderGameVO> getOrdersByUserIdAndStatus(Integer userId, String status) {
        QueryWrapper<Myorder> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.eq("order_status", status);
        queryWrapper.orderByDesc("order_date");
        
        // 获取符合状态的订单列表
        List<Myorder> orders = baseMapper.selectList(queryWrapper);
        List<OrderGameVO> orderGameVOList = new ArrayList<>();
        
        // 处理每个订单，添加游戏信息
        for (Myorder order : orders) {
            OrderGameVO orderGameVO = new OrderGameVO();
            // 复制订单基本信息
            BeanUtils.copyProperties(order, orderGameVO);
            
            // 查询订单详情列表
            List<OrderDetails> orderDetailsList = orderDetailsMapper.selectList(
                    new QueryWrapper<OrderDetails>().eq("order_id", order.getOrderId()));
            
            // 如果订单详情存在，获取第一个游戏的信息
            if (orderDetailsList != null && !orderDetailsList.isEmpty()) {
                OrderDetails orderDetails = orderDetailsList.get(0);
                // 查询游戏信息
                Game game = gameMapper.selectById(orderDetails.getGameId());
                if (game != null) {
                    orderGameVO.setGameId(game.getGameId());
                    orderGameVO.setGameName(game.getGameName());
                    orderGameVO.setGameImageUrl(game.getMainImageUrl());
                    orderGameVO.setGamePrice(game.getGameOriginalPrice());
                }
            }
            
            orderGameVOList.add(orderGameVO);
        }
        
        return orderGameVOList;
    }

    @Override
    public boolean cancelOrder(Integer orderId) {
        Myorder order = baseMapper.selectById(orderId);
        if (order == null) {
            return false;
        }

        // 只有待支付状态可以取消
        if ("unpaid".equals(order.getOrderStatus())) {
            order.setOrderStatus("cancelled");
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
    public Result createOrder(Integer userId) {

        List<Cart> cartList = cartMapper.selectList(new QueryWrapper<Cart>().eq("user_id", userId)
                                                                            .eq("status",0));// 只查询正常状态的购物车项
        if(cartList.isEmpty()){
            return Result.getFail("购物车中没有游戏");
        }
        //2.扣减库存(Lua原子)
        for(Cart cart:cartList){
            String stockKey = "game:stock:" + cart.getGameId();
            // 扣减库存
            Long res = redisLuaExecutor.execute("script\\decr_stock.lua", Long.class, stockKey, 1);
            if(res == null || res <= 0){
                //redis扣减失败 ->秒杀失败
                return Result.getFail("游戏【" + cart.getGameId() + "】库存不足");
            }
        }
            //redis扣减成功 ->秒杀成功
        //发送MQ下单事件,异步处理Mysql写入
        mqSender.sendOrderEvent(userId,cartList);
        return Result.saveSuccess("秒杀成功,正在生成订单");
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

    //发送订单到延时队列
    private void sendOrderTimeoutMessage(Integer orderId){
        HashMap<String, Object> message = new HashMap<>();
        message.put("orderId",orderId);
        message.put("timestamp",System.currentTimeMillis());

        //设置15分钟延迟时间
        rabbitTemplate.convertAndSend("sbeam-delayed-exchange", "key3", message, messagePostProcessor -> {
            messagePostProcessor.getMessageProperties().setDelayLong(900000L); // 15分钟
            return messagePostProcessor;
        });
        System.out.println("订单延时消息已发送，订单ID: " + orderId);
    }
    //处理订单支付成功
    @Override
    public Result confirmPayment(Integer orderId){
        Myorder myorder = myorderMapper.selectById(orderId);
        if(myorder == null || !"unpaid".equals(myorder.getOrderStatus())){
            return Result.getFail("订单 状态异常");
        }
        //更新订单状态为已支付
        myorder.setOrderStatus("paid");
        myorder.setUpdatedAt(LocalDateTime.now());
        myorderMapper.updateById(myorder);

        //可以添加其他业务处理,如库存扣减,绑定激活码,发放激活码
        return Result.updateSuccess(myorder);
    }
    //获得最新的一条订单
    @Override
    public Myorder getLasterOrder(Integer userId) {
        return myorderMapper.findLatestByuserId(userId);
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

            //回滚库存
            List<OrderDetails> details = orderDetailsMapper.selectList(
                    new QueryWrapper<OrderDetails>().eq("order_id", orderId)
            );
            for(OrderDetails od:details){
                String stockKey = "game:stock:"+od.getGameId();
                redisLuaExecutor.execute("script/rollback_stock.lua", Long.class,stockKey,1);
            }
            System.out.println("订单超时自动取消，库存已回滚：订单ID: " + orderId);
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
}
