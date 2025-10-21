package com.sbeam.sbeam.service;


import com.sbeam.sbeam.entity.Comment;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface ICommentService extends IService<Comment> {

    List<Comment> getAllComments();

}
