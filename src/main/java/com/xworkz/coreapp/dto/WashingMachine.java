package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@ToString

public class WashingMachine {

    private String brand;
    private String type;
    private double capacityKg;
    private boolean dryerAvailable;
    private String energyRating;
    private double price;
    private String color;
    private int warrantyYears;
}
