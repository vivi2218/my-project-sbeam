package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Post;
import com.sbeam.sbeam.mapper.PostMapper;
import com.sbeam.sbeam.service.IPostService;
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
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements IPostService {

    @Autowired
    private PostMapper postMapper;

    @Override
    public List<Post> getAllPosts() {
        return postMapper.selectList(null);
    }

}
