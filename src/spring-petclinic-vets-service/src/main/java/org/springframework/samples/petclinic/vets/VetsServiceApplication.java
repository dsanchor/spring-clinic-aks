package org.springframework.samples.petclinic.vets;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Maciej Szarlinski
 */
@SpringBootApplication
public class VetsServiceApplication {

    private static final Logger LOGGER = LoggerFactory.getLogger(VetsServiceApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(VetsServiceApplication.class, args);
    }

}