package com.sbeam.sbeam.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.TestMyOrder;
import com.sbeam.sbeam.interceptor.AutoIdempotent;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/testorder")
@CrossOrigin
public class TestOrderController {
    @AutoIdempotent
    @PostMapping
    public Boolean save(@RequestBody TestMyOrder testMyOrder) {

        // 2. 保存订单
        System.out.println("正在添加订单。。。。");
        System.out.println(testMyOrder);

        // 调用service - mapper - insert into myorder values ....()
        return true;
    }

    @GetMapping
    @AutoIdempotent
    public String fun1() {
        return null;
    }

}
