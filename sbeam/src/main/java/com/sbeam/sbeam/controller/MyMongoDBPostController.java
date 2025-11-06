package com.sbeam.sbeam.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.testEntity;
import com.sbeam.sbeam.repository.PostRepository;
import com.sbeam.sbeam.repository.testRepository;
import com.sbeam.sbeam.service.IPostService;
import com.sbeam.sbeam.util.Result;
import com.sbeam.sbeam.webSocket.MessagePushService;

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
    @Autowired
    private MessagePushService pushService;

    @GetMapping
    public List<MogoPost> getAllPost() {
        return service.getAllPosts();
    }


    //新建帖子
    @PostMapping
    public Result addpost(@RequestBody MogoPost entity) {
        service.save(entity);
        return Result.saveSuccess(entity);
    }


    //根据帖子ID获取帖子
    @GetMapping("/{id}")
    public MogoPost getById(@PathVariable String id) {
        return service.getById(id);
    }



    //获得所有回复
    @GetMapping("/reply")
    public Result getRepliesByPostId(@RequestParam String postId) {
        return Result.getSuccess(service.getReply(postId));
    }

    @PostMapping("/{parentid}/reply")
    public Result addreply(@PathVariable String parentid, @RequestBody MogoPost reply) {
        System.out.println(reply);
        service.addReply(parentid, reply);
        String parentUserId = service.getById(parentid).getUserId();
        pushService.notifyUser(parentUserId, reply.getAuthor() + "回复了你的帖子");
        return Result.saveSuccess(reply);
    }

}
