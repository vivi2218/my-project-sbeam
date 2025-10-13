package com.sbeam.sbeam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.Post;
import com.sbeam.sbeam.service.IPostService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/post")
@CrossOrigin
public class PostController {
    @Autowired
    private IPostService postService;
    @GetMapping("/id")
    public Post getPostById(@RequestParam Integer id) {
        return postService.getById(id);
    }
    @GetMapping
    public List<Post> getAllPosts() {
        return postService.getAllPosts();
    }
    @PostMapping
    public boolean createPost(@RequestBody Post entity) {
        return postService.save(entity);
    }


}
