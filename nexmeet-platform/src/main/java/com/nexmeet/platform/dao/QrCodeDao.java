package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.QrCode;

import java.util.Optional;

public interface QrCodeDao {

    void save(QrCode qrCode);

    Optional<QrCode> findByRegistrationId(Long registrationId);
}
