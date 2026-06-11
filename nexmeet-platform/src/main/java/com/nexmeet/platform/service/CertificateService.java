package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Certificate;
import com.nexmeet.platform.entity.Registration;

import java.io.ByteArrayOutputStream;
import java.util.Optional;

public interface CertificateService {

    /*
     * Generate ticket PDF — called on-the-fly
     * when delegate clicks "Download Ticket".
     * Not saved to DB.
     */
    ByteArrayOutputStream generateTicket(
            Registration registration,
            String qrBase64);

    /*
     * Generate certificate PDF with a known
     * certificate number printed on it.
     * Called by issueCertificate() and
     * by download endpoint.
     */
    ByteArrayOutputStream generateCertificate(
            Registration registration,
            String certificateNumber);

    /*
     * Old signature kept for backward compatibility.
     * Calls generateCertificate(reg, "PENDING")
     * internally. Should be avoided going forward.
     */
    ByteArrayOutputStream generateCertificate(
            Registration registration);

    /*
     * THE MAIN METHOD — called when a conference
     * is marked COMPLETED for each attended delegate.
     *
     * Does all of:
     *  1. Checks if already issued (idempotent)
     *  2. Generates unique certificate number
     *  3. Generates PDF with that number
     *  4. Saves Certificate record to DB
     *  5. Emails PDF as attachment to delegate
     *
     * Returns the Certificate record.
     * Returns null if delegate did not attend.
     */
    Certificate issueCertificate(
            Registration registration);

    /*
     * Find existing certificate record for a
     * registration. Used by dashboard to show
     * certificate number and issued date.
     */
    Optional<Certificate> getCertificateRecord(
            Long registrationId);

    /*
     * Quick check — has certificate been issued?
     */
    boolean isCertificateIssued(
            Long registrationId);

    /*
     * Find certificate by its unique certificate number.
     * Used by the public verification page.
     * Returns empty if certificate number does not exist.
     */
    Optional<Certificate> findByCertificateNumber(
            String certificateNumber);
}