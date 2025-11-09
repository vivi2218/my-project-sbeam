package com.sbeam.sbeam.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import groovy.transform.ToString;
import lombok.Getter;
import lombok.Setter;

@Document(collection = "user_community")
@ToString
@Getter
@Setter
public class UserCommunity {
    @Id
    private String id;
    private String userId;
    private String communityId;
}
