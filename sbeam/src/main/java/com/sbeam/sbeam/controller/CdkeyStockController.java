package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.CdkeyStock;
import com.sbeam.sbeam.service.ICdkeyStockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

/**
 * <p>
 * CDKey库存表 前端控制器
 * </p>
 *
 * @author smith
 * @since 2025-10-31
 */
@RestController
@RequestMapping("/cdkeyStock")
public class CdkeyStockController {
    @Autowired
    private ICdkeyStockService cdkeyStockService;
    @PostMapping()
    public void addCdkey(@RequestBody CdkeyStock cdkeyStock){
        cdkeyStockService.addCdk(cdkeyStock);
    }
    @GetMapping
    public void  getAll(){

    }
}
