package com.sbeam.sbeam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.Community;
import com.sbeam.sbeam.service.ICommunityService;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;




/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/community")
@CrossOrigin
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

}
