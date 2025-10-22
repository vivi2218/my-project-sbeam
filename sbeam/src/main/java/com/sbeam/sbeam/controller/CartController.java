package com.sbeam.sbeam.controller;


import com.sbeam.sbeam.service.ICartService;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/cart")
public class CartController {
    @Autowired
    private ICartService cartService;
    @PostMapping("/add")
    public Result addGameToCart(@RequestParam int userId,@RequestParam int gameId, @RequestParam BigDecimal gamePrice){
        return cartService.addGameToCart(userId, gameId, gamePrice);
    }
}
