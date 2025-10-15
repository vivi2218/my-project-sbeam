package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.VO.GameLibraryVO;
import com.sbeam.sbeam.service.IUserGameLibraryService;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RestController
@RequestMapping("/userGameLibrary")
public class UserGameLibraryController {
    @Autowired
    private IUserGameLibraryService userGameLibraryService;
    //查询个人游戏库存
    //http://localhost:8080/userGameLibrary/1
    @GetMapping("/{userId}")
    public Result getLibrary(@PathVariable Integer userId){
        List<GameLibraryVO> userLibrary = userGameLibraryService.getUserLibrary(userId);
        if(userLibrary.isEmpty())
            return Result.getFail(userLibrary);
        return Result.getSuccess(userLibrary);
    }

    //添加(购买或礼包)
    @PostMapping("/add")
    //http://localhost:8080/userGameLibrary/add
    public Result addGame(@RequestParam Integer userId,
                          @RequestParam Integer gameId,
                          @RequestParam(defaultValue = "BUY") String source){
        boolean b = userGameLibraryService.addOrUpdateGame(userId, gameId, source);
        return b ? Result.saveSuccess("添加成功"):Result.saveFail("已存在该游戏");
        //有点小问题,再次添加到库中,,没有返回"已存在该游戏"
    }

    //删除(逻辑删除)

    @PostMapping("/remove")
    public Result removeGame(@RequestParam Integer userId,
                             @RequestParam Integer gameId){
        boolean b = userGameLibraryService.removeGameFromLibrary(userId, gameId);
        return b ? Result.deleteSuccess("删除成功"):Result.deleteFail("请重新删除");
        //同上 是不是根本不需要这个fail
    }


}
