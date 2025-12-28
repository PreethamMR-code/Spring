package com.xworkz.coreapp.internet;

import org.springframework.stereotype.Component;

@Component
public class Street {

    private String streetName;
    private String city;

    public void setStreetName(String streetName) {
        this.streetName = streetName;
    }

    public String getStreetName() {
        return streetName;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCity() {
        return city;
    }

    @Override
    public String toString() {
        return "Street{" +
                "streetName='" + streetName + '\'' +
                ", city='" + city + '\'' +
                '}';
    }

    public Street(){
        System.out.println("street con started");
    }
}

