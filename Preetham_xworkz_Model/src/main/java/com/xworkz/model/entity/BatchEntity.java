package com.xworkz.model.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@AllArgsConstructor
@Data
@NoArgsConstructor
@Entity
@Table(name = "batches")
public class BatchEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "batch_name", nullable = false, length = 100)
    private String batchName;

    @Column(name = "instructor", nullable = false, length = 100)
    private String instructor;

    @Column(name = "course", nullable = false, length = 100)
    private String course;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "batch_type", nullable = false, length = 50)
    private String batchType; // Online, Offline, Hybrid

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "is_active", columnDefinition = "BOOLEAN DEFAULT TRUE")
    private boolean isActive = true;
}
