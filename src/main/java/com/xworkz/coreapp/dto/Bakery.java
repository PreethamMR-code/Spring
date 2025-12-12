package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@NoArgsConstructor
@Component
@AllArgsConstructor
public class Bakery {

    private String name;
    private String location;
    private int staffCount;
    private boolean onlineDelivery;
    private int dailyCustomers;
    private double rating;
    private long contact;
    private int establishedYear;
}
