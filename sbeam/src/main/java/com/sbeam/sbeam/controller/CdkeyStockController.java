package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.CdkeyStock;
import com.sbeam.sbeam.service.ICdkeyStockService;
import com.sbeam.sbeam.service.IGameService;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * <p>
 * CDKey库存表 前端控制器
 * </p>
 *
 * @author smith
 * @since 2025-10-31
 */
@RestController
@RequestMapping("/cdkeyStock")
public class CdkeyStockController {
    @Autowired
    private ICdkeyStockService cdkeyStockService;
    @Autowired
    private IGameService gameService;

    @PostMapping()
    public void addCdkey(@RequestBody CdkeyStock cdkeyStock) {
        Integer gameId = cdkeyStock.getGameId();
        cdkeyStockService.addCdk(cdkeyStock);
        gameService.incrementCdkeyStock(gameId);
    }

    // @PostMapping("testadd")
    public void quickadd() {
        for(int j=0;j<5;j++)
        for (int i = 0; i < 20; i++) {
            CdkeyStock cdkeyStock = new CdkeyStock();
            cdkeyStock.setCdkey(UUID.randomUUID().toString().replace("-", ""));
            // 1~20
            Integer gameId = i + 1;
            cdkeyStock.setGameId(gameId);
            gameService.incrementCdkeyStock(gameId);
            addCdkey(cdkeyStock);
            System.out.println("快速添加cdk:" + cdkeyStock.getCdkey() + " 游戏ID:" + gameId);
        }
    }

}
