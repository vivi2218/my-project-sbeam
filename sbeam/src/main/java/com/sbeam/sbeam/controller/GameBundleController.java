package com.sbeam.sbeam.controller;


import com.sbeam.sbeam.entity.GameBundle;
import com.sbeam.sbeam.service.IGameBundleService;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RequestMapping("/gameBundle")

public class GameBundleController {
    @Autowired
    private IGameBundleService gameBundleService;
    //游戏捆绑包接口
    //http://localhost:8080/gameBundle/1/bundles/status/0
    @GetMapping("/{gameId}/bundles/status/{status}")
    public Result getGameBundles(@PathVariable Integer gameId,
                                 @PathVariable Integer status){
        List<GameBundle> bundlesByGameId = gameBundleService.getBundlesByGameId(gameId,status);
        if(bundlesByGameId != null && !bundlesByGameId.isEmpty())
            return Result.getSuccess(bundlesByGameId);
        return Result.getFail(bundlesByGameId);
    }

}
