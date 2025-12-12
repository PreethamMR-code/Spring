package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data@ToString@AllArgsConstructor
public class House {

    private String owner;
    private String location;
    private int floors;
    private int rooms;
    private boolean furnished;
    private double areaSqft;
    private double price;
    private int yearBuilt;
}
