package com.sbeam.sbeam.controller;


import com.sbeam.sbeam.entity.Cart;
import com.sbeam.sbeam.service.ICartService;
import com.sbeam.sbeam.util.JWTUtils;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@CrossOrigin
@RestController
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private ICartService cartService;

    @Autowired
    private JWTUtils jwtUtils;


    @GetMapping()
    public List<Cart> getCart(@RequestHeader("Authorization") String token) {

        Long userId = jwtUtils.getUserId(token);
        if (userId == null) {
            return List.of(); // 或者返回 401
        }
        // 只查询状态为0（正常）的购物车项
        return cartService.query()
                .eq("user_Id", userId)
                .eq("status", 0)
                .list();
    }





    @PostMapping("/add")
    public Result addGameToCart(
            @RequestHeader("Authorization") String token,
            @RequestParam int gameId,
            @RequestParam BigDecimal gamePrice) {

        if (token == null || token.isEmpty()) {
            return Result.getFail("未登录或 token 缺失");
        }

        Long userId;
        try {
            userId = jwtUtils.getUserId(token);
        } catch (Exception e) {
            return Result.getFail("登录已过期，请重新登录");
        }

        if (userId == null) {
            return Result.getFail("登录已过期，请重新登录");
        }


        return cartService.addGameToCart(userId.intValue(), gameId, gamePrice);
    }

    /**
     * 删除购物车商品（逻辑删除，将status改为1）
     */
    @DeleteMapping("/{cartId}")
    public boolean deleteCartItem(@PathVariable Integer cartId, @RequestHeader("Authorization") String token) {
        // 验证用户身份
        Long userId = jwtUtils.getUserId(token);
        if (userId == null) {
            return false;
        }
        
        // 执行逻辑删除
        return cartService.update()
                .set("status", 1)
                .eq("cart_id", cartId)
                .eq("user_id", userId)
                .update();
    }


}
