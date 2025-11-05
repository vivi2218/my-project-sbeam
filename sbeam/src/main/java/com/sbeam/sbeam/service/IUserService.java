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

    User getUserById(Integer id);



    boolean sendCode(String email); //发送验证码
    boolean verifyCode(String email, String code);  //验证验证码

    boolean hasAdminPermission(Integer userId);  // 验证用户权限

    String getUserRole(Integer userId);   // 获取用户角色
    void registerUser(String username, String password, String email) throws Exception;   //注册





}
