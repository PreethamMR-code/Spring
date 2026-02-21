package com.xworkz.forms.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductDTO {

    @NotNull(message = "Product name is required")
    @Size(min = 3, max = 30, message = "Invalid product name")
    private String name;

    @Min(value = 1, message = "Quantity must be at least 1")
    private Integer quantity;

    @Pattern(regexp = "[EN]", message = "Type must be E or N")
    private String type;

    @Min(value = 1, message = "Invalid product code")
    private Long code;

    @Min(value = 1, message = "Rating must be minimum 1")
    @Max(value = 5, message = "Rating must be maximum 5")
    private Float rating;

    @Min(value = 1, message = "Price must be positive")
    private Double price;

    private Boolean available;

    @Min(value = 0, message = "Warranty cannot be negative")
    private Short warranty;

    @Min(value = 1, message = "Level must be between 1 and 10")
    @Max(value = 10, message = "Level must be between 1 and 10")
    private Byte level;
}

