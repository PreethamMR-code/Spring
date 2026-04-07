package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Notification;

import java.util.List;
import java.util.Optional;

public interface NotificationDao {

    void save(Notification notification);

    List<Notification> findByUserEmail(String email);

    long countUnreadByUserEmail(String email);

    Optional<Notification> findById(Long id);

    void markAllReadByUserEmail(String email);

}
