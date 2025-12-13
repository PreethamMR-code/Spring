package com.xworkz.coreapp.thirtyclass.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@ToString

public class Student {

    private String name;
    private int age;
    private String course;
    private int rollNumber;
    private String college;
    private double percentage;
    private String address;
    private long phone;
}
