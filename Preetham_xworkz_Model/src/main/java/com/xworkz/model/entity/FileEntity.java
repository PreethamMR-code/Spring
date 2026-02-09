package com.xworkz.model.entity;


import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "uploaded_files")
public class FileEntity {


        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Integer id;

        private String originalFileName;
        private String storedFilePath; // Full path on D: drive
        private long fileSize;
        private String contentType;
        private LocalDateTime uploadedAt = LocalDateTime.now();
    }

