package com.nexmeet.platform.enums;

/*
 * ConferenceType enum — stored as String in DB via @Enumerated(EnumType.STRING).
 * The enum name (e.g. TECHNICAL) is stored in conference_type column.
 *
 * TO ADD A NEW TYPE:
 * 1. Add constant here
 * 2. Add <option> in create-conference.jsp and edit-conference.jsp
 * 3. Optionally INSERT into commission_settings with the new name
 *    — if not inserted, CommissionService falls back to DEFAULT rate
 */
public enum ConferenceType {

    // ── Academic & Research ────────────────────────────────
    STUDENT,        // Student-focused academic conferences
    ACADEMIC,       // General academic conferences
    RESEARCH,       // Research symposiums and scientific
    EDUCATION,      // Education sector conferences

    // ── Technical & IT ────────────────────────────────────
    TECHNICAL,      // General technical conferences
    DATA_SCIENCE,   // Data science and analytics
    AI_ML,          // Artificial Intelligence & ML
    CYBERSECURITY,  // Cybersecurity conferences
    CLOUD_COMPUTING,// Cloud computing events

    // ── Business ──────────────────────────────────────────
    CORPORATE,      // Corporate and professional events
    BUSINESS,       // General business conferences
    STARTUP,        // Startup and entrepreneurship
    FINANCE,        // Finance and investment events
    MARKETING,      // Marketing and advertising
    LEADERSHIP,     // Leadership summits

    // ── Industry Specific ─────────────────────────────────
    HEALTHCARE,     // Healthcare and medical
    ENGINEERING,    // Engineering conferences
    LEGAL,          // Legal and law conferences
    ENVIRONMENTAL,  // Environmental and sustainability

    // ── Civic & Social ────────────────────────────────────
    NGO,            // NGO and social sector — usually free
    GOVERNMENT,     // Government and public sector — usually free

    // ── Event Formats ─────────────────────────────────────
    WORKSHOP,       // Hands-on skill workshops
    SEMINAR,        // Knowledge-sharing seminars
    WEBINAR,        // Online-only webinars
    PANEL,          // Panel discussions
    BOOTCAMP,       // Intensive bootcamps
    TRAINING,       // Structured training programs

    // ── General ───────────────────────────────────────────
    INNOVATION,     // Innovation and ideas conferences
    GENERAL         // Multi-domain or uncategorized
}