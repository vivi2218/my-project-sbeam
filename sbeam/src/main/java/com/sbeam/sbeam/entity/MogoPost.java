package com.sbeam.sbeam.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Document(collection = "posts")
@ToString
@Getter
@Setter
public class MogoPost {
    @Id
    private String postId;
    private String communityId;
    private String userId;
    private String postTitle;
    private String postContent;
    private String parentPostId;
    private String likeCount;
    private String createdAt;
    private String updatedAt;
    private String status;
    private String version;
}
