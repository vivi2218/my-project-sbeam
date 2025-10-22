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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

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
    public Result createOrder(Integer cartId) {
        //防止重复提交订单
        String lockKey = "lock_create_order"+cartId;
        if(redisTemplate.hasKey(lockKey)){
            return Result.getFail("已存在订单");
        }
        redisTemplate.opsForValue().set(lockKey,"lock",15, TimeUnit.MINUTES);

        List<Cart> cartList = cartMapper.selectList(new QueryWrapper<Cart>().eq("cart_id", cartId));
        if(cartList.isEmpty()){
            return Result.getFail("购物车中没有游戏");
        }
        //获取用户Id
        Integer userId = cartList.get(0).getUserId();
        //获取游戏id
        //Integer gameId = cartList.get(0).getGameId();
        //计算订单总价
        BigDecimal originalPrice = cartList.stream()
                .map(cart -> cart.getGamePrice())
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        //创建订单

        Myorder myorder = new Myorder();
        myorder.setUserId(userId);
        myorder.setCartId(cartId);
        myorder.setOrderNumber("ORDER-" + UUID.randomUUID().toString());
        myorder.setOriginalPrice(originalPrice);// 计算原价
        myorder.setFinalPrice(originalPrice); // 最终支付价格
        myorder.setOrderStatus("unpaid");// 初始订单状态为未支付
        myorder.setCreatedAt(LocalDateTime.now());

        //保存订单
        myorderMapper.insert(myorder);
        //创建订单详情
        for(Cart cart : cartList){
            OrderDetails orderDetails = new OrderDetails();
            orderDetails.setOrderId(myorder.getOrderId());
            orderDetails.setUserId(userId);
            orderDetails.setGameId(cart.getGameId());
            //orderDetails.setDiscountId(1);
            orderDetails.setStatus(0);
            orderDetails.setVersion(1);
            orderDetails.setCreatedAt(LocalDateTime.now());
            //保存订单详情
            int rows = orderDetailsMapper.insert(orderDetails);
            if(rows>0){
                return Result.saveSuccess(orderDetails);
            }

        }
        return Result.saveFail(null);
    }
}
