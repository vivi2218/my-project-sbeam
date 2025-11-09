package com.sbeam.sbeam.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import com.sbeam.sbeam.entity.Comment;
import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.service.ICommentService;
import com.sbeam.sbeam.service.IGameService;
import com.sbeam.sbeam.util.Result;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;




/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/comment")
@CrossOrigin
public class CommentController {
    @Autowired
    private ICommentService commentService;


    @GetMapping("/getall")
    public List<Comment> getAllComments() {
        return commentService.getAllComments();
    }

    @PutMapping("")
    public String addComment(@RequestBody Comment comment) {
        commentService.save(comment);
        return "Comment added successfully";
    }

    @GetMapping("id")
    public Comment getByCommentId(@PathVariable Integer id) {
        return commentService.getById(id);
    }

    @PostMapping
    public Result createComment(@RequestBody Comment comment) {
        return Result.saveSuccess(commentService.save(comment));
    }
    

    
}
