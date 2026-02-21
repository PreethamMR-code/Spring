package com.xworkz.forms.controller;

import com.xworkz.forms.DTO.ProductDTO;
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
public class ProductController {

    @Autowired
    private RegistrationService service;

    @PostMapping("/product")
    public ModelAndView saveProduct(
            @Valid ProductDTO dto,
            BindingResult bindingResult,
            ModelAndView modelAndView) {

        if (bindingResult.hasErrors()) {

            if (bindingResult.hasFieldErrors("name")) {
                modelAndView.addObject("nameError",
                        bindingResult.getFieldError("name").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("quantity")) {
                modelAndView.addObject("quantityError",
                        bindingResult.getFieldError("quantity").getDefaultMessage());
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

            if (bindingResult.hasFieldErrors("price")) {
                modelAndView.addObject("priceError",
                        bindingResult.getFieldError("price").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("warranty")) {
                modelAndView.addObject("warrantyError",
                        bindingResult.getFieldError("warranty").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("level")) {
                modelAndView.addObject("levelError",
                        bindingResult.getFieldError("level").getDefaultMessage());
            }

            modelAndView.setViewName("product");
            return modelAndView;
        }

        service.saveProduct(dto);
        modelAndView.setViewName("result");
        return modelAndView;
    }
}
