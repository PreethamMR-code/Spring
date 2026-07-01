package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.AuditLogDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.AuditLog;
import com.nexmeet.platform.service.AuditLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AuditLogServiceImpl
        implements AuditLogService {

    @Autowired
    private AuditLogDao auditLogDao;

    @Autowired
    private UserDao userDao;

    @Override
    public void log(
            String userEmail,
            String action,
            String entityType,
            Long entityId,
            String details) {
        try {
            AuditLog entry = new AuditLog();
            entry.setAction(action);
            entry.setEntityType(entityType);
            entry.setEntityId(entityId);
            entry.setDetails(details);

            /*
             * Look up user by email.
             * If not found (shouldn't happen),
             * log is saved with user = null.
             */
            if (userEmail != null) {
                userDao.findByEmail(userEmail)
                        .ifPresent(entry::setUser);
            }

            auditLogDao.save(entry);
        } catch (Exception e) {
            // Never let audit logging break
            // the main operation
            System.err.println(
                    "[AuditLog] Failed: "
                            + e.getMessage());
        }
    }

    @Override
    public void logSystem(
            String action,
            String entityType,
            Long entityId,
            String details) {
        try {
            AuditLog entry = new AuditLog();
            entry.setAction(action);
            entry.setEntityType(entityType);
            entry.setEntityId(entityId);
            entry.setDetails(details);
            // user = null for system actions
            auditLogDao.save(entry);
        } catch (Exception e) {
            System.err.println(
                    "[AuditLog] System log failed: "
                            + e.getMessage());
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<AuditLog> getRecent(int page, int size) {
        return auditLogDao.findRecent(page, size);
    }

    @Override
    @Transactional(readOnly = true)
    public List<AuditLog> filterByAction(
            String action, int page, int size) {
        return auditLogDao.findByAction(
                action, page, size);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByAction(String action) {
        return auditLogDao.countByAction(action);
    }

    @Override
    @Transactional(readOnly = true)
    public long getTotalCount() {
        return auditLogDao.countAll();
    }
}