package com.sbeam.sbeam.entity.VO;

import lombok.Data;

import java.time.LocalDate;

@Data
public class CdkeyVO {
    private Integer gameId;
    private String gameName;
    private String cdkey;
    private String createTime;
    private String updateTime;
    private String mainImageUrl;
}
