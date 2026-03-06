package com.nexmeet.platform.entity;


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

    @PrePersist
    protected void onCreate() {
        generatedAt = LocalDateTime.now();
    }

    public QrCode() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Registration getRegistration() { return registration; }
    public void setRegistration(Registration registration) { this.registration = registration; }

    public String getQrToken() { return qrToken; }
    public void setQrToken(String qrToken) { this.qrToken = qrToken; }

    public String getQrImagePath() { return qrImagePath; }
    public void setQrImagePath(String qrImagePath) { this.qrImagePath = qrImagePath; }

    public LocalDateTime getGeneratedAt() { return generatedAt; }
}
