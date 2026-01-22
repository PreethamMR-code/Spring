package com.xworkz.model.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class OTPUtil {

    @Autowired
    JavaMailSender javaMailSender;

    public void sendSimpleMessage(String to, String subject, String text) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            //otp is sent from this email
            message.setFrom("preethampreetham560@gmail.com");

            // email to receive otp
            message.setTo("preethampreetham560@gmail.com");

            message.setSubject(subject);
            message.setText(text);

            javaMailSender.send(message);
            System.out.println(" Email sent successfully to: preethampreetham560@gmail.com");

        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
