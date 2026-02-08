package com.xworkz.model.controller;

import com.xworkz.model.entity.FileEntity;
import com.xworkz.model.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class FileController {

    @Autowired
    RegistrationService registrationService;

    @GetMapping("/getImage")
    public void getImage(@RequestParam int id, HttpServletResponse response) throws IOException {
        FileEntity file = registrationService.getFileById(id);
        if (file != null) {
            response.setContentType(file.getContentType());
            Path imagePath = Paths.get(file.getStoredFilePath());
            Files.copy(imagePath, response.getOutputStream());
        }
    }

}
