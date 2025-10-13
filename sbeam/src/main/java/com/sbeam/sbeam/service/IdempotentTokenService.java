package com.sbeam.sbeam.service;


public interface IdempotentTokenService {
    String createToken();

    boolean checkToken(String token);

}
