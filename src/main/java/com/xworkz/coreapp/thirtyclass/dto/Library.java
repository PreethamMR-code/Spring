package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
public class Library {

    private String name;
    private String location;
    private int booksCount;
    private int staff;
    private boolean digitalAccess;
    private int members;
    private int establishedYear;
    private String workingHours;
}
