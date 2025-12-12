package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
@Component
@NoArgsConstructor
public class Bank {

    private String name;
    private String branch;
    private long ifsc;
    private int employees;
    private boolean atmAvailable;
    private double dailyTransactions;
    private String manager;
    private int establishedYear;
}
