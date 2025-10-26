package com.sbeam.sbeam.config;

public class AlipayConfig {
    //支付宝沙箱应用ID
    public static String app_id = "9021000155639785";//APP_ID

    //应用私钥
    public static String merchant_private_key ="MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCKkTHZuzJq71Yw6PtYmfsOkOz1XmHZDSgVJQoRao4jUlYrzwQofHdJTgx9v4vOsM1m6tq6MscJnTTAd/NhvWNmDd5YuW4pf/CL8mwJNkkNwipkgvoPU1Wyo4UAyqBgr3Hj+VFUDcB7msSiW9mjy+MZvjCEbO8HZujcB9z8KWFHIitwrPdK8RriW7NbW+zKIS+bW4MKdNA/1hsBoxZzqVdWg7JcWAcxsiD4J7pvtMP13T3u7vUUOC20qxY6iTg9+Xc4HokuiRZKO2QJPYI6IYnwtG5kPurDlhLCD/yL28snYkoT2Wy2nK4P1GW3j1ru6eXGGQ/Ibns6M+44uoxPWq1NAgMBAAECggEAX4PcQACorUuTNx2x/A4QH6dIn45SlmJaSdEBUqYHmlNsMMB/VkUNmMsjEx8RCQWYYKPs58KOrpLdxPoqGyqINNXEeZZAWHznXCBb1jHEQ6aewDAEnMHN5diPms8Ro/Pr5sB6Dh14m/tAJcZ4jE7DmYAfQ3kvfwOx6dHFw0/mzTe7S4z8gQx7HU5K2uFFe2w+ezWE/ZDccOIMwj4POcI8TZlIySW4Id6jO9U1YvdnWcw/DUZSF8AQwP1A5siD8mJ/vR+NroOxks3Mot2rje8XE8K1RjqUaId6p713iXKv43Vv4XlIVDZ6b6IsnqStyKFSt27Y8Mrv1bW6hV/o1bYSBQKBgQDY1IzC5PDYbP7AZxWY4mRbtw06QapR3QCJtn9eSpz+pOBcJwoKt5GfaovieUurA3E7CiUA71g+rpioymZLNWcfP3VJbSerairBJQD7cuiS5wfXfovyJp2aYT7UyOqovJb794HBVZHu05pMC1yV6YPH+C3iVkBpI6eI0esncnTf0wKBgQCjmVGxZz9wOxaq95sqBIEMczlJmZHo/3xj7cA32MweNoLS56M4Qk3bd2dOE2Lm20T6mDAdFLqeyskMTWVx55rk611zShL+UXfIJbcUwfuR/MK5Vcdm9pBrjYiPtvYAF5vNu//YgFur8GJPkjPpciO11gZUuZmYeUpEr7BmmtEqXwKBgGJkWRebYfsjwpo2bON6YAYKU7NK1unc+oCDUtrLyt/2m2TVxkXEtQz9AUsctYx9vGUJHm+FLKsM+XMmnTKlogzY8/UE1kp/m7UXgJGZvBXlRnawEvsoML48QJG4NlupcG4YC0Za+STB2rOFOFdCpq0YXmHlt8a+CikY8LduxcBHAoGAKyF6tiigQvhxC3XoBHXXh+7AxbSlESZ6JuZBbPfNKJH6f5vuHiDs4dVi+OSHiJF6aA7DcIdMhBy2UHX/Lr5+yad7pa97vmzABZZb5C8YIe7fb3k77ttGS/SuciUsSe3vd5f+5ZdBk9z2LkA/S2Z6H7BjTub3pYkkmWMwQHzEdEUCgYEA0NpjzVxuAxUkuXvpUgq+WBAm28DUpbqnR8JReor3s92k5fe75/cpRZx8KJruj9h/TZZgcizohVdAoctGFuA2ZPLhH3+y5n33HF/gBjW6lpeXJ8IdCtD3D4Bhgp/kt+4GvCHB4OHc1CNgsCACynlv0+vm+NyViaEnGxjB2u5y2lc=";

    //支付宝公钥
    public static String alipay_public_key =  "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5c5iRZny3rf8dRCHyOwdBXTL/3dcYuxvCox+9cBGfHptZ4lKUnvWh+3aDNvnynHKChwa6kOBPDMd6R6n1YopguI54Eio1+6f5sv8t/8FAISqhAil24l+uGTPQMLVHyOvUwZGIBFKAGudZuen+yApLwbjC/E+qc3pxO6Q5K18irsyLQffGwLzN5u3mG/Y+5wqHMsLiLraG/wEb/l8uptvyPeoRcDOFkqLmEY7tiObdmobm+Z8Zuh6NtfIfKAP+DHH1TA1G4MlNbfJDkhwjPAv5MO/ysQIyaEjCO404tul+d8qYWvhAghnXH1/hjMSN5ZKcEX5uhyT4CocpssvQIcsRQIDAQAB";

    //支付宝异步通知路径,付款完毕后会异步调用本项目的方法,必须为公网地址
    public static String notify_url =  "http://localhost:8080/paymentRecords/alipayNotifyNotice";

    //支付宝同步通知路径,也就是当付款完毕后,跳转本项目的页面,可以不是公网地址
    public static String return_url = "http://localhost:8080/paymentRecords/alipayReturnNotice";

    //签名方式
    public static String sign_type = "RSA2";
    public static String charset = "utf-8";
    //注意:沙箱测试环境,正式环境为:https://https://openapi.alipay.com/gateway.do
    public static String gatewayUrl = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";

}
