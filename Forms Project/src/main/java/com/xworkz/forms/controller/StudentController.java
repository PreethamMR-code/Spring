package com.xworkz.forms.controller;

import com.xworkz.forms.DTO.*;
import com.xworkz.forms.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
@RequestMapping("/")
public class StudentController {

    @Autowired
    private RegistrationService service;

    @PostMapping("/student")
    public ModelAndView saveStudent(@Valid StudentDTO dto,
                                   BindingResult bindingResult,
                                   ModelAndView modelAndView){

       if(bindingResult.hasErrors()){

           if(bindingResult.hasFieldErrors("name")){
               modelAndView.addObject("nameError",
                       bindingResult.
                               getFieldError("name").
                               getDefaultMessage());
           }

           if(bindingResult.hasFieldErrors("age")){
               modelAndView.addObject("ageError",
                       bindingResult.
                               getFieldError("age").
                               getDefaultMessage());
           }

           if(bindingResult.hasFieldErrors("gender")){
               modelAndView.addObject("genderError",
                       bindingResult.
                               getFieldError("gender").
                               getDefaultMessage());
           }

           if(bindingResult.hasFieldErrors("phone")){
               modelAndView.addObject("phoneError",
                       bindingResult.
                               getFieldError("phone").
                               getDefaultMessage());
           }

           if(bindingResult.hasFieldErrors("rating")){
               modelAndView.addObject("ratingError",
                       bindingResult.
                               getFieldError("rating").
                               getDefaultMessage());
           }

           if(bindingResult.hasFieldErrors("fees")){
               modelAndView.addObject("feesError",
                       bindingResult.
                               getFieldError("fees").
                               getDefaultMessage());
           }

           if(bindingResult.hasFieldErrors("semester")){
               modelAndView.addObject("semesterError",
                       bindingResult.
                               getFieldError("semester").
                               getDefaultMessage());
           }

           if(bindingResult.hasFieldErrors("grade")){
               modelAndView.addObject("gradeError",
                       bindingResult.
                               getFieldError("grade").
                               getDefaultMessage());
           }

           modelAndView.setViewName("student");
           return modelAndView;
       }
       service.saveStudent(dto);
       modelAndView.setViewName("result");
       return modelAndView;
   }
}
