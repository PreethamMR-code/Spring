package com.xworkz.model.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentDTO {

        @NotNull(message = "Name is required")
        @Size(min = 3, max = 20, message = "Name must be between 3 and 20 characters")
        private String name;

        @NotNull(message = "Email is required")
        @Pattern(
                regexp = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$",
                message = "Enter a valid email address"
        )
        private String email;

        @NotNull(message = "Phone number is required")
        @Digits(integer = 10, fraction = 0, message = "Phone number must be 10 digits")
        private String phone;

        @NotNull(message = "Age is required")
        @Min(value = 18, message = "Age must be at least 18")
        @Max(value = 60, message = "Age must not exceed 60")
        private Integer age;   // ✔ Wrapper type (important)

        @NotNull(message = "Gender is required")
        @Pattern(regexp = "[(Male|Female|Other)]", message = "Gender must be M or F")
        private String gender;

        @NotNull(message = "Address is required")
        @Size(min = 5, max = 100, message = "Address must be between 5 and 100 characters")
        private String address;

        @NotNull(message = "Password is required")
        @Size(min = 6, max = 15, message = "Password must be 6–15 characters")
        private String password;

        // ❌ Not stored in DB
        @NotNull(message = "Confirm Password is required")
        private String confirmPassword;


}
