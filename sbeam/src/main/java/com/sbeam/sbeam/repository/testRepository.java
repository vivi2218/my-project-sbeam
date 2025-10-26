package com.sbeam.sbeam.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.sbeam.sbeam.entity.testEntity;

public interface testRepository extends MongoRepository<testEntity, String> {

}
