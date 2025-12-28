package com.xworkz.coreapp.internet;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@Data
@AllArgsConstructor
@ToString
public class College {

    private String  name;
    private String location;
}
