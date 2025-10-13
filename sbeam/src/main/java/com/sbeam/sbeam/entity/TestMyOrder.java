package com.sbeam.sbeam.entity;

public class TestMyOrder {
    private String proName;
    private Float proPrice;
    private Integer proNumber;
    private Float orderPrice;

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public Float getProPrice() {
        return proPrice;
    }

    public void setProPrice(Float proPrice) {
        this.proPrice = proPrice;
    }

    public Integer getProNumber() {
        return proNumber;
    }

    public void setProNumber(Integer proNumber) {
        this.proNumber = proNumber;
    }

    public Float getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Float orderPrice) {
        this.orderPrice = orderPrice;
    }

    @Override
    public String toString() {
        return "TestMyOrder{" +
                "proName='" + proName + '\'' +
                ", proPrice=" + proPrice +
                ", proNumber=" + proNumber +
                ", orderPrice=" + orderPrice +
                '}';
    }
}
