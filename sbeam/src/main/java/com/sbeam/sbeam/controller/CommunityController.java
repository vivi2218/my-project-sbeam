package com.sbeam.sbeam.controller;

<<<<<<< HEAD

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
=======
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.Community;
import com.sbeam.sbeam.service.ICommunityService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


>>>>>>> origin/sub3

/**
 * <p>
 *  前端控制器
 * </p>
 *
<<<<<<< HEAD
 * @author smith
 * @since 2025-10-07
 */
@Controller
@RequestMapping("/community")
public class CommunityController {

=======
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/community")
public class CommunityController {
    @Autowired
    private ICommunityService communityService;
    @GetMapping("id")
    public Community getCommunityById(@RequestParam Integer id) {
        return communityService.getById(id);
    }
    @GetMapping
    public List<Community> getAllCommunity() {
        return communityService.getAllCommunity();
    }
    @PostMapping
    public boolean createCommunity(@RequestBody Community entity) {
        return communityService.save(entity);
    }
>>>>>>> origin/sub3
}
