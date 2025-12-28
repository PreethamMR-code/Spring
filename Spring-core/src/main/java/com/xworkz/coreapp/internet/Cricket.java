package com.xworkz.coreapp.internet;

import org.springframework.stereotype.Component;

@Component
public class Cricket {

    private String name;
    private int age;

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getAge() {
        return age;
    }

    public  Cricket(){
        System.out.println("cricket cons run");
    }

    @Override
    public String toString() {
        return "Cricket{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
