package com.sbeam.sbeam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.Post;
import com.sbeam.sbeam.repository.PostRepository;
import com.sbeam.sbeam.service.IPostService;

// 替换为 Spring 的 RequestBody
import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * <p>
 *  前端控制器
 * </p>
 *  已废弃
 * @author yourname
 * @since 2025-10-09
 */
@RestController

@RequestMapping({"/post", ""})
@CrossOrigin
public class PostController {
    // @Autowired
    // private IPostService postService;

    // //测试用
    // // @Autowired
    // // private PostRepository postRepository;


    // @GetMapping("/id")
    // public MogoPost getPostById(@RequestParam String id) {
    //     return postService.getById(id);
    // }
    // @GetMapping
    // public List<MogoPost> getAllPosts() {
    //     return postService.getAllPosts();
    // }
    // @PostMapping
    // public boolean createPost(@RequestBody MogoPost entity) {
    //     System.out.println("Received Post: " + entity);
    //     return postService.save(entity);
    // }

}
