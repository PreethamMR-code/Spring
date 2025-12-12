package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
public class Refrigerator {

    private String brand;
    private int capacityLiters;
    private boolean doubleDoor;
    private String energyRating;
    private String color;
    private double price;
    private double height;
    private double width;
}


