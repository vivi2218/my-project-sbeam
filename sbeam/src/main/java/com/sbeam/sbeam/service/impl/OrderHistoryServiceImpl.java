package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.OrderHistory;
import com.sbeam.sbeam.mapper.MyorderMapper;
import com.sbeam.sbeam.mapper.OrderHistoryMapper;
import com.sbeam.sbeam.service.IOrderHistoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author smith
 * @since 2025-10-31
 */
@Service
public class OrderHistoryServiceImpl extends ServiceImpl<OrderHistoryMapper, OrderHistory> implements IOrderHistoryService {
    @Autowired
    private MyorderMapper myorderMapper;

    @Transactional
    public void moveOldOrdersToHistory(){
        //查询过期订单
        List<Myorder> oldMyorders = myorderMapper.selectOldOrders();
        if(oldMyorders.isEmpty()) return;
        //插入历史表
        myorderMapper.insertOrderHistory(oldMyorders);
        //删除原表
        List<Integer> orderIds = oldMyorders.stream()
                .map(o -> (Integer) o.getOrderId())
                .collect(Collectors.toList());
        myorderMapper.deleteOlders(orderIds);
    }
}
