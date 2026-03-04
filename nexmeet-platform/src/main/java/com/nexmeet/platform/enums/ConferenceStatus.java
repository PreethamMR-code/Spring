package com.nexmeet.platform.enums;

public enum ConferenceStatus {

    DRAFT,       // organizer still filling details
    SUBMITTED,   // submitted for admin review
    APPROVED,    // admin approved, visible publicly
    REJECTED,    // admin rejected
    CANCELLED,   // cancelled by organizer or admin
    COMPLETED    // event is over
}
