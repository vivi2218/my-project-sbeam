package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.PaymentRecords;
import com.sbeam.sbeam.mapper.PaymentRecordsMapper;
import com.sbeam.sbeam.service.IPaymentRecordsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class PaymentRecordsServiceImpl extends ServiceImpl<PaymentRecordsMapper, PaymentRecords> implements IPaymentRecordsService {
    @Autowired
    private PaymentRecordsMapper paymentRecordsMapper;
    @Override
    public Result saveAndReturn(PaymentRecords paymentRecords) {
        paymentRecords.setStatus(0);
        paymentRecords.setVersion(0);
        paymentRecords.setCreatedAt(LocalDateTime.now());
        int rows = paymentRecordsMapper.insert(paymentRecords);
        if(rows >0){
            return Result.saveSuccess(paymentRecords);
        }

        return Result.saveFail(paymentRecords);
    }
}
