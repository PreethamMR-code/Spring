package com.nexmeet.platform.enums;

/*
 * HOW a delegate was registered.
 * This is different from RegistrationStatus (what state it's in).
 *
 * INDIVIDUAL = delegate registered themselves via the website
 * BULK       = organizer uploaded a CSV and registered them
 */
public enum RegistrationType {
    INDIVIDUAL,
    BULK
}