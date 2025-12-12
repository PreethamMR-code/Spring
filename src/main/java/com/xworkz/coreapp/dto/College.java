package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString

public class College {

    private String name;
    private String university;
    private int departments;
    private int students;
    private double rating;
    private int establishedYear;
    private String location;
    private boolean hostelAvailable;
}
