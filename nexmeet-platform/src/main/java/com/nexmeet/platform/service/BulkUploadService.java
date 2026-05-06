package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.BulkUpload;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface BulkUploadService {

    /*
     * Main method: process uploaded CSV file.
     *
     * CSV format expected:
     * full_name, email, phone (phone optional)
     *
     * For each valid row:
     * 1. Check if user exists by email
     * 2. If not, create new user account with temp password
     * 3. Assign DELEGATE role if not already
     * 4. Check if already registered for this conference
     * 5. If not, register and generate QR code
     * 6. Send welcome/confirmation email
     *
     * Returns the BulkUpload record with results summary.
     */
    BulkUpload processBulkUpload(
            Long conferenceId,
            String organizerEmail,
            MultipartFile file
    );

    List<BulkUpload> getUploadHistory(Long conferenceId);
}