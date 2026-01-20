package com.xworkz.model.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentDTO {

        @NotNull(message = "")
        @Size(min = 3, max = 20, message = "Name must be between 3 and 20 characters")
        private String name;

        @NotNull(message = "")
        @Pattern(
                regexp = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$",
                message = "Enter a valid email address"
        )
        private String email;

        @NotNull(message = "")
        @Pattern(
                regexp = "^[6-9][0-9]{9}$",
                message = "Phone must start with 6–9 and be 10 digits"
        )
        private String phone;

        @NotNull(message = "")
        @Min(value = 18, message = "Age must be at least 18")
        @Max(value = 60, message = "Age must not exceed 60")
        private Integer age;   // ✔ Wrapper type (important)

        @NotNull(message = "")
        @Pattern(regexp = "[(Male|Female|Other)]", message = "Gender must be M or F")
        private String gender;

        @NotNull(message = "")
        @Size(min = 5, max = 100, message = "Address must be between 5 and 100 characters")
        private String address;

        @NotNull(message = "")
        @Size(min = 6, max = 15, message = "Password must be 6–15 characters")
        private String password;

        //  Not stored in DB
        @NotNull(message = "")
        private String confirmPassword;


}
