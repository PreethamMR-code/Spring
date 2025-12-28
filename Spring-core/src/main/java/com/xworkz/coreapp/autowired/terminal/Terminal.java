package com.xworkz.coreapp.autowired.terminal;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
//@ToString
@Setter
@Getter


//@Scope("prototype")
public class Terminal {

    private String name;

    public Terminal(){
        System.out.println("terminal con created");
    }
}
