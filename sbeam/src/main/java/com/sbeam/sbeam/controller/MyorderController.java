package com.sbeam.sbeam.controller;


import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.service.IMyorderService;
import com.sbeam.sbeam.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author smith
 * @since 2025-10-07
 */
@RestController
@RequestMapping("/myorder")
public class MyorderController {
    @Autowired
    private IMyorderService myorderService;
    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id){
        return  myorderService.getById(id);
    }
    @PostMapping("/add")
    public Result addOrder(@RequestBody Myorder myorder){
        return  myorderService.addOrder(myorder);
    }
    @PutMapping("/update")
    public Result updateOrder(@RequestBody Myorder myorder){
        return myorderService.updateOrder(myorder);
    }
    @DeleteMapping("/delete")
    public Result deleteOrder(@RequestBody Myorder myorder){
        return myorderService.deleteOrder(myorder);
    }

    /**
     * 分页查询订单列表
     */
    @GetMapping("/list")
    public Result listOrders(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        return myorderService.getOrderList(pageNum, pageSize);
    }


}
