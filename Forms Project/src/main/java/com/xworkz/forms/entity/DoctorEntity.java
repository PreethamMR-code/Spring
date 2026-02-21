package com.xworkz.forms.entity;

import com.xworkz.forms.DTO.DoctorDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "doctor_table")
public class DoctorEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int age;
    private char gender;
    private long phone;
    private float rating;
    private double fee;
    private boolean active;
    private short experience;
    private byte level;

    // ✅ DTO → Entity mapping constructor
    public DoctorEntity(DoctorDTO dto) {
        this.name = dto.getName();
        this.age = dto.getAge();
        this.gender = dto.getGender().charAt(0); // String → char
        this.phone = dto.getPhone();
        this.rating = dto.getRating();
        this.fee = dto.getFee();
        this.active = dto.getActive();
        this.experience = dto.getExperience();
        this.level = dto.getLevel();
    }
}
