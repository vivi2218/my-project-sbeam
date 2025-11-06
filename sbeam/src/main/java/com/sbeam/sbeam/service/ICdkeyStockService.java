package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.CdkeyStock;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.OrderDetails;
import com.sbeam.sbeam.entity.VO.CdkeyVO;
import com.sbeam.sbeam.util.Result;

import java.util.List;

/**
 * <p>
 * CDKey库存表 服务类
 * </p>
 *
 * @author smith
 * @since 2025-10-31
 */
public interface ICdkeyStockService extends IService<CdkeyStock> {

    void addCdk(CdkeyStock cdkeyStock);

    /**
     * 根据订单绑定CDKey（支付成功后发货）
     * @param order 订单对象
     * @return Result 绑定结果
     */
    Result bindCdKeysToUser(Myorder order);

    void decrStock(Myorder order);
    // 获取当前用户的CDKey列表
    public List<CdkeyVO> getUserCdkeys(Integer userId);
    
    // 根据订单ID获取CDKey列表
    public List<CdkeyVO> getOrderCdkeys(Integer orderId);
}
