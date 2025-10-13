package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Community;
import com.sbeam.sbeam.mapper.CommunityMapper;
import com.sbeam.sbeam.service.ICommunityService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
<<<<<<< HEAD
=======

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
>>>>>>> origin/sub3
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
<<<<<<< HEAD
 * @author smith
 * @since 2025-10-07
 */
@Service
public class CommunityServiceImpl extends ServiceImpl<CommunityMapper, Community> implements ICommunityService {
=======
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class CommunityServiceImpl extends ServiceImpl<CommunityMapper, Community> implements ICommunityService {
    @Autowired
    private CommunityMapper communityMapper;

    @Override
    public List<Community> getAllCommunity() {
        return communityMapper.selectList(null);
    }

>>>>>>> origin/sub3

}
