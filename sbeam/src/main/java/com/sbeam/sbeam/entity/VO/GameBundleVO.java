package com.sbeam.sbeam.entity.VO;

public class GameBundleVO {
    private String bundleName;
    private String discountPolicy;

    public String getBundleName() {
        return bundleName;
    }

    public void setBundleName(String bundleName) {
        this.bundleName = bundleName;
    }

    public String getDiscountPolicy() {
        return discountPolicy;
    }

    public void setDiscountPolicy(String discountPolicy) {
        this.discountPolicy = discountPolicy;
    }

    @Override
    public String toString() {
        return "GameBundleVO{" +
                "bundleName='" + bundleName + '\'' +
                ", discountPolicy='" + discountPolicy + '\'' +
                '}';
    }
}
