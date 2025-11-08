package com.sbeam.sbeam.repository;


import com.sbeam.sbeam.entity.UserCommunity;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserCommunityRepository extends MongoRepository<UserCommunity, String>{

}
