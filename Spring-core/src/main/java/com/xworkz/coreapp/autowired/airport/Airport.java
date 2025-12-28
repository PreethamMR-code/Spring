package com.xworkz.coreapp.autowired.airport;

import com.xworkz.coreapp.autowired.terminal.FlightName;
import com.xworkz.coreapp.autowired.terminal.Terminal;
import com.xworkz.coreapp.autowired.terminal.Ticket;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;


@Getter
@Setter
@Component("airportBean")
//@ToString


//@Scope("prototype")
public class Airport {

    private String airportName;

    @Autowired
    private Terminal terminal;

    @Qualifier
    FlightName flightName;

    @Autowired
    Ticket ticket;


    public Airport(){
        System.out.println("AIrport con created");
    }


}
