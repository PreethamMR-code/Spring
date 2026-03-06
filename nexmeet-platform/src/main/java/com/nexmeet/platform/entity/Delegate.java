package com.nexmeet.platform.entity;


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

    public Delegate() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getOrganization() { return organization; }
    public void setOrganization(String organization) { this.organization = organization; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public Institution getInstitution() { return institution; }
    public void setInstitution(Institution institution) { this.institution = institution; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
