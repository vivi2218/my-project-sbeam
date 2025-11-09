package com.sbeam.sbeam.entity.VO;

import com.sbeam.sbeam.entity.Cart;
import lombok.Data;
import java.util.List;

/**
 * 订单事件对象
 * 用于MQ传递订单创建所需的数据
 */
@Data
public class OrderEvent {
    private Integer userId;
    private List<Cart> cartList;
    private String pollingKey;// 用于前端轮询用的 Redis key
    
    public OrderEvent() {
    }
    
    public OrderEvent(Integer userId, List<Cart> cartList,String pollingKey) {
        this.userId = userId;
        this.cartList = cartList;
        this.pollingKey=pollingKey;
    }
}