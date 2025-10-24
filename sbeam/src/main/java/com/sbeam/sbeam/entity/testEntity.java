package com.sbeam.sbeam.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Document(collection = "test")
@ToString
@Getter
@Setter
public class testEntity {
    @Id
    private String id;
    private String description;
}
