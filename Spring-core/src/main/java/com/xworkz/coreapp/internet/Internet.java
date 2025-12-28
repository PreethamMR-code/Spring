package com.xworkz.coreapp.internet;

import org.springframework.stereotype.Component;

@Component
public class Internet {

    private int id;
    private String name;

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public Internet(){
        System.out.println("internet constructor created");
    }

    @Override
    public String toString() {
        return "Internet{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
