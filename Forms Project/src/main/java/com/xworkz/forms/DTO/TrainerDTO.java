package com.xworkz.forms.DTO;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@NoArgsConstructor
@Data
@AllArgsConstructor

public class TrainerDTO {

    @NotNull(message = "Trainer name is required")
    @Size(min = 3, max = 20, message = "Invalid name")
    private String name;

    @Min(value = 21, message = "Trainer must be at least 21")
    private Integer age;

    @Pattern(regexp = "[MF]", message = "Gender must be M or F")
    private String gender;

    @Min(value = 1000000000L, message = "Invalid phone number")
    private Long phone;

    @Min(value = 1, message = "Rating must be minimum 1")
    @Max(value = 5, message = "Rating must be maximum 5")
    private Float rating;

    @Min(value = 300, message = "Fee must be at least 300")
    private Double fee;

    private Boolean active;

    @Min(value = 0, message = "Experience cannot be negative")
    private Short experience;

    @Min(value = 1, message = "Level must be between 1 and 10")
    @Max(value = 10, message = "Level must be between 1 and 10")
    private Byte level;
}

