package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.interceptor.AutoIdempotentInterceptor;
import com.sbeam.sbeam.service.IdempotentTokenService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;


@RestController
@RequestMapping("/idempotent")
@CrossOrigin
public class TestAutoIdempotentController {
    @Autowired
    private IdempotentTokenService idempotentTokenService;

    @GetMapping("createToken")
    public Result createToken(@RequestParam Integer userId){

        String tokenValue = idempotentTokenService.createToken(userId);
        // 例如 tokenValue = "abc123:12345:uuid-xyz"
        String[] parts = tokenValue.split(":", 2);
        String token = parts[0];
        String value = parts[1];
        Map<String, String> data = new HashMap<>();
        data.put("formtoken", token);
        data.put("formvalue", value);
        return Result.getSuccess(data);
    }
}
