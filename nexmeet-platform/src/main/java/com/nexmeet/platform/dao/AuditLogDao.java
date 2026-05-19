package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.AuditLog;
import java.util.List;

public interface AuditLogDao {

    void save(AuditLog log);

    /*
     * All logs — newest first.
     * Paginated: limit controls how many rows
     * to return so admin page doesn't load 10,000 rows.
     */
    List<AuditLog> findRecent(int limit);

    /*
     * Filter by action type.
     * e.g. "CONFERENCE_APPROVED"
     */
    List<AuditLog> findByAction(
            String action, int limit);

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