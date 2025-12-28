package com.xworkz.coreapp.concept;

import org.springframework.stereotype.Component;

@Component
public class TraineeImpl implements Trainee{


    @Override
    public void addTrainee() {

        System.out.println("invoking add trainee");
    }
}
