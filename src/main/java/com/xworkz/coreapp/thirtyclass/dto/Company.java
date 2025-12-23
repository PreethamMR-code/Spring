package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString

public class Company {

    private String name;
    private String industry;
    private int employees;
    private String headquarters;
    private double revenue;
    private int establishedYear;
    private String ceo;
    private boolean multinational;
}
