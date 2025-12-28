package com.xworkz.coreapp.internet;

import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@ToString
@Data

public class Racing {

    private  String racingType;
    private String car;
}
