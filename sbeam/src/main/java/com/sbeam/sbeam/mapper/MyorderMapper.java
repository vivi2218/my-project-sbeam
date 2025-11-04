package com.sbeam.sbeam.mapper;

import com.sbeam.sbeam.entity.Myorder;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Mapper
public interface MyorderMapper extends BaseMapper<Myorder> {
    //查询超过30天的订单
    public List<Myorder> selectOldOrders();
    //批量插入历史表
    public int insertOrderHistory(List<Myorder> orders);
    //删除原表中已迁移的订单
    public int deleteOlders(List<Integer> orderIds);
}
