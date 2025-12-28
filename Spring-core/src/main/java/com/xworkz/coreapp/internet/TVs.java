package com.xworkz.coreapp.internet;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@ToString
@AllArgsConstructor
@Data
public class TVs {

    private String brand;
    private int price;
}
