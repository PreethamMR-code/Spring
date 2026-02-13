package com.xworkz.model.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "students")
public class RegistrationEntity {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private int id;

        @Column(name = "name", nullable = false, length = 100)
        private String name;

        @Column(name = "email", nullable = false, unique = true, length = 100)
        private String email;

        @Column(name = "phone", nullable = false, length = 15)
        private String phone;

        @Column(name = "age")
        private Integer age;

        @Column(name = "gender", length = 10)
        private String gender;

        @Column(name = "address", length = 200)
        private String address;

        @Column(name = "password", nullable = false, length = 255)
        private String password;

        @Column(name = "count", columnDefinition = "INT DEFAULT 0")
        private int count = 0;

        @Column(name = "otp", length = 10)
        private String otp;

        @Column(name = "otp_generated_time")
        private LocalDateTime otpGeneratedTime;

//        @Column(name = "profile_photo", length = 255)
//        private String profilePhoto = "default-avatar.png";

        // RegistrationEntity.java
        @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
        @JoinColumn(name = "file_id") // This creates a foreign key column in 'students' table
        private FileEntity profileImage;
}

