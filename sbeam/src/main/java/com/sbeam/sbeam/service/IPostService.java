package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.Post;
<<<<<<< HEAD
=======

import java.util.List;

>>>>>>> origin/sub3
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
<<<<<<< HEAD
 * @author smith
 * @since 2025-10-07
 */
public interface IPostService extends IService<Post> {

=======
 * @author yourname
 * @since 2025-10-09
 */
public interface IPostService extends IService<Post> {

    List<Post> getAllPosts();

>>>>>>> origin/sub3
}
