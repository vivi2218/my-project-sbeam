package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.UserProfile;
import com.sbeam.sbeam.mapper.UserProfileMapper;
import com.sbeam.sbeam.service.IUserProfileService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class UserProfileServiceImpl extends ServiceImpl<UserProfileMapper, UserProfile> implements IUserProfileService {
    @Autowired
    private UserProfileMapper userProfileMapper;

    @Override
    public UserProfile getByUseProrId(Integer Id) {
        return userProfileMapper.selectById(Id);
    }

    
}
