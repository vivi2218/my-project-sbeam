package com.sbeam.sbeam.controller;

<<<<<<< HEAD

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
=======
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.User;
import com.sbeam.sbeam.service.IUserService;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;


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
@RequestMapping("/user")
public class UserController {

=======
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private IUserService userService;
    @PostMapping()
    public User createUser(@RequestBody User user) {
        return userService.createUser(user);
    }
>>>>>>> origin/sub3
}
