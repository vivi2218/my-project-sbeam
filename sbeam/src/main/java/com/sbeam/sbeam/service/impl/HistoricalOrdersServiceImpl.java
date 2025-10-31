package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sbeam.sbeam.entity.HistoricalOrders;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.OrderDetails;
import com.sbeam.sbeam.mapper.HistoricalOrdersMapper;
import com.sbeam.sbeam.mapper.MyorderMapper;
import com.sbeam.sbeam.mapper.OrderDetailsMapper;
import com.sbeam.sbeam.service.IHistoricalOrdersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.util.Result;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class HistoricalOrdersServiceImpl extends ServiceImpl<HistoricalOrdersMapper, HistoricalOrders> implements IHistoricalOrdersService {
    @Autowired
    private MyorderMapper myorderMapper;
    @Autowired
    private HistoricalOrdersMapper historicalOrdersMapper;
    @Autowired
    private OrderDetailsMapper orderDetailsMapper;

    public void migrateOrder(Integer orderId) {
        // 获取订单信息
        Myorder order = myorderMapper.selectById(orderId);

        if (order == null) {
            System.out.println("Order not found with ID: " + orderId);
            return;
        }

        // 判断订单是否已经超过7天，如果是，则进行迁移
        if (order.getCreatedAt().plusDays(7).isBefore(LocalDateTime.now())) {
            // 迁移订单到历史订单表

            HistoricalOrders historicalOrder = new HistoricalOrders();
            historicalOrder.setOrderId(order.getOrderId());
            historicalOrder.setUserId(order.getUserId());
            historicalOrder.setOrderNumber(order.getOrderNumber());
            historicalOrder.setOriginalPrice(order.getOriginalPrice());
            historicalOrder.setFinalPrice(order.getFinalPrice());
            historicalOrder.setOrderDate(order.getCreatedAt());
            historicalOrder.setStatus(1);  // 迁移后的订单状态
            historicalOrder.setCreatedAt(LocalDateTime.now());
            historicalOrder.setUpdatedAt(LocalDateTime.now());

            // 插入历史订单表
            historicalOrdersMapper.insert(historicalOrder);

            // 更新原订单状态为已归档
            order.setOrderStatus("已归档");
            myorderMapper.updateById(order);

            System.out.println("Order " + orderId + " has been archived and moved to historical orders.");
        } else {
            System.out.println("Order " + orderId + " is not older than 7 days and will not be archived.");
        }
    }

    @Override
    public Result getHistoricalOrder(int orderId) {
        // 查询历史订单
        HistoricalOrders historicalOrders = historicalOrdersMapper.selectById(orderId);
        if (historicalOrders == null) {
            return Result.getFail("Historical order not found");
        }

        // 查询订单详情
        List<OrderDetails> orderDetails = orderDetailsMapper.selectList(new QueryWrapper<OrderDetails>().eq("order_id", orderId));

        // 返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("order", historicalOrders);
        result.put("orderDetails", orderDetails);

        return Result.getSuccess(result);
    }
}
