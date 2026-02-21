package com.xworkz.forms.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CustomerDTO {

        @NotNull(message = "Customer name is required")
        @Size(min = 3, max = 20, message = "Invalid name length")
        private String name;

        @Min(value = 18, message = "Age must be 18 or above")
        private Integer age;

        @Pattern(regexp = "[MF]", message = "Gender must be M or F")
        private String gender;

        @Min(value = 1000000000L, message = "Invalid phone number")
        private Long phone;

        @Min(value = 1, message = "Rating must be minimum 1")
        @Max(value = 5, message = "Rating must be maximum 5")
        private Float rating;

        @Min(value = 0, message = "Purchase amount cannot be negative")
        private Double totalPurchase;

        private Boolean active;

        @Min(value = 0, message = "Loyalty years cannot be negative")
        private Short loyaltyYears;

        @Min(value = 1, message = "Level must be between 1 and 10")
        @Max(value = 10, message = "Level must be between 1 and 10")
        private Byte level;
}

