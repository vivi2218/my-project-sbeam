package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.Myorder;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sbeam.sbeam.util.Result;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author smith
 * @since 2025-10-07
 */
public interface IMyorderService extends IService<Myorder> {
    public Result getById(Integer id);
    public  Result addOrder(Myorder myorder);
    public Result updateOrder(Myorder myorder);
    public Result deleteOrder(Myorder myorder);
    /**
     * 分页查询订单列表（只查 status=0 的正常订单）
     */
    Result getOrderList(Integer pageNum, Integer pageSize);
}
