package com.nexmeet.platform.entity;


import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * Certificate is generated after a conference ends
 * for delegates who attended (attendance record exists).
 * It's a PDF file with the delegate's name, conference name,
 * and a unique certificate number.
 */
@Entity
@Table(name = "certificates")
public class Certificate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @OneToOne
    @JoinColumn(name = "registration_id", nullable = false, unique = true)
    private Registration registration;

    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /*
     * certificate_number is the unique ID printed on the certificate.
     * Format: NM-CERT-2025-000456
     * Delegates can share this number and anyone can verify it
     * on the platform by searching this number.
     */
    @Column(name = "certificate_number", nullable = false, unique = true, length = 100)
    private String certificateNumber;

    // Path to the generated PDF file on the server
    @Column(name = "file_path", length = 500)
    private String filePath;

    @Column(name = "issued_at", nullable = false, updatable = false)
    private LocalDateTime issuedAt;

    @PrePersist
    protected void onCreate() {
        issuedAt = LocalDateTime.now();
    }

    public Certificate() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Registration getRegistration() { return registration; }
    public void setRegistration(Registration registration) { this.registration = registration; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getCertificateNumber() { return certificateNumber; }
    public void setCertificateNumber(String certificateNumber) { this.certificateNumber = certificateNumber; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public LocalDateTime getIssuedAt() { return issuedAt; }
}
