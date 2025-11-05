package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.PaymentRecords;
import com.sbeam.sbeam.mapper.PaymentRecordsMapper;
import com.sbeam.sbeam.service.ICdkeyStockService;
import com.sbeam.sbeam.service.IMyorderService;
import com.sbeam.sbeam.service.IPaymentRecordsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.util.Result;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    @Autowired
    private IMyorderService myorderService;
    @Autowired
    private ICdkeyStockService cdkeyStockService;
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

    /**
     * 支付成功后处理
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void handlePaymentSuccess(String orderNum, String tradeNo, String payPrice) {

        // 1️⃣ 查订单
        Myorder orders = (Myorder) myorderService.getByOrderNumber(orderNum).getData();
        if (orders == null) {
            throw new RuntimeException("订单不存在：" + orderNum);
        }

        // 2️⃣ 幂等检查
        if ("paid".equals(orders.getOrderStatus())) {
            System.out.println("⚠️ 订单已支付，跳过重复处理");
            return;
        }

        // 3️⃣ 更新订单状态
        orders.setOrderStatus("paid");
        orders.setUpdatedAt(LocalDateTime.now());
        myorderService.updateById(orders);

        // 4️⃣ 创建支付流水
        PaymentRecords paymentRecords = new PaymentRecords();
        paymentRecords.setOrderId(orders.getOrderId());
        paymentRecords.setPayerId(orders.getUserId());
        paymentRecords.setTransactionNumber(tradeNo);
        paymentRecords.setTransactionAmount(orders.getFinalPrice());
        paymentRecords.setPaymentTime(LocalDateTime.now());
        paymentRecords.setStatus(0);
        paymentRecords.setVersion(0);
        paymentRecords.setCreatedAt(LocalDateTime.now());
        int rows = paymentRecordsMapper.insert(paymentRecords);
        //paymentRecordsService.save(paymentRecords);

        // 5️⃣ 扣减 MySQL 库存（真正生效）
        cdkeyStockService.decrStock(orders);

        // 6️⃣ 分配 CDKey 给用户
        cdkeyStockService.bindCdKeysToUser(orders);

        System.out.println("✅ 支付成功业务完成：" + orderNum);
    }
}
