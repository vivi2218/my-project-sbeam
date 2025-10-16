package com.sbeam.sbeam.mapper;

import com.sbeam.sbeam.entity.UserGameLibrary;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.sbeam.sbeam.entity.VO.GameLibraryVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * <p>
 *  Mapper 接口
 * </p>
 *

 * @author yourname
 * @since 2025-10-09
 */
@Mapper

public interface UserGameLibraryMapper extends BaseMapper<UserGameLibrary> {
    public List<GameLibraryVO> selectUserLibrary(@Param("userId") Integer userId);
}
