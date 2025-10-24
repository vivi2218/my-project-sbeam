package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.Post;


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
public interface IPostService {

    List<MogoPost> getAllPosts();

    MogoPost getById(String id);

    boolean save(MogoPost entity);



}
