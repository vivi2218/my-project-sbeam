package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.GameBundle;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09

 */
public interface IGameBundleService extends IService<GameBundle> {
    /**
     * 查询某个游戏的所有捆绑包
     */
    /**
     *
     * @param gameId
     * @return
     */
    List<GameBundle> getBundlesByGameId(Integer gameId,Integer status);
}
