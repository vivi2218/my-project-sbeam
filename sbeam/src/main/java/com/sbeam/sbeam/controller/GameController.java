package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.entity.VO.GameDetailVO;
import com.sbeam.sbeam.service.IGameService;
import com.sbeam.sbeam.service.IUserGameLibraryService;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


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
@RequestMapping("/game")
public class GameController {
    @Autowired
    private IGameService gameService;
    public GameController(IGameService gameService) {
        this.gameService = gameService;
    }

    //localhost:8080/game/details/1
    @GetMapping("/details/{gameId}")
    public Result getGameDetails(@PathVariable Integer gameId,@RequestParam(required = false) Integer userId){
        GameDetailVO gameDetail = gameService.getGameDetails(gameId, userId);
        return Result.getSuccess(gameDetail);
    }
    @GetMapping("/all")
    public List<Game> getAllGames() {
        return gameService.listAllGames();
    }




}
