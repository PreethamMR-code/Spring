package com.xworkz.coreapp.thirtyclass.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@ToString@Data
@AllArgsConstructor
public class Teacher {

    private String name;
    private int experience;
    private String subject;
    private String qualification;
    private double salary;
    private int age;
    private String department;
    private long phone;
}
