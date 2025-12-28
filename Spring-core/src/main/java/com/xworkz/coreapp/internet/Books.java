package com.xworkz.coreapp.internet;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@ToString
@Data
@AllArgsConstructor
public class Books {

    private String title;
    private int price;
}
