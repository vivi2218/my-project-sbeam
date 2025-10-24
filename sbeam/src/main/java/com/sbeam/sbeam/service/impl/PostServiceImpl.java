package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.Post;
import com.sbeam.sbeam.mapper.PostMapper;
import com.sbeam.sbeam.repository.PostRepository;
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
public class PostServiceImpl  implements IPostService {

    // @Autowired
    // private PostMapper postMapper;

    @Autowired
    private PostRepository postRepository;

    @Override
    public List<MogoPost> getAllPosts() {
        return postRepository.findAll();
    }

    @Override
    public MogoPost getById(String id) {
        return postRepository.findById(id).orElse(null);
    }

    @Override
    public boolean save(MogoPost entity) {
        postRepository.save(entity);
        return true;
    }




}
