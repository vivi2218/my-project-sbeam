package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.VO.OrderGameVO;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sbeam.sbeam.util.Result;

import java.math.BigDecimal;
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
    List<OrderGameVO> getOrdersByUserId(Integer userId);
    // 根据用户ID和订单状态查询订单
    List<OrderGameVO> getOrdersByUserIdAndStatus(Integer userId, String status);

    // 取消订单
    boolean cancelOrder(Integer orderId);

    // 删除订单
    boolean deleteOrder(Integer orderId);

    //创建订单
    public Result createOrder(Integer userId);
    //订单编号查询订单
    public Result getByOrderNumber(String orderNum);
    //处理订单超时取消
    public void cancelOrderDueToTimeout(Integer orderId);
    //处理订单支付成功

    public Result confirmPayment(Integer orderId);
}
