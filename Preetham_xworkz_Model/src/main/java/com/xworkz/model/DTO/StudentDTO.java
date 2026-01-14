package com.xworkz.model.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentDTO {

        private String name;
        private String email;
        private String phone;
        private int age;
        private String gender;
        private String address;
        private String password;

        // NOT stored in DB
        private String confirmPassword;


}
