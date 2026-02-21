package com.xworkz.forms.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ServiceDTO {

    @NotNull(message = "Service name is required")
    @Size(min = 3, max = 30, message = "Invalid service name")
    private String name;

    @Min(value = 1, message = "Duration must be positive")
    private Integer duration;

    @Pattern(regexp = "[PO]", message = "Type must be P or O")
    private String type;

    @Min(value = 1, message = "Invalid service code")
    private Long code;

    @Min(value = 1, message = "Rating must be minimum 1")
    @Max(value = 5, message = "Rating must be maximum 5")
    private Float rating;

    @Min(value = 1, message = "Charge must be positive")
    private Double charge;

    private Boolean active;

    @Min(value = 1, message = "Support period must be positive")
    private Short supportPeriod;

    @Min(value = 1, message = "Level must be between 1 and 10")
    @Max(value = 10, message = "Level must be between 1 and 10")
    private Byte level;
}

