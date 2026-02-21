package com.xworkz.forms.entity;


import com.xworkz.forms.DTO.CustomerDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "customer_table")
public class CustomerEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int age;
    private char gender;
    private long phone;
    private float rating;
    private double totalPurchase;
    private boolean active;
    private short loyaltyYears;
    private byte level;

    public CustomerEntity(CustomerDTO dto) {
        this.name = dto.getName();
        this.age = dto.getAge();
        this.gender = dto.getGender().charAt(0); // String → char
        this.phone = dto.getPhone();
        this.rating = dto.getRating();
        this.totalPurchase = dto.getTotalPurchase();
        this.active = dto.getActive();
        this.loyaltyYears = dto.getLoyaltyYears();
        this.level = dto.getLevel();
    }

}

