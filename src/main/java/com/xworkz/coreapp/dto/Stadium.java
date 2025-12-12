package com.xworkz.coreapp.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString

public class Stadium {

    private String name;
    private String city;
    private int capacity;
    private String homeTeam;
    private boolean roofCovered;
    private int establishedYear;
    private double groundArea;
    private boolean floodLights;
}
