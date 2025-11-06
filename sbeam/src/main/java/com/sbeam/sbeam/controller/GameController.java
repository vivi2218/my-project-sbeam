package com.sbeam.sbeam.controller;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.entity.VO.GameDetailVO;
import com.sbeam.sbeam.mapper.GameMapper;
import com.sbeam.sbeam.service.FlaskService;
import com.sbeam.sbeam.service.IGameService;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
@RequestMapping("/game")
public class GameController {
    @Autowired
    private IGameService gameService;
    @Autowired
    private FlaskService flaskService;

    @Autowired
    private GameMapper gameMapper;

    @Autowired
    private ElasticsearchClient esClient;
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


    // 批量同步接口
    // 批量同步接口
    @PostMapping("/syncEs")
    public Result syncEsFromDb() {
        gameService.syncAllGamesToEs();
        return Result.getSuccess("数据库数据已同步到 ES");
    }


    // 接收前端请求，通过 userId 调用 Flask 服务
    @GetMapping("/get-recommendations")
    public Map<String, Object> getRecommendations(@RequestParam Long userId) {
        // 调用 Flask 服务获取推荐结果
        return flaskService.getRecommendations(userId);
    }










}
