package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.PaymentRecords;
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
public interface IPaymentRecordsService extends IService<PaymentRecords> {
    public Result saveAndReturn(PaymentRecords paymentRecords);
    public void handlePaymentSuccess(String orderNum, String tradeNo, String payPrice);
}
