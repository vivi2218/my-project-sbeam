package com.sbeam.sbeam.controller;

<<<<<<< HEAD
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
=======
import com.sbeam.sbeam.service.IUserGameLibraryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

>>>>>>> fda2513dc04af9af3fb44a6d294a4d494da92f5e

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
<<<<<<< HEAD
    private IGameService gameService;
    
    @GetMapping("/{type}")
    public Game getGameByType(@PathVariable String type) {
        return gameService.getGameByType(type);
    }
    

=======
    private IUserGameLibraryService userGameLibraryService;

//    @GetMapping("/library/{userId}")
//    public Result getUserGameLibrary(@PathVariable Integer userId){
//        List<Integer> userGameLibrary = userGameLibraryService.getUserGameLibrary(userId);
//        return Result.getSuccess(userGameLibrary);
//    }
//    @PostMapping("/library")
//    public Result addGameToLibrary(@RequestParam Integer userId,
//                                   @RequestParam Integer gameId,
//                                   @RequestParam(required = false ,defaultValue = "BUY") String source){
//        //参数可以不存在,   当参数不存在时，使用默认值 "BUY"
//        boolean b = userGameLibraryService.addGameToLibrary(userId, gameId, source);
//        if(b)
//            return Result.saveSuccess(b);
//        return Result.saveFail(b);
//    }
//
//    @DeleteMapping("/library")
//    public Result removeGameFromLibrary(@RequestParam Integer userId,
//                                        @RequestParam Integer gameId){
//        boolean b = userGameLibraryService.removeGameFromLibrary(userId, gameId);
//        if(b)
//            return Result.deleteSuccess(b);
//        return Result.deleteFail(b);
//    }
//
//    @GetMapping("/library/has")
//    public Result hasGame(@RequestParam Integer userId,
//                          @RequestParam Integer gameId){
//        boolean b = userGameLibraryService.hasGame(userId, gameId);
//        if(b)
//            return Result.getSuccess(b);
//        return Result.getFail(b);
//    }
>>>>>>> fda2513dc04af9af3fb44a6d294a4d494da92f5e

}
