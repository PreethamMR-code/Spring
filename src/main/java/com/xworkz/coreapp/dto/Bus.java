package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
@Component
public class Bus {

    private String company;
    private String route;
    private int seatingCapacity;
    private boolean ac;
    private double fuelCapacity;
    private int yearOfManufacture;
    private String driverName;
    private boolean gpsInstalled;
}
