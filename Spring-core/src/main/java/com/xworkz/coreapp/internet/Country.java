package com.xworkz.coreapp.internet;

import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@Data@ToString
public class Country {

    private String name;
    private  String  capital;
}
