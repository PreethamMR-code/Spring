package com.xworkz.coreapp.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString
public class Shop {

    private String owner;
    private String type;
    private String location;
    private double monthlyRevenue;
    private int employees;
    private int yearOpened;
    private boolean homeDelivery;
    private long contact;
}
