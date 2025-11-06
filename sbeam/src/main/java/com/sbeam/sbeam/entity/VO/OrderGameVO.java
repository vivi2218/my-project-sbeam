package com.sbeam.sbeam.entity.VO;

import com.sbeam.sbeam.entity.Myorder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;

/**
 * 订单游戏信息封装类
 * 用于在订单列表中展示订单信息和关联的游戏信息
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class OrderGameVO extends Myorder {
    
    /**
     * 游戏名称
     */
    private String gameName;
    
    /**
     * 游戏ID
     */
    private Integer gameId;
    
    /**
     * 游戏图片URL
     */
    private String gameImageUrl;
    
    /**
     * 游戏单价（订单中的价格）
     */
    private BigDecimal gamePrice;
}