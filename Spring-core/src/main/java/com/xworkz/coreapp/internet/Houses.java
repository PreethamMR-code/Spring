package com.xworkz.coreapp.internet;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString
@Component
public class Houses {

    private String location;
    private int price;
}
