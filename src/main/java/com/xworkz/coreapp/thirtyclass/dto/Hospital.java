package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor@Data
@ToString

public class Hospital {

    private String name;
    private String location;
    private int doctors;
    private int nurses;
    private int beds;
    private boolean emergencyAvailable;
    private int establishedYear;
    private long contact;
}
