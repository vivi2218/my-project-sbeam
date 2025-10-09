package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.service.IUserService;
import com.sbeam.sbeam.util.JWTUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private IUserService userService;

    @Autowired
    private JWTUtils jwtUtils;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> body) {
        String username = body.get("username");
        String password = body.get("password");

        // 简单示例：根据 username 查询（生产请使用加密密码验证）
        User user = userService.lambdaQuery().eq(User::getUserName, username).one();
        if (user == null) {
            return Map.of("code", 401, "msg", "用户不存在");
        }
        if (!password.equals(user.getPassword())) {
            return Map.of("code", 401, "msg", "密码错误");
        }

        String token = jwtUtils.generateToken(user);
        return Map.of("code", 200, "token", token, "userId", user.getUserId());
    }

    @PostMapping("/logout")
    public Map<String, Object> logout(@RequestHeader(name = "Authorization", required = false) String authHeader) {
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            jwtUtils.invalidateToken(token);
        }
        return Map.of("code", 200, "msg", "已登出");
    }
}