package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sbeam.sbeam.entity.GamePriceHistory;
import com.sbeam.sbeam.mapper.GamePriceHistoryMapper;
import com.sbeam.sbeam.service.IGamePriceHistoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class GamePriceHistoryServiceImpl extends ServiceImpl<GamePriceHistoryMapper, GamePriceHistory> implements IGamePriceHistoryService {

    @Autowired
    private GamePriceHistoryMapper gamePriceHistoryMapper;
    @Override
    //// 按游戏ID查历史价格
    public List<GamePriceHistory> getPriceHistory(Integer gameId) {
        QueryWrapper<GamePriceHistory> wrapper = new QueryWrapper<>();
        wrapper.eq("game_id", gameId)
                .orderByAsc("lowest_price_time"); // 按最低价时间升序（展示价格趋势）
        return list(wrapper);
    }
    // 查有效优惠
    @Override
    public List<GamePriceHistory> getValidDiscounts(Integer gameId) {
        Date now = new Date();
        QueryWrapper<GamePriceHistory> wrapper = new QueryWrapper<>();
        wrapper.eq("game_id", gameId)
                .eq("status", 0) // 0状态为“有效”
                .ge("next_discount_time", now); // 下次折扣时间 >= 当前时间（未过期）
        return list(wrapper);
    }
}
