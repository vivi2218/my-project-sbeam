package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.mapper.UserMapper;
import com.sbeam.sbeam.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.utils.EmailUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    @Autowired
    private UserMapper userMapper;
    // 存储手机号和验证码的临时Map
    Map<String, String> codeMap = new HashMap<>();


    @Override
    public User createUser(User user) {
        userMapper.insert(user);
        return user;
    }

    @Override
    public User getUserById(Long id) {
        return userMapper.selectById(id);

    }

    @Override
    public boolean sendCode(String email) {
        String code = String.valueOf((int) ((Math.random() * 9 + 1) * 100000));
        codeMap.put(email, code);
        String content = "您的验证码为：" + code + "，请勿泄露于他人！";
        EmailUtils.sendEmail(email, "注册验证码", content);
        return true;

    }

    @Override
    public boolean verifyCode(String email, String code) {
        String realCode = codeMap.get(email);
        return realCode != null && realCode.equals(code);
    }

    @Override
    public void registerUser(String userName, String password, String email) throws Exception {
        // 验证邮箱格式
        if (!isValidEmail(email)) {
            throw new Exception("邮箱格式不正确");
        }

        // 检查邮箱或用户名是否存在
        User existUser = userMapper.selectOne(
                new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<User>()
                        .eq("email", email)
                        .or()
                        .eq("user_name", userName)
        );
        if (existUser != null) {
            throw new Exception("用户已存在");
        }

        // 创建新用户
        User user = new User();
        user.setUserName(userName);
        user.setPassword(password); // 建议加密存储
        user.setEmail(email);
        userMapper.insert(user);
    }

    @Override
    public boolean hasAdminPermission(Integer userId) {
        User user = getById(userId);
        return user != null && "admin".equals(user.getRole());
    }
    @Override
    public String getUserRole(Integer userId) {
        User user = getById(userId);
        return user != null ? user.getRole() : null;
    }

    // 工具方法：验证邮箱格式
    private boolean isValidEmail(String email) {
        String emailRegex = "^[\\w.-]+@[\\w.-]+\\.\\w+$";
        return Pattern.matches(emailRegex, email);
    }
}
