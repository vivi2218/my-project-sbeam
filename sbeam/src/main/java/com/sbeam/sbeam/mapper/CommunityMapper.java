package com.sbeam.sbeam.mapper;

import com.sbeam.sbeam.entity.Community;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


/**
 * <p>
 *  Mapper 接口
 * </p>
 *

 * @author yourname
 * @since 2025-10-09
 */
@Mapper
public interface CommunityMapper extends BaseMapper<Community> {

    List<Community> getByName(String name);

}
