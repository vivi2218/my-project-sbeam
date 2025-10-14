package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface IUserService extends IService<User> {

    User createUser(User user);

    User getUserById(Long id);

}
