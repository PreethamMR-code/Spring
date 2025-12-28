package com.xworkz.coreapp.internet;

import org.springframework.stereotype.Component;

@Component
public class President {

    private String presidentName;
    private String country;

    public void setPresidentName(String presidentName) {
        this.presidentName = presidentName;
    }

    public String getPresidentName() {
        return presidentName;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCountry() {
        return country;
    }

    @Override
    public String toString() {
        return "President{" +
                "presidentName='" + presidentName + '\'' +
                ", country='" + country + '\'' +
                '}';
    }

    public President(){
        System.out.println("president con created");
    }
}
