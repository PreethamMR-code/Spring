package com.xworkz.coreapp.internet;

import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@Data@ToString
public class Person {

    private String personName;
    private long mobileNo;
}
