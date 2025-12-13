package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString

@AllArgsConstructor
public class Train {

    private String name;
    private int number;
    private String source;
    private String destination;
    private int coaches;
    private double speed;
    private boolean acAvailable;
    private String operationDays;
}
