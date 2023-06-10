package com.solution.escort;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
public class EscortApplication {

	public static void main(String[] args) {
		SpringApplication.run(EscortApplication.class, args);
	}


}
