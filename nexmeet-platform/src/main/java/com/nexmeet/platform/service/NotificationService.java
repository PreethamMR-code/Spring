package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Notification;

import java.util.List;

public interface NotificationService {


    // Create a notification for a user
    void createNotification(String userEmail, String title,
                            String message, String type);

    // Get all notifications for a user
    List<Notification> getNotifications(String userEmail);

    // Get unread count for navbar badge
    long getUnreadCount(String userEmail);

    // Mark a single notification as read
    void markAsRead(Long notificationId, String userEmail);

    // Mark all notifications as read
    void markAllAsRead(String userEmail);


}
