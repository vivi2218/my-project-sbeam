package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.mapper.MyorderMapper;
import com.sbeam.sbeam.service.IMyorderService;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class MyorderServiceImpl extends ServiceImpl<MyorderMapper, Myorder> implements IMyorderService {

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
}