package com.xworkz.forms.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class StudentDTO {

    @NotNull(message = "Name is required")
    @Size(min = 3, max = 20, message = "Name must be between 3 and 20 characters")
    private String name;

    @NotNull(message = "Age is required")
    @Min(value = 18, message = "Age must be at least 18")
    @Max(value = 30, message = "Age must not exceed 30")
    private Integer age;

    @NotNull(message = "Gender is required")
    @Pattern(regexp = "[MF]", message = "Gender must be M or F")
    private String gender;

    @NotNull(message = "Phone number is required")
    @Digits(integer = 10, fraction = 0, message = "Phone number must be exactly 10 digits")
    private Long phone;

    @NotNull(message = "Rating is required")
    @DecimalMin(value = "1.0", message = "Rating must be at least 1")
    @DecimalMax(value = "5.0", message = "Rating must not exceed 5")
    private Float rating;

    @NotNull(message = "Fees is required")
    @DecimalMin(value = "1000.0", message = "Fees must be at least 1000")
    private Double fees;

    private Boolean active;

    @NotNull(message = "Semester is required")
    @Min(value = 1, message = "Semester must be at least 1")
    @Max(value = 8, message = "Semester cannot exceed 8")
    private Short semester;

    @NotNull(message = "Grade is required")
    @Min(value = 1, message = "Grade must be at least 1")
    @Max(value = 10, message = "Grade must not exceed 10")
    private Byte grade;
}
