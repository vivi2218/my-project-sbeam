package com.sbeam.sbeam.entity.VO;

import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class GameVO {
    // game表所有字段（与数据库字段对应）
    private Integer gameId;                  // game_id
    private String gameName;                 // game_name
    private BigDecimal gameOriginalPrice;    // game_original_price
    private Date releaseDate;                // release_date
    private String mainImageUrl;             // main_image_url
    private Integer version;                 // version
    private Date createdAt;                  // created_at
    private Date updatedAt;                  // update_at
    private Integer remainStock;             // remain_stock（补充你的实际字段）
    private Integer totalStock;              // total_stock（补充你的实际字段）
    private Integer status;                  // status（补充你的实际字段）

    // game_profile表字段
    private String gameTagName;              // game_tag_name
}