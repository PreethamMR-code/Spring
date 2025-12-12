package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
public class Zoo {

    private String name;
    private String location;
    private int animalsCount;
    private int staffCount;
    private boolean safariRide;
    private int establishedYear;
    private double areaAcres;
    private long contact;
}
