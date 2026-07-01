package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.AuditLog;
import java.util.List;

public interface AuditLogDao {

    void save(AuditLog log);

    List<AuditLog> findRecent(int page, int size);


    List<AuditLog> findByAction(
            String action, int page, int size);

    long countByAction(String action);

    /*
     * Filter by who did the action.
     */
    List<AuditLog> findByUserId(
            Long userId, int limit);

    /*
     * Filter by entity — e.g. all actions on
     * Conference with id = 5.
     */
    List<AuditLog> findByEntity(
            String entityType,
            Long entityId,
            int limit);

    /*
     * Total count — for showing "X events logged"
     * on the dashboard.
     */
    long countAll();
}