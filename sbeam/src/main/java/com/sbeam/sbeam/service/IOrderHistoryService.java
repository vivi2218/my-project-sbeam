package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.OrderHistory;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author smith
 * @since 2025-10-31
 */
public interface IOrderHistoryService extends IService<OrderHistory> {
    public void moveOldOrdersToHistory();
}
