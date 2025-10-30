package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.service.IUserService;
import com.sbeam.sbeam.util.JWTUtils;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/auth")
@CrossOrigin()
public class AuthController {

    @Autowired
    private IUserService userService;

    @Autowired
    private JWTUtils jwtUtils;

    @Autowired
    private RedisTemplate redisTemplate;

     // 登录
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> body) {
        String username = body.get("username");
        String password = body.get("password");

        User user = userService.lambdaQuery().eq(User::getUserName, username).one();
        if (user == null) {
            return Map.of("code", 401, "msg", "用户不存在");
        }
        if (!password.equals(user.getPassword())) {
            return Map.of("code", 401, "msg", "密码错误");
        }

        // 生成 token
        String accessToken = jwtUtils.generateToken(user);


//        String refreshToken = jwtUtils.generateToken(user, 7 * 24 * 60 * 60 * 1000); // 7天
//        return ResponseEntity.ok(Map.of(
//                "accessToken", accessToken,
//                "refreshToken", refreshToken
//        ));
//
//        String redis

        // 存入 Redis，设置过期时间与 JWT 一致（假设 1 小时）
        String redisKey = "login:accessToken:" + user.getUserId();
        redisTemplate.opsForValue().set(redisKey, accessToken, 1, TimeUnit.HOURS);
//        redisTemplate.opsForValue().set();

        return Map.of("code", 200, "token", accessToken, "userId", user.getUserId());
    }

    // 登出
    @PostMapping("/logout")
    public Map<String, Object> logout(@RequestHeader(name = "Authorization", required = false) String authHeader) {
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            Integer userId = Integer.valueOf(jwtUtils.getUserIdFromToken(token));
            if (userId != null) {
                String redisKey = "login:token:" + userId;
                redisTemplate.delete(redisKey);
            }
        }
        return Map.of("code", 200, "msg", "已登出");
    }
}
