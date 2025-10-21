package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.Game;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sbeam.sbeam.entity.VO.GameDetailVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface IGameService extends IService<Game> {
    //获取游戏详情
    public GameDetailVO getGameDetails(Integer gameId,Integer userId);

}
