package com.xworkz.coreapp.thirtyclass.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@ToString
@Data

public class Restaurant {

    private String name;
    private String location;
    private int tables;
    private int staffCount;
    private String cuisineType;
    private double rating;
    private boolean openNow;
    private long contact;
}
