package com.xworkz.forms.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CourseDTO {

    @NotNull(message = "Course name is required")
    @Size(min = 3, max = 30, message = "Invalid course name")
    private String name;

    @Min(value = 1, message = "Duration must be at least 1 month")
    private Integer duration;

    @Pattern(regexp = "[OF]", message = "Mode must be O or F")
    private String mode;

    @Min(value = 1, message = "Invalid course code")
    private Long code;

    @Min(value = 1, message = "Rating must be minimum 1")
    @Max(value = 5, message = "Rating must be maximum 5")
    private Float rating;

    @Min(value = 1000, message = "Fee must be at least 1000")
    private Double fee;

    private Boolean active;

    @Min(value = 1, message = "Credits must be positive")
    private Short credits;

    @Min(value = 1, message = "Level must be between 1 and 10")
    @Max(value = 10, message = "Level must be between 1 and 10")
    private Byte level;
}

