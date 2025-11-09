package com.sbeam.sbeam.config;

import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.mapper.GameMapper;
import com.sbeam.sbeam.service.IGameService;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class GameStockInitializer {

    @Autowired
    private IGameService gameService;

    @Autowired
    private RedisTemplate redisTemplate;

    @PostConstruct
    public void initStockToRedis() {
        List<Game> gameList = gameService.listAllGames();// 查询所有游戏
        for (Game game : gameList) {
            if (game.getRemainStock() != null) {
                String key = "game:stock:" + game.getGameId();
                redisTemplate.opsForValue().setIfAbsent(key, game.getRemainStock());
                System.out.println("✅ 初始化 Redis 库存: " + key + " = " + game.getRemainStock());
            }
        }
        System.out.println("✅ 游戏库存初始化完成！");
    }
}
