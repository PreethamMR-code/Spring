package com.xworkz.model.controller;

import com.xworkz.model.config.FileUploadConfig;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@Controller
public class FileController {

    @GetMapping("/uploads/profiles/{filename:.+}")
    @ResponseBody
    public byte[] getProfilePhoto(@PathVariable String filename,
                                  HttpServletResponse response) {

        System.out.println("Serving image: " + filename);

        try{
            // Build full path to file on D drive
            File file = new File(FileUploadConfig.PROFILE_DIR + filename);

            // Check if file exists
            if (!file.exists()) {
                System.err.println(" File not found: " + file.getAbsolutePath());

                // Return default avatar if file doesn't exist
                file = new File(FileUploadConfig.PROFILE_DIR + FileUploadConfig.DEFAULT_AVATAR);
            }

            // Set content type based on file extension
            String extension = file.getName()
                    .substring(file.getName().lastIndexOf(".") + 1)
                    .toLowerCase();

            switch (extension) {
                case "jpg":
                case "jpeg":
                    response.setContentType("image/jpeg");
                    break;
                case "png":
                    response.setContentType("image/png");
                    break;
                case "gif":
                    response.setContentType("image/gif");
                    break;
                default:
                    response.setContentType("image/jpeg");
            }

            //  Prevent browser caching old image
     //       response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            // Read file and return as byte array
            byte[] imageBytes = Files.readAllBytes(file.toPath());

            System.out.println(" Served image: " + file.getName() + " (" + imageBytes.length + " bytes)");

            return imageBytes;

        } catch (IOException e) {
            System.err.println(" Error reading file: " + e.getMessage());
            e.printStackTrace();
            return new byte[0];
        }
    }

}
