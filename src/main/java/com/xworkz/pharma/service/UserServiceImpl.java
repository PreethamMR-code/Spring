package com.xworkz.pharma.service;

import com.xworkz.pharma.dao.UserDao;
import com.xworkz.pharma.dao.UserDaoImpl;
import com.xworkz.pharma.dto.SearchDTO;
import com.xworkz.pharma.dto.SearchDTo;
import com.xworkz.pharma.dto.UserDto;
import com.xworkz.pharma.exception.InvalidException;

import java.util.Optional;

public class UserServiceImpl  implements UserService {


    UserDao userDao = new UserDaoImpl();

    @Override
    public void validateAndSave(UserDto userDto) throws InvalidException {

        boolean invalid = false;


        if(userDto==null) {
            throw new InvalidException("User data is null");
        }

            if (userDto.getFirstName() == null || userDto.getFirstName().trim().length() < 2) {
                invalid=true;
            }
            if (userDto.getLastName() == null || userDto.getLastName().trim().length() < 2) {
                invalid=true;
            }
            if (userDto.getEmail() == null || !userDto.getEmail().contains("@")) {
                invalid=true;
            }
            if (userDto.getPhone() == null || userDto.getPhone().length() != 10) {
                invalid=true;
            }
            if (userDto.getAge()==0||userDto.getAge() < 18) {
                invalid=true;
            }

        if(invalid) {
            throw new InvalidException("Data is not valid");
        }

        //for email
          boolean exists =userDao.existsByEmail(userDto.getEmail());
          if(exists) {
              throw new InvalidException("Email already registered");
          }
//for phone number
          boolean exist = userDao.existsByPhone(userDto.getPhone());
          if (exist){
              throw  new InvalidException("phone number already registered");
          }


        boolean saved=userDao.save(userDto);
            System.out.println("saved?"+saved);
        }

    @Override
    public Optional<UserDto> findByPhone(SearchDTo searchDTo) {


        String phone = searchDTO.getMobileNo();
        boolean invalid =false;

        if(phone == null || phone.length()<10)
        {
            System.err.println("phone no is invalid");
            invalid = true;
        }
        if(!invalid)
        {
            System.out.println("phone is valid call dao..");
            Optional<UserDto> optionalUserDto = this.userDao.findByPhone(phone);
            System.out.println("optional FISh DTO:"+optionalUserDto.isPresent());
            return optionalUserDto;
        }
        return UserService.super.findByPhone(searchDTo);
    }
}


