package com.xworkz.forms.controller;

import com.xworkz.forms.DTO.EmployeeDTO;
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
public class EmployeeController {


        @Autowired
        private RegistrationService service;

        @PostMapping("employee")
        public ModelAndView saveEmployee(@Valid EmployeeDTO dto,
                                         BindingResult bindingResult,
                                         ModelAndView modelAndView) {

            if (bindingResult.hasErrors()) {

                if (bindingResult.hasFieldErrors("name")) {
                    modelAndView.addObject("nameError",
                            bindingResult.getFieldError("name").getDefaultMessage());
                }

                if (bindingResult.hasFieldErrors("age")) {
                    modelAndView.addObject("ageError",
                            bindingResult.getFieldError("age").getDefaultMessage());
                }

                if (bindingResult.hasFieldErrors("gender")) {
                    modelAndView.addObject("genderError",
                            bindingResult.getFieldError("gender").getDefaultMessage());
                }

                if (bindingResult.hasFieldErrors("phone")) {
                    modelAndView.addObject("phoneError",
                            bindingResult.getFieldError("phone").getDefaultMessage());
                }

                if (bindingResult.hasFieldErrors("performance")) {
                    modelAndView.addObject("performanceError",
                            bindingResult.getFieldError("performance").getDefaultMessage());
                }

                if (bindingResult.hasFieldErrors("salary")) {
                    modelAndView.addObject("salaryError",
                            bindingResult.getFieldError("salary").getDefaultMessage());
                }

                if (bindingResult.hasFieldErrors("experience")) {
                    modelAndView.addObject("experienceError",
                            bindingResult.getFieldError("experience").getDefaultMessage());
                }

                if (bindingResult.hasFieldErrors("level")) {
                    modelAndView.addObject("levelError",
                            bindingResult.getFieldError("level").getDefaultMessage());
                }

                modelAndView.setViewName("employee");
                return modelAndView;
            }

            service.saveEmployee(dto);
            modelAndView.setViewName("result");
            return modelAndView;
        }
    }


