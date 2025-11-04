package com.sbeam.sbeam.controller;



import com.sbeam.sbeam.interceptor.AutoIdempotent;
import com.sbeam.sbeam.util.JWTUtils;
import com.sbeam.sbeam.util.Result;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */

import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.service.IMyorderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/myorder")
@CrossOrigin
public class MyorderController {


    @Autowired
    private IMyorderService myorderService;
    @Autowired
    private JWTUtils jwtUtils;

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

    /**
     * 创建订单
     * @param
     * @return
     */
    //localhost:8080/myorder/create/20     URL 示例为 POST /create/123，请求体（Body）中传递 99.99
    // （需符合 JSON 格式，如 99.99 或 "99.99"）。
    @PostMapping("/create")
    @AutoIdempotent
    public Result createOrder(@RequestHeader("Authorization") String token){
        Integer userId = jwtUtils.getUserId(token).intValue();
        return myorderService.createOrder(userId);
    }
}

