package com.xworkz.model.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegistrationDTO {

        private int id;

        @Size(min = 3, max = 25, message = "Name must be between 3 and 25 characters")
        private String name;

        @NotNull(message = "Email is required")
        @Pattern(regexp = "^[a-zA-Z0-9._%+-]+@gmail\\.com$", message = "Email must be a valid Gmail address")
        private String email;

        @NotNull(message = "Phone number is required")
        @Pattern(regexp = "^[6-9][0-9]{9}$", message = "Phone number must start with 6-9 and contain 10 digits")
        private String phone;

        @NotNull(message = "Age is required")
        @Min(value = 18, message = "Age must be at least 18")
        @Max(value = 45, message = "Age must be less than 45")
        private Integer age;

        @NotNull(message = "Gender is required")
        private String gender;

        @NotNull(message = "Address is required")
        @Size(min = 15, max = 80, message = "Address must be between 15 and 80 characters")
        private String address;

        @NotNull(message = "Password is required")
        @Pattern(
                regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$",
                message = "Password must contain uppercase, lowercase, number and special character"
        )
        private String password;

        @NotNull(message = "Confirm password is required")
        private String confirmPassword;

}
