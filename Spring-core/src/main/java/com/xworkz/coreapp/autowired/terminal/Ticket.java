package com.xworkz.coreapp.autowired.terminal;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class Ticket {

    private int price;
    private long ticketNumber;
}
