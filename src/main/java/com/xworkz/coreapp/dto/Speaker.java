package com.xworkz.coreapp.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString

public class Speaker {

    private String brand;
    private String model;
    private int watt;
    private boolean bluetooth;
    private boolean waterproof;
    private double price;
    private String color;
    private int batteryHours;
}
