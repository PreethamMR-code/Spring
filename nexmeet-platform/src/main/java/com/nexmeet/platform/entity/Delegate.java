package com.nexmeet.platform.entity;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * Delegate holds extra profile details for users who attend conferences.
 * Every Delegate is first a User (login info in users table).
 * This stores their professional details: organization, designation, etc.
 *
 * The institution_id is optional — delegates registered via bulk upload
 * from a college will have this filled. Individual registrations may not.
 */

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "delegates")
public class Delegate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @Column(name = "organization", length = 200)
    private String organization;

    @Column(name = "designation", length = 200)
    private String designation;

    /*
     * institution_id is nullable — not every delegate belongs to
     * a registered institution. Individual registrations won't have this.
     * Delegates from bulk uploads (college/company) will have this filled.
     */
    @ManyToOne(optional = true)
    @JoinColumn(name = "institution_id", nullable = true)
    private Institution institution;

    @Column(name = "city", length = 100)
    private String city;

    @Column(name = "state", length = 100)
    private String state;

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
