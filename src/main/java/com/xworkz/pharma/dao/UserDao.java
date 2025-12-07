package com.xworkz.pharma.dao;

import com.xworkz.pharma.dto.UserDto;

import java.util.Optional;

public interface UserDao {

    boolean save(UserDto userDto);
    boolean existsByEmail(String email);
    boolean existsByPhone(String phone);

    default Optional<UserDto> findByPhone (String phoneNo){
        return Optional.empty();
    }
}
