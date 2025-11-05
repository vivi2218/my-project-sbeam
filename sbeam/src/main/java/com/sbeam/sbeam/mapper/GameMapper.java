package com.sbeam.sbeam.mapper;

import com.sbeam.sbeam.entity.Game;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *

 * @author yourname
 * @since 2025-1
 */
@Mapper

public interface GameMapper extends BaseMapper<Game> {
    /**
     * 扣减库存
     * @param gameId 游戏ID
     * @param count 扣减数量
     * @return 影响行数（>0 表示成功）
     */
    int decreaseStock(@Param("gameId") Integer gameId, @Param("count") Integer count);
}
