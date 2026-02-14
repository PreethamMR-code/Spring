package com.xworkz.model.service;

import com.xworkz.model.entity.EmailNotificationEntity;

import java.util.List;

public interface EmailNotificationService {

    boolean sendNotification(int batchId, int studentId, String studentName,
                             String studentEmail, String subject,
                             String emailMessage, String responsePageMessage,
                             String sentBy, String appBaseUrl);

    EmailNotificationEntity getByToken(String token);

    boolean recordResponse(String token, String response);

    List<EmailNotificationEntity> getByBatchId(int batchId);

    List<EmailNotificationEntity> getByStudentId(int studentId);

}
