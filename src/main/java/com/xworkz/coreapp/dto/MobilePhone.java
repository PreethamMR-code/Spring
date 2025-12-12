package com.xworkz.coreapp.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString

public class MobilePhone {


    private String brand;
    private String model;
    private double screenSize;
    private int batteryMah;
    private int ram;
    private int storage;
    private double price;
    private String color;
}
