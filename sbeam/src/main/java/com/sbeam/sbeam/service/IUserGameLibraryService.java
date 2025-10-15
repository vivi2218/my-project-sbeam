package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.UserGameLibrary;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sbeam.sbeam.entity.VO.GameLibraryVO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface IUserGameLibraryService extends IService<UserGameLibrary> {
    /**
     *查询用户游戏库存
     */
    public List<GameLibraryVO> getUserLibrary(Integer userId);
    /**
     * 添加游戏到用户库存
     */
    public boolean addOrUpdateGame(Integer userId,Integer gameId,String source);
    /**
     * 从用户库存移除游戏
     */
    public boolean removeGameFromLibrary(Integer userId, Integer gameId);


}
