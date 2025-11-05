package com.sbeam.sbeam.job;

import com.sbeam.sbeam.service.IOrderHistoryService;
import com.xxl.job.core.context.XxlJobHelper;
import com.xxl.job.core.handler.annotation.XxlJob;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class OrderToHistoryJob {
    @Autowired
    private IOrderHistoryService historyService;
    //@XxlJob("moveOrderToHistoryJob")//任务名称,与调度中心配置一致
    public void moveOrderToHistory(){
        XxlJobHelper.log("开始执行订单迁移任务...");
        // 查询订单表中已超过30天的订单
        // 移动到历史表
        historyService.moveOldOrdersToHistory();
        XxlJobHelper.log("订单迁移任务执行完成！");
    }
}
/*
    controller
    save cart
    carr
    price*double
    fun()
    price_ori*selaserver.getselabygameid
 */