package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.entity.UserFollow;
import com.sbeam.sbeam.entity.UserProfile;
import com.sbeam.sbeam.mapper.UserMapper;
import com.sbeam.sbeam.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.utils.EmailUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 存储手机号和验证码的临时Map
    Map<String, String> codeMap = new HashMap<>();

    @Override
    public User createUser(User user) {
        userMapper.insert(user);
        return user;
    }

    @Override
    public User getUserById(Integer id) {
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
                        .eq("user_name", userName));
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

    // @Override
    // public boolean hasAdminPermission(Integer userId) {
    //     User user = getById(userId);
    //     return user != null && "admin".equals(user.getRole());
    // }

    // @Override
    // public String getUserRole(Integer userId) {
    //     User user = getById(userId);
    //     return user != null ? user.getRole() : null;
    // }

    // 工具方法：验证邮箱格式
    private boolean isValidEmail(String email) {
        String emailRegex = "^[\\w.-]+@[\\w.-]+\\.\\w+$";
        return Pattern.matches(emailRegex, email);
    }



    /**
     * 更新用户头像 URL
     * @param userId 用户ID
     * @param avatarUrl 新的头像 URL
     * @return 更新后的用户资料信息
     */
    public void updateAvatar(Long userId, String avatarUrl) {
        // 使用 JdbcTemplate 执行 SQL 更新用户头像 URL
        String sql = "UPDATE user_profile SET avatar_url = ? WHERE user_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, avatarUrl, userId);

        if (rowsAffected > 0) {
            // 如果更新成功，返回更新后的用户资料信息（假设 UserProfile 类有 userId 和 avatarUrl 字段）
            UserProfile userProfile = new UserProfile();
            userProfile.setUserId(Math.toIntExact(userId));  // 将 userId 转换为 Integer 类型
            userProfile.setAvatarUrl(avatarUrl);  // 更新头像 URL

        } else {
            // 如果没有更新任何行，说明用户不存在
            throw new RuntimeException("用户不存在");
        }
    }

}