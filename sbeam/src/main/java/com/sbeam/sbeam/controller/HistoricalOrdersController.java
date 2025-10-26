package com.sbeam.sbeam.controller;


import com.sbeam.sbeam.service.IHistoricalOrdersService;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@CrossOrigin
@RestController
@RequestMapping("/historicalOrders")

public class HistoricalOrdersController {
    @Autowired
    private IHistoricalOrdersService historicalOrdersService;
    //查询历史订单,建议修改到查询订单中吧
    @GetMapping("{id}")
    public Result getHistoricalOrder(@PathVariable Integer id){
        return historicalOrdersService.getHistoricalOrder(id);
    }
}
