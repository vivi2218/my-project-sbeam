package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Getter
@Setter
@TableName("payment_records")
@ApiModel(value = "PaymentRecords对象", description = "")
public class PaymentRecords implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("支付ID")
    @TableId(value = "payment_id", type = IdType.AUTO)
    private Integer paymentId;

    @ApiModelProperty("支付者ID")
    private Integer payerId;

    @ApiModelProperty("订单ID")
    private Integer orderId;

    @ApiModelProperty("交易编号")
    private String transactionNumber;

    @ApiModelProperty("交易金额")
    private BigDecimal transactionAmount;

    @ApiModelProperty("支付时间")
    private LocalDateTime paymentTime;

    @ApiModelProperty("支付状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;
}
