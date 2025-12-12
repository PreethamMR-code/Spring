package com.xworkz.coreapp.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
public class SmartWatch {

    private String brand;
    private String model;
    private double screenSize;
    private boolean heartMonitor;
    private boolean gps;
    private int batteryHours;
    private String strapMaterial;
    private double price;
}
