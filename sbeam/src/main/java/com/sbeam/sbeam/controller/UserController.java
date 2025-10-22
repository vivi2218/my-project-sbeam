package com.sbeam.sbeam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.service.IUserService;

import org.springframework.beans.factory.annotation.Autowired;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

=======
>>>>>>> fda2513dc04af9af3fb44a6d294a4d494da92f5e


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {
    @Autowired
    private IUserService userService;
    @PostMapping()
    public User createUser(@RequestBody User user) {
        return userService.createUser(user);
    }
    @PostMapping("/{id}")
    public User getUserById(@PathVariable Long id) {
        return userService.getUserById(id);
    }
    
    
}
