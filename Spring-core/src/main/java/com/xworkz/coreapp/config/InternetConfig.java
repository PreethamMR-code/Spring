package com.xworkz.coreapp.config;

import com.xworkz.coreapp.internet.Bikes;
import com.xworkz.coreapp.internet.Cars;
import com.xworkz.coreapp.internet.College;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;


@Configuration
@ComponentScan(basePackages = "com.xworkz.coreapp")
public class InternetConfig {

    public InternetConfig() {
        System.out.println("internet config started");
    }


    @Bean
    public String getName() {
        return "appName";
    }

    @Bean
    public Integer getAge() {
        return 5;
    }



    @Bean
    public List<String> getCafeName() {
        List<String> list = new ArrayList<>();
        list.add("MG ROAD");
        list.add("kormangala");
        return list;
    }

    @Bean("P1")
    public long phoneNo() {
        return 1234456;
    }

    @Bean("P2")
    public double weight() {
        return 66;
    }

    @Bean("P3")
    public char lastName() {
        return 'M';
    }

    @Bean("P4")
    public List<College> getCollege() {
        List<College> colleges = new ArrayList<>();
        colleges.add(new College("abc", "bgdf"));
        return colleges;
    }

        @Bean("P5")
        public List<Bikes> getBikes(){
        List<Bikes> bikes = new ArrayList<>();
        bikes.add(new Bikes("DUCATI",20));

        return bikes;
        }

        @Bean("P6")
        public List<Cars> cars(){
        List<Cars> cars = new ArrayList<>();
        cars.add(new Cars("BMW",25000000));

        return cars;
        }



}
