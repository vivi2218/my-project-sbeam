package com.sbeam.sbeam.entity.VO;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class GamePriceHistoryVO {
    private LocalDateTime priceDate;
    private BigDecimal price;

    public LocalDateTime getPriceDate() {
        return priceDate;
    }

    public void setPriceDate(LocalDateTime priceDate) {
        this.priceDate = priceDate;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "GamePriceHistoryVO{" +
                "priceDate=" + priceDate +
                ", price=" + price +
                '}';
    }
}
