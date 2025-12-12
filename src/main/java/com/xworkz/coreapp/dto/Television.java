package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString

public class Television {

    private String brand;
    private double screenSize;
    private String resolution;
    private boolean smartTV;
    private String panelType;
    private double price;
    private int hdmiPorts;
    private String color;
}
