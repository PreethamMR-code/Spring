package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.AuditLog;
import java.util.List;

/*
 * AuditLogService — write and read audit trail.
 *
 * Writing: called from controllers after key actions.
 * Reading: called by AdminController to display logs.
 *
 * All log() methods are fire-and-forget —
 * a logging failure must NEVER break the main action.
 * Always call inside try-catch in the caller.
 *
 * Standard action names (use these consistently):
 *   CONFERENCE_APPROVED
 *   CONFERENCE_REJECTED
 *   CONFERENCE_CANCELLED
 *   CONFERENCE_COMPLETED
 *   CONFERENCE_CREATED
 *   ORGANIZER_VERIFIED
 *   ORGANIZER_REJECTED
 *   USER_REGISTERED
 *   USER_DEACTIVATED
 *   USER_ACTIVATED
 *   DELEGATE_REGISTERED
 *   DELEGATE_CANCELLED
 *   BULK_UPLOAD_COMPLETED
 *   INSTITUTIONAL_ADMIN_APPROVED
 *   INSTITUTION_ADDED
 *   OUTREACH_SENT
 *   CERTIFICATE_ISSUED
 */
public interface AuditLogService {

    /*
     * Log an action performed by a known user.
     * userEmail — logged-in user's email.
     * action    — one of the standard names above.
     * entityType — "Conference", "User", etc.
     * entityId   — the DB id of the affected record.
     * details    — free-text extra info (nullable).
     */
    void log(
            String userEmail,
            String action,
            String entityType,
            Long entityId,
            String details
    );

    /*
     * Log a system-triggered action (no user).
     * e.g. auto-complete expired conferences.
     */
    void logSystem(
            String action,
            String entityType,
            Long entityId,
            String details
    );

    List<AuditLog> getRecent(int limit);

    List<AuditLog> filterByAction(
            String action, int limit);

    long getTotalCount();
}