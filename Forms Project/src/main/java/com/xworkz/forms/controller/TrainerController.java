package com.xworkz.forms.controller;

import com.xworkz.forms.DTO.TrainerDTO;
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
public class TrainerController {

    @Autowired
    private RegistrationService service;

    @PostMapping("/trainer")
    public ModelAndView saveTrainer(@Valid TrainerDTO dto,
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

            if (bindingResult.hasFieldErrors("fee")) {
                modelAndView.addObject("feeError",
                        bindingResult.getFieldError("fee").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("experience")) {
                modelAndView.addObject("experienceError",
                        bindingResult.getFieldError("experience").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("level")) {
                modelAndView.addObject("levelError",
                        bindingResult.getFieldError("level").getDefaultMessage());
            }

            modelAndView.setViewName("trainer");
            return modelAndView;
        }

        service.saveTrainer(dto);
        modelAndView.setViewName("result");
        return modelAndView;
    }
}
