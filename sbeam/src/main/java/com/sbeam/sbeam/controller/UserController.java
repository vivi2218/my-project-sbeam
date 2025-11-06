package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.minio.MinioService;
import com.sbeam.sbeam.util.JWTUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.entity.UserProfile;
import com.sbeam.sbeam.service.IUserProfileService;
import com.sbeam.sbeam.service.IUserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * <p>
 * 前端控制器
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
    @Autowired
    private IUserProfileService userProService;
    @Autowired
    private JWTUtils jwtUtils;
    @Autowired
    private MinioService minioService;

    @GetMapping("/{id}")
    public User getUserById(@PathVariable Integer id) {
        return userService.getUserById(id);
    }





    @GetMapping("/pro/{id}")
    public UserProfile getProById(@PathVariable Integer id) {
        return userProService.getByUseProrId(id);
    }

    // 绑定steam


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

        String userName = body.get("user_name");
        String password = body.get("password");
        String email = body.get("email");
        String code = body.get("code");

        if (userName == null || userName.isEmpty() ||
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
            userService.registerUser(userName, password, email);
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


    // 修改用户名
    @PutMapping("/updateName")
    public Map<String, Object> updateUserName(@RequestHeader("Authorization") String token,
                                              @RequestBody Map<String, String> requestBody) {


        // 解析 token 获取 userId
        Long userId = jwtUtils.getUserId(token);
        if (userId == null) {
            return Map.of("code", 401, "msg", "Token 无效，无法获取用户ID");
        }

        // 获取前端传来的新用户名
        String newUserName = requestBody.get("userName");
        if (newUserName == null || newUserName.trim().isEmpty()) {
            return Map.of("code", 400, "msg", "新用户名不能为空");
        }

        // 查找用户
        User user = userService.getById(userId);
        if (user == null) {
            return Map.of("code", 404, "msg", "用户不存在");
        }

        // 更新用户名
        user.setUserName(newUserName);
        boolean isUpdated = userService.updateById(user);
        if (isUpdated) {
            return Map.of("code", 200, "msg", "用户名更新成功");
        } else {
            return Map.of("code", 500, "msg", "用户名更新失败");
        }
    }


    @PostMapping("/uploadAvatar")
    public ResponseEntity<?> uploadAvatar(@RequestParam("avatar") MultipartFile avatarFile,
                                          @RequestHeader("Authorization") String token) {
        // 验证 JWT token 并获取用户信息
        Long userId = jwtUtils.getUserId(token);

        if (userId == null) {
            return ResponseEntity.status(401).body("未授权");
        }

        try {
            // 上传头像到 MinIO
            String avatarFileName = minioService.uploadFile(avatarFile);  // 只返回文件名，例如 "de7104a7-c67c-4cfc-89ac-5aaa4c801435.png"


            // 更新数据库中的用户头像 名字
            userService.updateAvatar(userId, avatarFileName);


            return ResponseEntity.ok(Map.of(
                    "code", 200,
                    "message", "头像更新成功",
                    "data", avatarFileName
            ));

        } catch (Exception e) {
            return ResponseEntity.status(500).body("上传失败");
        }
    }



    @GetMapping("/avatar/{fileName}")
    public ResponseEntity<?> getAvatarUrl(@PathVariable String fileName) {
        try {
            // 调用 MinIO 服务获取签名 URL
            String avatarUrl = minioService.getFileUrl(fileName, 60);  // 例如，签名 URL 有效期 60 分钟

            // 返回文件的 URL
            return ResponseEntity.ok(Map.of("avatarUrl", avatarUrl));

        } catch (Exception e) {
            return ResponseEntity.status(500).body("获取文件 URL 失败");
        }
    }



}
