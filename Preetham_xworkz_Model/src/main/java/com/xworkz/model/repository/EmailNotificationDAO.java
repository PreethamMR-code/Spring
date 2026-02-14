package com.xworkz.model.repository;

import com.xworkz.model.entity.EmailNotificationEntity;

import java.util.List;

public interface EmailNotificationDAO {

    boolean save(EmailNotificationEntity entity);

    EmailNotificationEntity findByToken(String token);

    boolean updateResponse(String token, String response);

    List<EmailNotificationEntity> findByBatchId(int batchId);

    List<EmailNotificationEntity> findByStudentId(int studentId);
}
