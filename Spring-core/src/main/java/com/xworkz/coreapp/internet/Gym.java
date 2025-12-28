package com.xworkz.coreapp.internet;

import org.springframework.stereotype.Component;

@Component
public class Gym {

    private String gymName;
    private String gymOwner;

    public void setGymName(String gymName) {
        this.gymName = gymName;
    }

    public String getGymName() {
        return gymName;
    }

    public void setGymOwner(String gymOwner) {
        this.gymOwner = gymOwner;
    }

    public String getGymOwner() {
        return gymOwner;
    }

    @Override
    public String toString() {
        return "Gym{" +
                "gymName='" + gymName + '\'' +
                ", gymOwner='" + gymOwner + '\'' +
                '}';
    }

    public Gym(){
        System.out.println("gym cons started");
    }
}
