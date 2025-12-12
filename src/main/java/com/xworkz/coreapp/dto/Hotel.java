package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString

@AllArgsConstructor
public class Hotel {
    private String name;
    private int rooms;
    private String location;
    private double rating;
    private boolean wifi;
    private boolean breakfastIncluded;
    private double pricePerNight;
    private int staffCount;
}
