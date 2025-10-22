package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sbeam.sbeam.entity.Cart;
import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.mapper.CartMapper;
import com.sbeam.sbeam.mapper.GameMapper;
import com.sbeam.sbeam.service.ICartService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09

 */
@Service
public class CartServiceImpl extends ServiceImpl<CartMapper, Cart> implements ICartService {
    @Autowired
    private CartMapper cartMapper;
    @Autowired
    private GameMapper gameMapper;
    @Override
    public Result addGameToCart(int userId, int gameId, BigDecimal gamePrice) {
        // 查询是否已经添加了该游戏
        Cart cart = cartMapper.selectOne(new QueryWrapper<Cart>().eq("user_id", userId)
                .eq("game_id", gameId));
        if(cart !=null){
            return Result.getFail("游戏已经在购物车里");
        }
        //获取游戏详细信息
        Game game = gameMapper.selectById(gameId);
        if(game == null){
            return Result.getFail("未发现游戏");
        }
        //创建购物车
        Cart cart1 = new Cart();
        cart1.setUserId(userId);
        cart1.setGameId(gameId);
        cart1.setGameName(game.getGameName());
        cart1.setGamePrice(gamePrice);
        //cart1.setSalesId(game.);//可选的折扣ID
        cart1.setStatus(0);//默认为正常
        cart1.setCreatedAt(LocalDateTime.now());
        cart1.setUpdatedAt(LocalDateTime.now());
        //保存到数据库
        int rows = cartMapper.insert(cart1);
        if(rows>0){
            return Result.saveSuccess(cart1);
        }
        return Result.saveFail(null);

    }
}
