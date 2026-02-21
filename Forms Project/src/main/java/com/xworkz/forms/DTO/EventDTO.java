package com.xworkz.forms.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class EventDTO {

    @NotNull(message = "Event name is required")
    @Size(min = 3, max = 30, message = "Invalid event name")
    private String name;

    @Min(value = 1, message = "Duration must be at least 1 day")
    private Integer duration;

    @Pattern(regexp = "[PO]", message = "Type must be P or O")
    private String type;

    @Min(value = 1, message = "Invalid event code")
    private Long code;

    @Min(value = 1, message = "Rating must be minimum 1")
    @Max(value = 5, message = "Rating must be maximum 5")
    private Float rating;

    @Min(value = 1000, message = "Budget must be at least 1000")
    private Double budget;

    private Boolean active;

    @Min(value = 1, message = "Team size must be positive")
    private Short teamSize;

    @Min(value = 1, message = "Priority must be between 1 and 10")
    @Max(value = 10, message = "Priority must be between 1 and 10")
    private Byte priority;
}

