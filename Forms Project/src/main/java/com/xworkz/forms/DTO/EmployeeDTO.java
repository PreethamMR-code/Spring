package com.xworkz.forms.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class EmployeeDTO {

    @NotNull(message = "Employee name is required")
    @Size(min = 3, max = 20, message = "Name length must be 3–20")
    private String name;

    @Min(value = 21, message = "Age must be at least 21")
    @Max(value = 60, message = "Age must not exceed 60")
    private Integer age;

    @Pattern(regexp = "[MF]", message = "Gender must be M or F")
    private String gender;

    @Min(value = 1000000000L, message = "Invalid phone number")
    private Long phone;

    @Min(value = 1, message = "Performance must be minimum 1")
    @Max(value = 5, message = "Performance must be maximum 5")
    private Float performance;

    @Min(value = 10000, message = "Salary must be at least 10000")
    private Double salary;

    private Boolean active;

    @Min(value = 0, message = "Experience cannot be negative")
    private Short experience;

    @Min(value = 1, message = "Level must be at least 1")
    @Max(value = 10, message = "Level must not exceed 10")
    private Byte level;
}

