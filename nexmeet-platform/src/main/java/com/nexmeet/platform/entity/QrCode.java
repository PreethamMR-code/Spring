package com.nexmeet.platform.entity;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * QrCode stores the unique token for each delegate's registration.
 * One Registration = One QR Code (OneToOne).
 *
 * The qr_token is a secure random UUID that gets encoded into
 * an actual QR image. When organizer scans it at the event,
 * we look up this token, find the Registration, and mark attendance.
 */

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "qr_codes")
public class QrCode {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /*
     * @OneToOne: one QR code per registration.
     * @JoinColumn: the FK column in qr_codes table.
     * unique = true enforces one-to-one at the database level too.
     */
    @OneToOne
    @JoinColumn(name = "registration_id", nullable = false, unique = true)
    private Registration registration;

    /*
     * qr_token is what actually gets encoded in the QR image.
     * It's a UUID like: "a3f9b2c1-4d5e-6f7a-8b9c-0d1e2f3a4b5c"
     * When scanned, the system finds this token and looks up
     * the associated Registration record.
     */
    @Column(name = "qr_token", nullable = false, unique = true, length = 255)
    private String qrToken;

    // Path to the saved QR image file on the server
    @Column(name = "qr_image_path", length = 500)
    private String qrImagePath;

    @Column(name = "generated_at", nullable = false, updatable = false)
    private LocalDateTime generatedAt;

    @Lob
    @Column(name = "qr_image_base64", columnDefinition = "LONGTEXT")
    private String qrImageBase64;

    @PrePersist
    protected void onCreate() {
        generatedAt = LocalDateTime.now();
    }


}
