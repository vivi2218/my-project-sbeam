package com.sbeam.sbeam.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.sbeam.sbeam.config.AlipayConfig;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.entity.PaymentRecords;
import com.sbeam.sbeam.service.IMyorderService;
import com.sbeam.sbeam.service.IPaymentRecordsService;
import com.sbeam.sbeam.util.Result;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

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
@RequestMapping("/paymentRecords")
public class PaymentRecordsController {

    @Autowired
    private IMyorderService myorderService;
    @Autowired
    private IPaymentRecordsService paymentRecordsService;
    @Autowired
    private RabbitTemplate rabbitTemplate;
    //------------------调用支付宝支付
    @PostMapping
    public String alipay(@RequestBody Myorder myorder, HttpServletResponse response) throws AlipayApiException {
        System.out.println("支付alipay orderID = " + myorder.getOrderId());
        AlipayClient alipayClient =  new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id,
                AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
        //创建API对应的request
        AlipayTradePagePayRequest alipayRequest =  new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url );
        //在公共参数中设置回跳和通知地址
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);
        String timeout_express = "1c";
        String body="";

        alipayRequest.setBizContent("{\"out_trade_no\":\"" + myorder.getOrderNumber() + "\","
                + "\"total_amount\":\"" + myorder.getFinalPrice() + "\","
                + "\"subject\":\"" + myorder.getCartId() + "\","
                + "\"body\":\"" + body + "\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        String result = alipayClient.pageExecute(alipayRequest).getBody();  // 调用支付宝接口，并给出响应数据
        System.out.println("执行支付请求后，result:" + result);

        return  result;
    }

    //---------------同步请求 支付宝调用接受后,数据响应,展示流水信息
    @GetMapping("alipayReturnNotice")
    public void alipayReturnNotice(HttpServletRequest request, HttpServletResponse response) throws IOException, AlipayApiException, ServletException {
        System.out.println("同步请求，支付成功后，支付宝的返回数据是：" + request);

        //商户订单号
        String orderNum = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");
        //支付宝交易号
        String tradeNo = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");
        //付款金额
        String payPrice = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"), "UTF-8");

        System.out.println("return orderNum:" + orderNum);
        System.out.println("return tradeNo:" + tradeNo);
        System.out.println("return payPrice:" + payPrice);

        // 添加流水
        Myorder orders =(Myorder)  myorderService.getByOrderNumber(orderNum).getData();

        if(orders!=null){
            orders.setOrderStatus("paid");
            myorderService.updateById(orders);

            PaymentRecords paymentRecords = new PaymentRecords();
            paymentRecords.setPayerId(orders.getUserId());
            paymentRecords.setOrderId(orders.getOrderId());
            paymentRecords.setTransactionAmount(orders.getFinalPrice());

            Result result = paymentRecordsService.saveAndReturn(paymentRecords);

            PaymentRecords  paymentRecords1= (PaymentRecords) result.getData();
            //通知RabbitMQ停止监听此订单
            //rabbitTemplate.convertAndSend("order.cancel.exchange", "order.cancel.stop", orders.getOrderId());
        }

        //页面跳转 **已支付成功**
        String vueUrl = "http://localhost:5173/paysuccess" ;//+ paymentRecords1.getPaymentId();
        response.sendRedirect(vueUrl);
    }

    // 异步请求回调
    @PostMapping("alipayNotifyNotice")
    @ResponseBody
    public String alipayNotifyNotice(HttpServletRequest request) throws AlipayApiException, UnsupportedEncodingException {
        System.out.println("异步请求，支付成功后，支付宝的返回数据是：" + request);
        //商户订单号
        String orderNum = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");
        //支付宝交易号
        String tradeNo = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");
        //付款金额
        String payPrice = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"), "UTF-8");

        System.out.println("return orderNum:" + orderNum);
        System.out.println("return tradeNo:" + tradeNo);
        System.out.println("return payPrice:" + payPrice);

        //
        Myorder orders =(Myorder)  myorderService.getByOrderNumber(orderNum).getData();
        PaymentRecords paymentRecords = new PaymentRecords();
        paymentRecords.setOrderId(orders.getOrderId());




        // 添加流水 , 修改订单状态
        //Result result = paymentRecordsService.save(paymentRecords);
        return  "success";
    }
}
