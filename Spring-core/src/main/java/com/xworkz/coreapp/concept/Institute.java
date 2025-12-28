package com.xworkz.coreapp.concept;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Data
@NoArgsConstructor
@Component
public class Institute {

    @Value("1")
    private int id;

    @Value("X-workz")
    private String loc;


    @Autowired
    private Trainee trainee;

    public void addInstitute(){

        System.out.println("invoked addInstitute ");

        trainee.addTrainee();

        System.out.println("invoke done");
    }
}
