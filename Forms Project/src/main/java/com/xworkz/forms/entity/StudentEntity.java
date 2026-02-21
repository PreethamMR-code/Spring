package com.xworkz.forms.entity;

import com.xworkz.forms.DTO.StudentDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "student_table")
public class StudentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int age;
    private char gender;
    private long phone;
    private float rating;
    private double fees;
    private boolean active;
    private short semester;
    private byte grade;



    // ✅ REQUIRED BY SERVICE LAYER
    public StudentEntity(StudentDTO dto) {
        this.name = dto.getName();
        this.age = dto.getAge();
        this.gender = dto.getGender().charAt(0);
        this.phone = dto.getPhone();
        this.rating = dto.getRating();
        this.fees = dto.getFees();
        this.active = dto.getActive();
        this.semester = dto.getSemester();
        this.grade = dto.getGrade();
    }

}
