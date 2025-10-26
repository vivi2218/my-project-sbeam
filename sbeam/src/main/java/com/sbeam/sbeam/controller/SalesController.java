package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.service.IGameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@CrossOrigin
@RestController
@RequestMapping("/sales")
public class SalesController {
    @Autowired
    private IGameService gameService;


    @GetMapping("/games")
    public Map<String, Object> getAllGames() {
        List<Game> games = gameService.list();
        return Map.of("code", 200, "msg", "获取成功", "data", games);
    }


}
