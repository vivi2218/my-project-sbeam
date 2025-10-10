package com.sbeam.sbeam;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.sbeam.sbeam.mapper")
@SpringBootApplication
public class SbeamApplication {

	public static void main(String[] args) {
		SpringApplication.run(SbeamApplication.class, args);
	}

}
