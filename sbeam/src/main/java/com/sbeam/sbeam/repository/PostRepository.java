package com.sbeam.sbeam.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.Post;


@Repository
public interface PostRepository extends MongoRepository<MogoPost, String> {

    List<MogoPost> findByParentPostId(String id);
    
    List<MogoPost> findByCommunityName(String communityName);

}
