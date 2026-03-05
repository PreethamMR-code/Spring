package com.nexmeet.platform.enums;
/*
 * VerificationStatus is used in the organizers table.
 * When an organizer registers, they start as PENDING.
 * Admin reviews and sets them to APPROVED or REJECTED.
 *
 * Why use Java enum instead of String?
 * Because if you use String, nothing stops you from writing
 * "Approved" or "approved" or "APPROVE" by mistake.
 * An enum only allows exactly these 3 values — compile-time safety.
 */


public enum VerificationStatus {

    PENDING,
    APPROVED,
    REJECTED
}
