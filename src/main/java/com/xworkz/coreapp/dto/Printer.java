package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
public class Printer {

    private String brand;
    private String type;
    private boolean colorPrint;
    private int pagesPerMinute;
    private boolean wifiSupport;
    private double price;
    private String model;
    private int warrantyYears;
}
