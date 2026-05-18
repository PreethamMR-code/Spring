package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Certificate;
import java.util.List;
import java.util.Optional;

public interface CertificateDao {

    void save(Certificate certificate);

    /*
     * Find by registration — used to check if
     * certificate already issued before re-issuing.
     * registration_id is UNIQUE so at most one result.
     */
    Optional<Certificate> findByRegistrationId(
            Long registrationId);

    /*
     * All certificates for a conference.
     * Used by organizer to see who got certified.
     */
    List<Certificate> findByConferenceId(
            Long conferenceId);

    /*
     * Quick existence check — avoids loading entity
     * just to check if certificate was issued.
     */
    boolean existsByRegistrationId(
            Long registrationId);

    /*
     * Verify a certificate by its unique number.
     * Future: public verification page at
     * /verify/{certificateNumber}
     */
    Optional<Certificate> findByCertificateNumber(
            String certificateNumber);
}