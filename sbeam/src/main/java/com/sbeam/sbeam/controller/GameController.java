package com.sbeam.sbeam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.service.IGameService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/game")
public class GameController {
    @Autowired
    private IGameService gameService;
    
    @GetMapping("/{type}")
    public Game getGameByType(@PathVariable String type) {
        return gameService.getGameByType(type);
    }
    


}
