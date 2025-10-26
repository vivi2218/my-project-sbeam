package com.sbeam.sbeam.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.testEntity;
import com.sbeam.sbeam.repository.testRepository;

import org.checkerframework.checker.units.qual.t;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/mogo")
public class MogoTestController {
    @Autowired
    private testRepository repository;

    @PostMapping
    public boolean postMethodName(@RequestBody testEntity entity) {
        System.out.println("Received Entity: " + entity);
        repository.save(entity);
        return true;
    }
    
}
