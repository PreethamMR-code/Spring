package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Registration;

import java.io.ByteArrayOutputStream;

public interface CertificateService {

    ByteArrayOutputStream generateTicket(Registration registration, String qrBase64);

    ByteArrayOutputStream generateCertificate(Registration registration);
}
