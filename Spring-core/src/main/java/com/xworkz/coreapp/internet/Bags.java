package com.xworkz.coreapp.internet;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@ToString
@Data
@Component
public class Bags {
    private String brand;
    private int price;

    @Autowired
    public Bags(@Value("ROLEX") String brand, @Value("1111111111") int price){
        this.brand = brand;
        this.price=price;
    }

    public Bags(){
        System.out.println("default is called======================================================");
    }
}
