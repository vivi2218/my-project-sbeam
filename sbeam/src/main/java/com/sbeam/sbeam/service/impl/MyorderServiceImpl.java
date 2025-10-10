package com.sbeam.sbeam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.mapper.MyorderMapper;
import com.sbeam.sbeam.service.IMyorderService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author smith
 * @since 2025-10-07
 */
@Service
public class MyorderServiceImpl extends ServiceImpl<MyorderMapper, Myorder> implements IMyorderService {
    @Autowired
    private MyorderMapper myorderMapper;
    @Override
    public Result getById(Integer id) {
        Myorder myorder = myorderMapper.selectById(id);
        return  Result.getSuccess(myorder);
    }

    @Override
    public Result addOrder(Myorder myorder) {
        myorder.setCreatedAt(LocalDateTime.now());
        myorder.setUpdatedAt(LocalDateTime.now());
        myorder.setOrderStatus("unpaid");
        myorder.setStatus(0);//0表示正常
        int rows = myorderMapper.insert(myorder);
        if(rows>0){
            return Result.saveSuccess(myorder);
        }
        return Result.saveFail(null);
    }

    @Override
    public Result updateOrder(Myorder myorder) {
        myorder.setUpdatedAt(LocalDateTime.now());
        myorder.setOrderStatus("paid");
        myorder.setStatus(0);//0表示正常
        int rows = myorderMapper.updateById(myorder);
        if(rows>0){
            return Result.updateSuccess(myorder);
        }
        return Result.updateFail(myorder);
    }

    @Override
    public Result deleteOrder(Myorder myorder) {
        myorder.setUpdatedAt(LocalDateTime.now());
        myorder.setOrderStatus("paid");
        myorder.setStatus(1);//0表示正常,1表示异常
        int rows = myorderMapper.updateById(myorder);
        if(rows>0){
            return Result.deleteSuccess(myorder);
        }
        return Result.deleteFail(myorder);
    }

    @Override
    public Result getOrderList(Integer pageNum, Integer pageSize) {
        // 分页对象
        Page<Myorder> page = new Page<>(pageNum, pageSize);

        // 查询条件：只查 status = 0（未删除）
        LambdaQueryWrapper<Myorder> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Myorder::getStatus, 0)
                .orderByDesc(Myorder::getCreatedAt);

        // 执行分页查询
        this.page(page, wrapper);

        return Result.getSuccess(page);
    }
}
