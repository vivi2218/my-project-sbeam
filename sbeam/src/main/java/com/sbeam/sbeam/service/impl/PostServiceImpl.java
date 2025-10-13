package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Post;
import com.sbeam.sbeam.mapper.PostMapper;
import com.sbeam.sbeam.service.IPostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
<<<<<<< HEAD
=======

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
>>>>>>> origin/sub3
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
<<<<<<< HEAD
 * @author smith
 * @since 2025-10-07
=======
 * @author yourname
 * @since 2025-10-09
>>>>>>> origin/sub3
 */
@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements IPostService {

<<<<<<< HEAD
=======
    @Autowired
    private PostMapper postMapper;

    @Override
    public List<Post> getAllPosts() {
        return postMapper.selectList(null);
    }

>>>>>>> origin/sub3
}
