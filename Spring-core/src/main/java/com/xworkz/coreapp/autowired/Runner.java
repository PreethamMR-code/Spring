package com.xworkz.coreapp.autowired;

import com.xworkz.coreapp.autowired.airport.Airport;
import com.xworkz.coreapp.autowired.terminal.FlightName;
import com.xworkz.coreapp.autowired.terminal.Terminal;
import com.xworkz.coreapp.autowired.terminal.Ticket;
import com.xworkz.coreapp.config.InternetConfig;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class Runner {

    public static void main(String[] args) {

        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(InternetConfig.class);

        Airport airport = (Airport) applicationContext.getBean("airportBean");  // down casting  parent to child
//                    OR
//        Airport airport = applicationContext.getBean(Airport.class);

        airport.setAirportName("Kempe Gowda");
        System.out.println(airport);


        Airport airport1 = applicationContext.getBean(Airport.class);
        airport1.setAirportName("PREETHU");
        System.out.println(airport1);


        Airport airport2 = applicationContext.getBean(Airport.class);
        airport2.setAirportName("PREETHUACVGVYUYSCN");
        System.out.println(airport2);


//        ===========================================

        Terminal terminal = airport.getTerminal();
        System.out.println(terminal);

        Terminal terminal1 = airport1.getTerminal();
        System.out.println(terminal1);

        Terminal terminal2 = airport2.getTerminal();
        System.out.println(terminal2);



//        ====================================================

        FlightName flightName = airport.getFlightName();
        flightName.setFlightName("King Fisher");
        flightName.setTiming(03.00);
//        ======================================================



        Ticket ticket = airport.getTicket();
        ticket.setPrice(2500);
        ticket.setTicketNumber(12345678L);




    }
}
