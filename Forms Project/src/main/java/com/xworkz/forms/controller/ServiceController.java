package com.xworkz.forms.controller;

import com.xworkz.forms.DTO.ServiceDTO;
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
public class ServiceController {

    @Autowired
    private RegistrationService service;

    @PostMapping("/service")
    public ModelAndView saveService(
            @Valid ServiceDTO dto,
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

            if (bindingResult.hasFieldErrors("type")) {
                modelAndView.addObject("typeError",
                        bindingResult.getFieldError("type").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("code")) {
                modelAndView.addObject("codeError",
                        bindingResult.getFieldError("code").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("rating")) {
                modelAndView.addObject("ratingError",
                        bindingResult.getFieldError("rating").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("charge")) {
                modelAndView.addObject("chargeError",
                        bindingResult.getFieldError("charge").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("supportPeriod")) {
                modelAndView.addObject("supportPeriodError",
                        bindingResult.getFieldError("supportPeriod").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("level")) {
                modelAndView.addObject("levelError",
                        bindingResult.getFieldError("level").getDefaultMessage());
            }

            modelAndView.setViewName("service");
            return modelAndView;
        }

        service.saveService(dto);
        modelAndView.setViewName("result");
        return modelAndView;
    }
}
