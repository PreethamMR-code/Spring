package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@ToString

public class Park {

    private String name;
    private String city;
    private boolean playArea;
    private boolean joggingTrack;
    private int treesCount;
    private double areaAcres;
    private String openingTime;
    private String closingTime;
}
