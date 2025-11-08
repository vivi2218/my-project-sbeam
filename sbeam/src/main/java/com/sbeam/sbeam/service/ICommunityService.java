package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.Community;
import com.sbeam.sbeam.util.Result;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface ICommunityService extends IService<Community> {

    List<Community> getAllCommunity();

    List<Community> getByName(String name);

    void syncAllCommunitiesToEs();

    
}
