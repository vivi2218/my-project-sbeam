package com.sbeam.sbeam.controller;


import com.sbeam.sbeam.entity.GamePriceHistory;
import com.sbeam.sbeam.service.IGamePriceHistoryService;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
@RequestMapping("/gamePriceHistory")
public class GamePriceHistoryController {
    @Autowired
    private IGamePriceHistoryService gamePriceHistoryService;
    // 接口1：查询游戏历史价格（按时间排序），
    // 示例URL：http://localhost:8080/gamePriceHistory/history/1
    @GetMapping("/history/{gameId}")
    public Result getHistoryByGameId(@PathVariable Integer gameId) {
        List<GamePriceHistory> priceHistoryList = gamePriceHistoryService.getPriceHistory(gameId);
        if(priceHistoryList != null && !priceHistoryList.isEmpty())
            return Result.getSuccess(priceHistoryList);
        return Result.getFail(priceHistoryList);

    }

    // 接口2：查询有效优惠，
    // 示例URL：http://localhost:8080/gamePriceHistory/discounts/1
    @GetMapping("/discounts/{gameId}")
    public Result getValidDiscounts(@PathVariable Integer gameId) {
        List<GamePriceHistory> validDiscounts = gamePriceHistoryService.getValidDiscounts(gameId);
        if(validDiscounts != null && !validDiscounts.isEmpty())
            return Result.getSuccess(validDiscounts);
        return Result.getFail(validDiscounts);
    }
}
