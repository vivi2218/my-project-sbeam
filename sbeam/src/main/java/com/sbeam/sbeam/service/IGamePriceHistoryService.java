package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.GamePriceHistory;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *

 * @author yourname
 * @since 2025-10-09

 */
public interface IGamePriceHistoryService extends IService<GamePriceHistory> {
    List<GamePriceHistory> getPriceHistory(Integer gameId); // 按游戏ID查历史价格
    List<GamePriceHistory> getValidDiscounts(Integer gameId); // 查有效优惠

}
