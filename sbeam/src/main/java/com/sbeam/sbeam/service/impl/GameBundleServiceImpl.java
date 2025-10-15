package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sbeam.sbeam.entity.GameBundle;
import com.sbeam.sbeam.mapper.GameBundleMapper;
import com.sbeam.sbeam.service.IGameBundleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class GameBundleServiceImpl extends ServiceImpl<GameBundleMapper, GameBundle> implements IGameBundleService {

    @Autowired
    GameBundleMapper gameBundleMapper;
//    @Autowired
//    RedisTemplate redisTemplate;
    // Redis缓存键前缀
    private static final String GAME_BUNDLE_KEY = "game:bundle:";
    @Override
    public List<GameBundle> getBundlesByGameId(Integer gameId,Integer status) {

//        // 构建缓存键，包含gameId和status作为唯一标识
//        String cacheKey = GAME_BUNDLE_KEY + "gameId:" + gameId + ":status:" + status;
//
//        // 先从Redis查询缓存
//        List<GameBundle> bundles = (List<GameBundle>) redisTemplate.opsForValue().get(cacheKey);
//
//        // 如果缓存存在，直接返回
//        if (bundles != null && !bundles.isEmpty()) {
//            return bundles;
//        }

        // 缓存不存在，从数据库查询
        QueryWrapper<GameBundle> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("game_id", gameId)
                .eq(status != null, "status", status); // 状态不为null时才添加条件

        List<GameBundle> bundles = gameBundleMapper.selectList(queryWrapper);
//        bundles = bundles;

//        // 将查询结果存入Redis，设置过期时间为1小时
//        if (bundles != null) {
//            redisTemplate.opsForValue().set(cacheKey, bundles, 1, TimeUnit.HOURS);
//        }

        return bundles;
    }
}
