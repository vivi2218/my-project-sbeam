package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.Myorder;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface IMyorderService extends IService<Myorder> {
    //根据用户ID查询所有订单
    List<Myorder> getOrdersByUserId(Integer userId);
    // 根据用户ID和订单状态查询订单
    List<Myorder> getOrdersByUserIdAndStatus(Integer userId, String status);

    // 取消订单
    boolean cancelOrder(Integer orderId);

    // 删除订单
    boolean deleteOrder(Integer orderId);
}
