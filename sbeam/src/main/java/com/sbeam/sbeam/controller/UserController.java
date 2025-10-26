package com.sbeam.sbeam.controller;

import org.springframework.web.bind.annotation.*;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.service.IUserService;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.CrossOrigin;

import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;
import org.springframework.web.bind.annotation.RequestBody;



/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {
    @Autowired
    private IUserService userService;

    @GetMapping("/{id}")
    public User getUserById(@PathVariable Long id) {
        return userService.getUserById(id);
    }

    // 发送验证码
    @PostMapping("/sendCode")
    public Map<String, Object> sendCode(@RequestBody Map<String, String> body) {
        Map<String, Object> result = new HashMap<>();

        String email = body.get("email");
        if (email == null || email.isEmpty()) {
            result.put("success", false);
            result.put("message", "请输入邮箱");
            return result;
        }

        // 验证邮箱格式
        if (!isValidEmail(email)) {
            result.put("success", false);
            result.put("message", "邮箱格式不正确");
            return result;
        }

        boolean sent = userService.sendCode(email);
        if (sent) {
            result.put("success", true);
            result.put("message", "验证码发送成功");
        } else {
            result.put("success", false);
            result.put("message", "验证码发送失败，请重试");
        }

        return result;
    }

    // 注册接口
    @PostMapping
    public Map<String, Object> register(@RequestBody Map<String, String> body) {
        Map<String, Object> result = new HashMap<>();

        String username = body.get("user_name");
        String password = body.get("password");
        String email = body.get("email");
        String code = body.get("code");

        if (username == null || username.isEmpty() ||
                password == null || password.isEmpty() ||
                email == null || email.isEmpty() ||
                code == null || code.isEmpty()) {
            result.put("success", false);
            result.put("message", "请输入完整信息");
            return result;
        }

        // 验证邮箱格式
        if (!isValidEmail(email)) {
            result.put("success", false);
            result.put("message", "邮箱格式不正确");
            return result;
        }

        boolean codeValid = userService.verifyCode(email, code);
        if (!codeValid) {
            result.put("success", false);
            result.put("message", "验证码错误或已过期");
            return result;
        }

        try {
            userService.registerUser(username, password, email);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage()); // 返回具体异常信息
        }

        return result;
    }

    // 工具方法：验证邮箱格式
    private boolean isValidEmail(String email) {
        String emailRegex = "^[\\w.-]+@[\\w.-]+\\.\\w+$";
        return Pattern.matches(emailRegex, email);
    }





}





