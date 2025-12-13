package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@ToString
@AllArgsConstructor
public class Pharmacy {

    private String name;
    private String location;
    private boolean open24hrs;
    private int staffCount;
    private int medicinesAvailable;
    private long contact;
    private boolean homeDelivery;
    private int establishedYear;
}
