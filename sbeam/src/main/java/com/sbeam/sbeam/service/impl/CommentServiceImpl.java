package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Comment;
import com.sbeam.sbeam.mapper.CommentMapper;
import com.sbeam.sbeam.service.ICommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {
    @Autowired
    private CommentMapper commentMapper;

    @Override
    public List<Comment> getAllComments() {
        return commentMapper.selectList(null);
    }
    

}
