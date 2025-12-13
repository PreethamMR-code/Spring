package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@AllArgsConstructor
@ToString
public class Laptop {

    private String brand;
    private String model;
    private int price;
    private int ram;
    private int storage;
    private String processor;
    private double weight;
    private String color;
}
