package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.mapper.UserMapper;
import com.sbeam.sbeam.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author smith
 * @since 2025-10-07
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

}
