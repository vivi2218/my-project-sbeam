package com.sbeam.sbeam.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.testEntity;
import com.sbeam.sbeam.repository.PostRepository;
import com.sbeam.sbeam.repository.testRepository;
import com.sbeam.sbeam.service.IPostService;

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
    public boolean addpost(@RequestBody MogoPost entity) {
        System.out.println("Received Entity: " + entity);
        service.save(entity);
        return true;
    }

    @GetMapping("/{id}")
    public MogoPost getMethodName(@PathVariable String id) {
        return service.getById(id);
    }

    @GetMapping("/reply")
    public List<MogoPost> getRepliesByPostId(@RequestParam String postId) {
        System.out.println("Getting replies for postId: " + postId);
        return service.getReply(postId);
    }

    @PostMapping("/reply")
    public boolean addreply(@RequestBody MogoPost entity) {
        System.out.println("Received Entity: " + entity);
        service.save(entity);
        return true;
    }

}
