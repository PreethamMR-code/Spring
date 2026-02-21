package com.xworkz.forms.entity;


import com.xworkz.forms.DTO.VendorDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "vendor_table")
public class VendorEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int age;
    private char gender;
    private long phone;
    private float rating;
    private double turnover;
    private boolean active;
    private short associationYears;
    private byte level;


    public VendorEntity(VendorDTO dto) {
        this.name = dto.getName();
        this.age = dto.getAge();
        this.gender = dto.getGender().charAt(0); // String → char
        this.phone = dto.getPhone();
        this.rating = dto.getRating();
        this.turnover = dto.getTurnover();
        this.active = dto.getActive();
        this.associationYears = dto.getAssociationYears();
        this.level = dto.getLevel();
    }


}
