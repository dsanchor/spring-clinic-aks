package org.springframework.samples.petclinic.customers;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Maciej Szarlinski
 */
@SpringBootApplication
public class CustomersServiceApplication {

    private static final Logger LOGGER = LoggerFactory.getLogger(CustomersServiceApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(CustomersServiceApplication.class, args);
    }

}