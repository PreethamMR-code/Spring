package com.xworkz.coreapp.autowired.terminal;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@Data
@NoArgsConstructor

public class FlightName {

    private String flightName;
    private Double timing;


}
