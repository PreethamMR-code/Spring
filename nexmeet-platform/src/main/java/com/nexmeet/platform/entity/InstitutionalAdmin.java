package com.nexmeet.platform.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * InstitutionalAdmin = a college principal or company HR who registers
 * on NexMeet to do bulk uploads of their students/employees.
 *
 * They are a User (login credentials in users table) AND
 * they belong to an Institution (which college/company they represent).
 *
 * This entity links: User <-> Institution
 */

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "institutional_admins")
public class InstitutionalAdmin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /*
     * @OneToOne — one InstitutionalAdmin profile per User.
     * A person can only represent one institution as an admin.
     */
    @OneToOne
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    /*
     * @ManyToOne — many institutional admins can belong to
     * one institution. A large college might have multiple HRs
     * or HODs registered.
     */
    @ManyToOne
    @JoinColumn(name = "institution_id", nullable = false)
    private Institution institution;

    @Column(name = "job_title", length = 100)
    private String jobTitle;

    @Column(name = "department", length = 100)
    private String department;

    @Column(name = "is_verified", nullable = false)
    private boolean isVerified = false;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }


}
