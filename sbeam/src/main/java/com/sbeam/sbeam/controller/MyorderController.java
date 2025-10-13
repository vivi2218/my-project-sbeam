package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.service.IMyorderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/myorder")
@CrossOrigin
public class MyorderController {

    @Autowired
    private IMyorderService myorderService;

    /**
     * 查询用户所有订单
     */
    @GetMapping("/user/{userId}")
    public List<Myorder> getUserAllOrders(@PathVariable Integer userId) {
        return myorderService.getOrdersByUserId(userId);
    }

    /**
     * 查询用户特定状态的订单
     * 状态包括：待支付、已取消、待点评、已完成
     */
    @GetMapping("/user/{userId}/status/{status}")
    public List<Myorder> getUserOrdersByStatus(
            @PathVariable Integer userId,
            @PathVariable String status) {
        return myorderService.getOrdersByUserIdAndStatus(userId, status);
    }

    /**
     * 取消订单
     */
    @PutMapping("/cancel/{orderId}")
    public boolean cancelOrder(@PathVariable Integer orderId) {
        return myorderService.cancelOrder(orderId);
    }

    /**
     * 删除订单
     */
    @DeleteMapping("/{orderId}")
    public boolean deleteOrder(@PathVariable Integer orderId) {
        return myorderService.deleteOrder(orderId);
    }
}