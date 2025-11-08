package com.sbeam.sbeam.controller;

import com.sbeam.sbeam.entity.VO.CdkeyVO;
import com.sbeam.sbeam.service.ICdkeyStockService;
import com.sbeam.sbeam.util.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

/**
 * CDKey控制器
 * 提供获取用户CDKey的API接口
 */
@RestController
@RequestMapping("/cdkey")
@CrossOrigin(origins = "*")
public class CdkeyController {

    private static final Logger logger = LoggerFactory.getLogger(CdkeyController.class);
    
    @Autowired
    private ICdkeyStockService cdkeyStockService;

    /**
     * 根据用户ID获取用户的所有CDKey
     * @param userId 用户ID
     * @return CDKey列表
     */
    @GetMapping("/user/{userId}")
    public List<CdkeyVO> getUserCdkeys(@PathVariable Integer userId) {
        logger.info("开始获取用户CDKey，用户ID: {}", userId);


            List<CdkeyVO> cdkeyList = cdkeyStockService.getUserCdkeys(userId);


            return cdkeyList;

    }

    /**
     * 根据订单ID获取该订单下的所有CDKey
     * @param orderId 订单ID
     * @return CDKey列表
     */
    @GetMapping("/order/{orderId}")
    public List<CdkeyVO> getOrderCdkeys(@PathVariable Integer orderId) {
        logger.info("开始获取订单CDKey，订单ID: {}", orderId);
        List<CdkeyVO> cdkeyList = cdkeyStockService.getOrderCdkeys(orderId);
        return cdkeyList;
    }





}