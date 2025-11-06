package com.sbeam.sbeam.mapper;

import com.sbeam.sbeam.entity.CdkeyStock;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sbeam.sbeam.entity.VO.CdkeyVO;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * CDKey库存表 Mapper 接口
 * </p>
 *
 * @author smith
 * @since 2025-10-31
 */
public interface CdkeyStockMapper extends BaseMapper<CdkeyStock> {
    // 关联查询用户的CDKey
    @Select("""
        SELECT c.game_id AS gameId, g.game_name AS gameName, c.cdkey, 
               DATE_FORMAT(c.created_at, '%Y-%m-%d %H:%i:%s') AS createTime, 
               DATE_FORMAT(c.updated_at, '%Y-%m-%d %H:%i:%s') AS updateTime,
               g.main_image_url
        FROM cdkey_stock c
        LEFT JOIN game g ON c.game_id = g.game_id
        WHERE c.user_id = #{userId} AND c.status = 1
        ORDER BY c.created_at DESC
    """)
    List<CdkeyVO> selectUserCdkeys(Integer userId);
    
    // 根据订单ID查询CDKey
    @Select("""
        SELECT c.game_id AS gameId, g.game_name AS gameName, c.cdkey, 
               DATE_FORMAT(c.created_at, '%Y-%m-%d %H:%i:%s') AS createTime, 
               DATE_FORMAT(c.updated_at, '%Y-%m-%d %H:%i:%s') AS updateTime,
               g.main_image_url
        FROM cdkey_stock c
        LEFT JOIN game g ON c.game_id = g.game_id
        WHERE c.order_id = #{orderId} AND c.status = 1
        ORDER BY c.created_at DESC
    """)
    List<CdkeyVO> selectOrderCdkeys(Integer orderId);
}
