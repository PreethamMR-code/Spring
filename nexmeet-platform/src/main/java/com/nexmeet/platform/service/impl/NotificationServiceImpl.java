package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.NotificationDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.Notification;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.service.NotificationService;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private NotificationDao notificationDao;

    @Autowired
    private UserDao userDao;

    // SessionFactory needed for markAsRead
//    @Autowired
//    private SessionFactory sessionFactory;

    @Override
    public void createNotification(String userEmail, String title, String message, String type) {


        /*
         * Silently skip if user not found — notifications
         * should never crash the main flow.
         */
        Optional<User> userOpt = userDao.findByEmail(userEmail);
        if (!userOpt.isPresent()) return;

        Notification n = new Notification();
        n.setUser(userOpt.get());
        n.setTitle(title);
        n.setMessage(message);
        n.setType(type != null ? type : "IN_APP");
        n.setRead(false);
        notificationDao.save(n);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notification> getNotifications(String userEmail) {
        return notificationDao.findByUserEmail(userEmail);
    }

    @Override
    @Transactional(readOnly = true)
    public long getUnreadCount(String userEmail) {
        return notificationDao.countUnreadByUserEmail(userEmail);
    }

    @Override
    public void markAsRead(Long notificationId,
                           String userEmail) {
        notificationDao.findById(notificationId).ifPresent(n -> {
            if (n.getUser().getEmail().equals(userEmail)) {
                n.setRead(true);
                notificationDao.update(n);
            }
        });
    }

    @Override
    public void markAllAsRead(String userEmail) {
        notificationDao.markAllReadByUserEmail(userEmail);
    }
}
