package com.xworkz.model.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BatchDTO {

    private int id;

    @NotNull(message = "Batch name is required")
    @Size(min = 3, max = 100, message = "Batch name must be 3-100 characters")
    private String batchName;

    @NotNull(message = "Instructor name is required")
    @Size(min = 3, max = 100, message = "Instructor name must be 3-100 characters")
    private String instructor;

    @NotNull(message = "Course selection is required")
    private String course;

    @NotNull(message = "Start date is required")
    private LocalDate startDate;

    @NotNull(message = "Batch type is required")
    private String batchType;

    @Size(max = 500, message = "Description cannot exceed 500 characters")
    private String description;
}
