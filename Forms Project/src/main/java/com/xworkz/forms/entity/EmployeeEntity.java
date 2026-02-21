package com.xworkz.forms.entity;


import com.xworkz.forms.DTO.EmployeeDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "employee_table")
public class EmployeeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int age;
    private char gender;
    private long phone;
    private float performance;
    private double salary;
    private boolean active;
    private short experience;
    private byte level;



    // ✅ REQUIRED BY SERVICE
    public EmployeeEntity(EmployeeDTO dto) {
        this.name = dto.getName();
        this.age = dto.getAge();
        this.gender = dto.getGender().charAt(0); // IMPORTANT
        this.phone = dto.getPhone();
        this.performance = dto.getPerformance();
        this.salary = dto.getSalary();
        this.active = dto.getActive();
        this.experience = dto.getExperience();
        this.level = dto.getLevel();
    }

}
