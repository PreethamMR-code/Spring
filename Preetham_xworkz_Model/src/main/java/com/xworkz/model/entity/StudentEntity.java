package com.xworkz.model.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "students")
public class StudentEntity {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private int id;

        private String name;
        private String email;
        private String phone;
        private int age;
        private String gender;
        private String address;
        private String password;

        @Column(name = "login_count")
        private int loginCount;

        @Column(name = "otp")
        private String otp;



}
