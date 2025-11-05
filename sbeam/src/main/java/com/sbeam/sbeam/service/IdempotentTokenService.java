package com.sbeam.sbeam.service;


public interface IdempotentTokenService {
    String createToken(Integer userId);

    boolean checkToken(String token,String value);

}
