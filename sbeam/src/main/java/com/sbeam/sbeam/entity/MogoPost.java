package com.sbeam.sbeam.entity;

import java.util.List;
import java.util.UUID;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Document(collection = "posts")
@ToString
@Getter
@Setter
public class MogoPost {
    @Id
    @JsonProperty("id")
    private String postId = UUID.randomUUID().toString();
    private String communityId;
    private String userId;
    private String author;
    private String content;
    private String postTitle;
    private String postContent;
    private String parentPostId;
    private String likeCount;
    private String createdAt;
    private String updatedAt;
    private String status;
    private String version;
    private List<MogoPost> replies;
}
