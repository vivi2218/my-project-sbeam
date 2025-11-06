package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.VO.OrderGameVO;
import com.sbeam.sbeam.interceptor.AutoIdempotent;
import com.sbeam.sbeam.service.IMyorderService;
import com.sbeam.sbeam.util.JWTUtils;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */

@RestController
@RequestMapping("/myorder")
@CrossOrigin
public class MyorderController {


    @Autowired
    private IMyorderService myorderService;

    // 普通用户只能查看自己的订单，管理员可以查看所有订单
    @Autowired
    private JWTUtils jwtUtils;

     @GetMapping("/user/{userId}")
     public List<OrderGameVO> getUserAllOrders(@PathVariable Integer userId,
                                               @RequestHeader("Authorization") String authHeader) {
         // 获取当前登录用户ID和角色
    //     String token = authHeader.substring(7);
    //     String currentUserId = jwtUtils.getUserIdFromToken(token);
    //     String role = jwtUtils.getUserRoleFromToken(token);

    //     // 非管理员只能查看自己的订单
    //     if (!"admin".equals(role) && !currentUserId.equals(userId.toString())) {
    //         throw new RuntimeException("无权访问其他用户的订单");
    //     }

        return myorderService.getOrdersByUserId(userId);
     }
      
     /**
      * 根据用户ID和订单状态筛选订单
      * 返回包含游戏信息的订单列表
      */
     @GetMapping("/user/{userId}/status/{status}")
     public List<OrderGameVO> getUserOrdersByStatusAndId(@PathVariable Integer userId,
                                                     @PathVariable String status,
                                                     @RequestHeader("Authorization") String authHeader) {
         // 获取当前登录用户ID和角色
    //     String token = authHeader.substring(7);
    //     String currentUserId = jwtUtils.getUserIdFromToken(token);
    //     String role = jwtUtils.getUserRoleFromToken(token);

    //     // 非管理员只能查看自己的订单
    //     if (!"admin".equals(role) && !currentUserId.equals(userId.toString())) {
    //         throw new RuntimeException("无权访问其他用户的订单");
    //     }

        return myorderService.getOrdersByUserIdAndStatus(userId, status);
     }


    /**
     * 查询用户特定状态的订单
     * 状态包括：待支付、已取消、待点评、已完成
     */
    @GetMapping("/status/{status}")
    public List<OrderGameVO> getUserOrdersByStatus(
            @RequestHeader("Authorization") String token,
            @PathVariable String status) {
        Integer userId = jwtUtils.getUserId(token).intValue();
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
     * 根据订单ID获取订单详情
     * @param orderId 订单ID
     * @return 订单信息
     */
    @GetMapping("/{orderId}")
    public Myorder getOrderById(@PathVariable Integer orderId) {
        return myorderService.getById(orderId);
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
    
    /**
     * 验证订单是否有效
     * @param orderNumber 订单号
     * @param token 用户令牌
     * @return 是否有效
     */
    @GetMapping("/validate")
    public Result validateOrder(@RequestParam String orderNumber, @RequestHeader("Authorization") String token) {
        try {
            Integer userId = jwtUtils.getUserId(token).intValue();
            // 查询订单
            Result result = myorderService.getByOrderNumber(orderNumber);
            if (result.getCode() == 200 && result.getData() != null) {
                Myorder order = (Myorder) result.getData();
                // 验证订单是否属于当前用户，且状态为未支付
                if (order.getUserId().equals(userId) && "unpaid".equals(order.getOrderStatus())) {
                    // 计算订单是否已过期（15分钟内有效）
                    LocalDateTime orderTime = order.getOrderDate();
                    LocalDateTime now = LocalDateTime.now();
                    long minutes = ChronoUnit.MINUTES.between(orderTime, now);
                    if (minutes < 15) {
                        return Result.getSuccess(true);
                    }
                }
            }
            return Result.getSuccess(false);
        } catch (Exception e) {
            System.out.println("验证订单失败: " + e.getMessage());
            return Result.getSuccess(false);
        }
    }
}

