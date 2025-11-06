package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sbeam.sbeam.entity.CdkeyStock;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.OrderDetails;
import com.sbeam.sbeam.entity.VO.CdkeyVO;
import com.sbeam.sbeam.mapper.CdkeyStockMapper;
import com.sbeam.sbeam.mapper.GameMapper;
import com.sbeam.sbeam.mapper.OrderDetailsMapper;
import com.sbeam.sbeam.service.ICdkeyStockService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

/**
 * <p>
 * CDKey库存表 服务实现类
 * </p>
 *
 * @author smith
 * @since 2025-10-31
 */
@Service
public class CdkeyStockServiceImpl extends ServiceImpl<CdkeyStockMapper, CdkeyStock> implements ICdkeyStockService {
    @Autowired
    private CdkeyStockMapper cdkeyStockMapper;
    @Autowired
    private OrderDetailsMapper orderDetailsMapper;
    @Autowired
    private GameMapper gameMapper;

    @Override
    public void addCdk(CdkeyStock cdkeyStock) {
        cdkeyStock.setCdkey(UUID.randomUUID().toString());
        cdkeyStock.setStatus(0);
        cdkeyStock.setCreatedAt(LocalDateTime.now());
        cdkeyStockMapper.insert(cdkeyStock);
    }

    @Override
    public Result bindCdKeysToUser(Myorder order) {
        if(order == null || order.getOrderId()==null){
            return Result.getFail(order);//订单信息无效
        }
        Integer orderId = order.getOrderId();
        Integer userId = order.getUserId();
        //查询该订单的游戏详情
        List<OrderDetails> detailsList = orderDetailsMapper.selectList(
                new QueryWrapper<OrderDetails>().eq("order_id", orderId)
        );
        if(detailsList.isEmpty()){
            return Result.getFail("订单中无游戏详情");
        }
        int successCount = 0;
        for(OrderDetails detail: detailsList){
            //查找一条未售出的CDKey
            CdkeyStock cdkey = cdkeyStockMapper.selectOne(
                    new QueryWrapper<CdkeyStock>()
                            .eq("game_id", detail.getGameId())
                            .eq("status", 0)
                            .last("LIMIT 1")
            );
            if(cdkey == null){
                System.out.println("❌ 游戏ID " + detail.getGameId() + " 无可用CDKey");
                continue;
            }

            //绑定CdKey
            cdkey.setStatus(1);//已售出
            cdkey.setOrderId(orderId);
            cdkey.setUserId(userId);
            cdkey.setUpdatedAt(LocalDateTime.now());
            cdkeyStockMapper.updateById(cdkey);

            successCount++;
            System.out.println("✅ 游戏ID " + detail.getGameId() + " 发放CDKey成功：" + cdkey.getCdkey());
        }
        if(successCount == 0){
            return Result.getFail("CDKey绑定失败，库存不足或已售罄");
        }
        return Result.getSuccess("成功发放CdKey数量:" +successCount);
    }

    //真正扣MySql库存
    @Override
    public void decrStock(Myorder order) {

        if (order == null || order.getOrderId() == null) {
            throw new IllegalArgumentException("订单信息无效，无法扣减库存");
        }

        List<OrderDetails> detailsList = orderDetailsMapper.selectList(
                new QueryWrapper<OrderDetails>().eq("order_id", order.getOrderId())
        );
        for(OrderDetails details: detailsList){
            Integer gameId = details.getGameId();
            int rows = gameMapper.decreaseStock(gameId, 1);
            if (rows <= 0) {
                // remain_stock 不足会导致更新失败
                throw new RuntimeException("❌ MySQL 扣库存失败，库存不足，gameId=" + gameId);
            }

            System.out.println("✅ MySQL 扣库存成功：gameId=" + gameId + "，扣减数量=" + 1);

//             （可选）清理或刷新 Redis，等待 Canal 同步最新库存
//            String stockKey = "game:stock:" + gameId;
//            redisTemplate.delete(stockKey); // 删除旧缓存，避免脏读
//            System.out.println("🧹 删除 Redis 缓存 key=" + stockKey + "，等待 Canal 更新最新库存");
        }
    }


    //查看用户订单的游戏cdkey
    @Override
    public List<CdkeyVO> getUserCdkeys(Integer userId) {
        if (userId == null || userId <= 0) {
            return null; // 参数验证
        }
        List<CdkeyVO> cdkeyList = cdkeyStockMapper.selectUserCdkeys(userId);
        // 对返回的数据进行格式化处理
        if (cdkeyList != null) {
            for (CdkeyVO cdkey : cdkeyList) {
                // 这里不需要额外格式化，因为SQL中已经使用了正确的别名
                System.out.println("获取到用户CDKey: " + cdkey.getGameName() + " - " + cdkey.getCdkey());
            }
        }
        return cdkeyList;
    }

    // 根据订单ID获取CDKey列表
    @Override
    public List<CdkeyVO> getOrderCdkeys(Integer orderId) {
        if (orderId == null || orderId <= 0) {
            return null; // 参数验证
        }
        List<CdkeyVO> cdkeyList = cdkeyStockMapper.selectOrderCdkeys(orderId);
        // 对返回的数据进行格式化处理
        if (cdkeyList != null) {
            for (CdkeyVO cdkey : cdkeyList) {
                // 这里不需要额外格式化，因为SQL中已经使用了正确的别名
                System.out.println("获取到订单CDKey: " + cdkey.getGameName() + " - " + cdkey.getCdkey());
            }
        }
        return cdkeyList;
    }
    //查看用户订单的游戏cdkey





}
