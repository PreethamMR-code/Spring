package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString

public class Bicycle {
    private String brand;
    private String type;
    private int gears;
    private double wheelSize;
    private double weight;
    private String color;
    private double price;
    private String brakeType;
}
