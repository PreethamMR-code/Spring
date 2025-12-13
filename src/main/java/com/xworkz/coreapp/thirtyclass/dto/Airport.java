package com.xworkz.coreapp.thirtyclass.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
@Component
public class Airport {

    private String name;
    private String city;
    private int terminals;
    private int runways;
    private long dailyPassengers;
    private boolean international;
    private int staffCount;
    private int yearOpened;

//    public Airport(){
//        System.out.println("Airport con created  || you have to create con or add annotation  no arg con");
//    }
}
