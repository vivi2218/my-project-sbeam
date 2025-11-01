package com.sbeam.sbeam.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.testEntity;
import com.sbeam.sbeam.repository.PostRepository;
import com.sbeam.sbeam.repository.testRepository;
import com.sbeam.sbeam.service.IPostService;
import com.sbeam.sbeam.util.Result;

import java.util.List;

import org.checkerframework.checker.units.qual.s;
import org.checkerframework.checker.units.qual.t;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/mygo")
@CrossOrigin
public class MyMongoDBPostController {
    @Autowired
    private IPostService service;

    @GetMapping
    public List<MogoPost> getAllPost() {
        return service.getAllPosts();
    }

    @PostMapping
    public Result addpost(@RequestBody MogoPost entity) {
        service.save(entity);
        return Result.saveSuccess(entity);
    }

    @GetMapping("/{id}")
    public MogoPost getById(@PathVariable String id) {
        return service.getById(id);
    }

    @GetMapping("/reply")
    public Result getRepliesByPostId(@RequestParam String postId) {
        return Result.getSuccess(service.getReply(postId));
    }

    @PostMapping("/{id}/reply")
    public Result addreply(@PathVariable String id, @RequestBody MogoPost reply) {
        System.out.println(reply);
        service.addReply(id, reply);
        return Result.saveSuccess(reply);
    }

}
