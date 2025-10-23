package com.sbeam.sbeam.controller;


import com.sbeam.sbeam.entity.Cart;
import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.service.ICartService;
import com.sbeam.sbeam.util.Result;
import com.sbeam.sbeam.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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


    @GetMapping()
    public List<Cart> getCart(@RequestHeader("Authorization") String token) {

        Long userId = JwtUtils.getUserId(token);
        if (userId == null) {
            return List.of(); // 或者返回 401
        }
        return cartService.lambdaQuery().eq(Cart::getUserId, userId).list();
    }




    @PostMapping("/add")
    public Result addGameToCart(
            @RequestHeader("Authorization") String token,
            @RequestParam int gameId,
            @RequestParam BigDecimal gamePrice) {
        Long userId = JwtUtils.getUserId(token);
        return cartService.addGameToCart(userId.intValue(), gameId, gamePrice);
    }

}
