package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.Cart;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sbeam.sbeam.util.Result;

import java.math.BigDecimal;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface ICartService extends IService<Cart> {
    //添加游戏到购物车
    public Result addGameToCart(int userId, int gameId, BigDecimal gamePrice);

}
