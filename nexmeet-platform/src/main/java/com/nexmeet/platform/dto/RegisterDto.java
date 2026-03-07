package com.nexmeet.platform.dto;

/*
 * DTO = Data Transfer Object.
 * This is NOT an entity — it never touches the database directly.
 * It's just a container that holds form data submitted by the user.
 *
 * Why use a DTO instead of the User entity directly?
 * - The User entity has passwordHash, isActive, roles — fields
 *   that the user should NEVER be able to set from a form.
 * - DTOs let you expose only what the form actually needs.
 * - Keeps your entity clean and your form safe.
 *
 * Flow: HTML form → DTO → Service validates → Entity created → saved to DB
 */

public class RegisterDto {

    private String fullName;
    private String email;
    private String password;
    private String confirmPassword;

    public RegisterDto() {}

    public  String getFullName(){
        return fullName;
    }
    public void setFullName(String fullName){
        this.fullName = fullName;
    }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }
}
