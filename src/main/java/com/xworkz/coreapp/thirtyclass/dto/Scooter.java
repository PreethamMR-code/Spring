package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
public class Scooter {

    private String brand;
    private String model;
    private int engineCC;
    private double mileage;
    private double price;
    private String color;
    private int topSpeed;
    private boolean electricStart;
}
