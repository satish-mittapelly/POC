package com.poc.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PocApplication {

	public static void main(String[] args) {
		SpringApplication.run(PocApplication.class, args);
		System.out.println("Hey there how are you!");
	}

}
