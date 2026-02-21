package com.xworkz.forms.controller;

import com.xworkz.forms.DTO.CourseDTO;
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
public class CourseController {

    @Autowired
    private RegistrationService service;

    @PostMapping("/course")
    public ModelAndView saveCourse(
            @Valid CourseDTO dto,
            BindingResult bindingResult,
            ModelAndView modelAndView) {

        if (bindingResult.hasErrors()) {

            if (bindingResult.hasFieldErrors("name")) {
                modelAndView.addObject("nameError",
                        bindingResult.getFieldError("name").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("duration")) {
                modelAndView.addObject("durationError",
                        bindingResult.getFieldError("duration").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("mode")) {
                modelAndView.addObject("modeError",
                        bindingResult.getFieldError("mode").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("code")) {
                modelAndView.addObject("codeError",
                        bindingResult.getFieldError("code").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("rating")) {
                modelAndView.addObject("ratingError",
                        bindingResult.getFieldError("rating").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("fee")) {
                modelAndView.addObject("feeError",
                        bindingResult.getFieldError("fee").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("credits")) {
                modelAndView.addObject("creditsError",
                        bindingResult.getFieldError("credits").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("level")) {
                modelAndView.addObject("levelError",
                        bindingResult.getFieldError("level").getDefaultMessage());
            }

            modelAndView.setViewName("course");
            return modelAndView;
        }

        service.saveCourse(dto);
        modelAndView.setViewName("result");
        return modelAndView;
    }
}
