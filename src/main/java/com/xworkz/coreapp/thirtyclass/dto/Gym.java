package com.xworkz.coreapp.thirtyclass.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
public class Gym {

    private String name;
    private String location;
    private int trainers;
    private boolean personalTraining;
    private double membershipFee;
    private int machines;
    private String openingTime;
    private String closingTime;
}
