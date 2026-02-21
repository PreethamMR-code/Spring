package com.xworkz.forms.controller;

import com.xworkz.forms.DTO.CustomerDTO;
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
public class CustomerController {

    @Autowired
    private RegistrationService service;

    @PostMapping("customer")
    public ModelAndView saveCustomer(@Valid CustomerDTO dto,
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

            if (bindingResult.hasFieldErrors("rating")) {
                modelAndView.addObject("ratingError",
                        bindingResult.getFieldError("rating").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("totalPurchase")) {
                modelAndView.addObject("totalPurchaseError",
                        bindingResult.getFieldError("totalPurchase").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("loyaltyYears")) {
                modelAndView.addObject("loyaltyYearsError",
                        bindingResult.getFieldError("loyaltyYears").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("level")) {
                modelAndView.addObject("levelError",
                        bindingResult.getFieldError("level").getDefaultMessage());
            }

            modelAndView.setViewName("customer");
            return modelAndView;
        }

        service.saveCustomer(dto);
        modelAndView.setViewName("result");
        return modelAndView;
    }
}
