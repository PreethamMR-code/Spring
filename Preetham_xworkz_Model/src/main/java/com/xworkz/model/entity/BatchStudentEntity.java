package com.xworkz.model.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@AllArgsConstructor
@Data
@NoArgsConstructor
@Entity
@Table(name = "batch_students")
public class BatchStudentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "student_id", nullable = false, unique = true, length = 20)
    private String studentId; // Auto-generated: e.g., XWZ001, XWZ002

    @Column(name = "batch_id", nullable = false)
    private int batchId; // Foreign key to BatchEntity

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "email", nullable = false, length = 100)
    private String email;

    @Column(name = "gender", nullable = false, length = 10)
    private String gender;

    @Column(name = "phone", nullable = false, length = 15)
    private String phone;

    @Column(name = "age")
    private Integer age;

    @Column(name = "address", length = 200)
    private String address;

    @Column(name = "joined_date")
    private LocalDateTime joinedDate;

    @Column(name = "is_active", columnDefinition = "BOOLEAN DEFAULT TRUE")
    private boolean isActive = true;
}
