package com.xworkz.coreapp.internet;

import org.springframework.stereotype.Component;

@Component
public class Sports {

    private String sportsName;
    private String equipment;

    public void setSportsName(String sportsName) {
        this.sportsName = sportsName;
    }

    public String getSportsName() {
        return sportsName;
    }

    public void setEquipment(String equipment) {
        this.equipment = equipment;
    }

    public String getEquipment() {
        return equipment;
    }

    @Override
    public String toString() {
        return "Sports{" +
                "sportsName='" + sportsName + '\'' +
                ", equipment='" + equipment + '\'' +
                '}';
    }

    public Sports(){
        System.out.println("sports con created");
    }
}
