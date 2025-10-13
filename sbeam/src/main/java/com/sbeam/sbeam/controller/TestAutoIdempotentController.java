package com.sbeam.sbeam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.interceptor.AutoIdempotentInterceptor;
import com.sbeam.sbeam.service.IdempotentTokenService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/idempotent")
@CrossOrigin
public class TestAutoIdempotentController {
    @Autowired
    private IdempotentTokenService idempotentTokenService;

    @GetMapping("create")
    public boolean createToken(){//暂时使用boolean代替result
        idempotentTokenService.createToken();
        return true;
    }
}
