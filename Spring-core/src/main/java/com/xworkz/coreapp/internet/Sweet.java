package com.xworkz.coreapp.internet;

import org.springframework.stereotype.Component;

@Component
public class Sweet {

    private String sweetName;
    private int price;

    public void setSweetName(String sweetName) {
        this.sweetName = sweetName;
    }

    public String getSweetName() {
        return sweetName;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPrice() {
        return price;
    }

    @Override
    public String toString() {
        return "Sweet{" +
                "sweetName='" + sweetName + '\'' +
                ", price='" + price + '\'' +
                '}';
    }

    public Sweet(){
        System.out.println("sweet con started");
    }
}
