package com.xworkz.forms.controller;

import com.xworkz.forms.DTO.EventDTO;
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
public class EventController {

    @Autowired
    private RegistrationService service;

    @PostMapping("/event")
    public ModelAndView saveEvent(
            @Valid EventDTO dto,
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

            if (bindingResult.hasFieldErrors("budget")) {
                modelAndView.addObject("budgetError",
                        bindingResult.getFieldError("budget").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("teamSize")) {
                modelAndView.addObject("teamSizeError",
                        bindingResult.getFieldError("teamSize").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("priority")) {
                modelAndView.addObject("priorityError",
                        bindingResult.getFieldError("priority").getDefaultMessage());
            }

            modelAndView.setViewName("event");
            return modelAndView;
        }

        service.saveEvent(dto);
        modelAndView.setViewName("result");
        return modelAndView;
    }
}
