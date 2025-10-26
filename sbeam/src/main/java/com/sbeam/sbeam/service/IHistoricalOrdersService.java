package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.HistoricalOrders;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sbeam.sbeam.util.Result;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
public interface IHistoricalOrdersService extends IService<HistoricalOrders> {
    //查询历史订单
    public Result getHistoricalOrder(int orderId);
}
