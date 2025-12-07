package com.xworkz.pharma.service;

import com.xworkz.pharma.dto.SearchDTO;
import com.xworkz.pharma.dto.UserDto;
import com.xworkz.pharma.exception.InvalidException;

import java.util.Optional;

public interface UserService {

     void validateAndSave(UserDto userDto) throws InvalidException;

     default Optional<UserDto> findByPhone(SearchDTO searchDTO){
          return Optional.empty();
     }

}
