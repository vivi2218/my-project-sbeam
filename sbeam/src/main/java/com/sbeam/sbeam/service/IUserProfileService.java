package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.UserProfile;

import org.springframework.beans.factory.annotation.Autowired;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface IUserProfileService extends IService<UserProfile> {
    UserProfile getByUseProrId(Integer Id);
}
