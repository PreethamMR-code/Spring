package com.nexmeet.platform.entity;


import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * A Speaker belongs to a Conference and optionally to a specific Session.
 * conference_id is always required (NOT NULL).
 * session_id is optional (NULL means they speak at the whole conference).
 */
@Entity
@Table(name = "speakers")
public class Speaker {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    /*
     * optional = true means this FK can be NULL.
     * A speaker might not be assigned to a specific session yet,
     * or they might be a keynote speaker for the whole event.
     */
    @ManyToOne(optional = true)
    @JoinColumn(name = "session_id", nullable = true)
    private Session session;

    @Column(name = "full_name", nullable = false, length = 100)
    private String fullName;

    @Column(name = "designation", length = 200)
    private String designation;

    @Column(name = "organization", length = 200)
    private String organization;

    @Lob
    @Column(name = "bio")
    private String bio;

    @Column(name = "profile_picture", length = 500)
    private String profilePicture;

    @Column(name = "linkedin_url", length = 300)
    private String linkedinUrl;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public Speaker() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public Session getSession() { return session; }
    public void setSession(Session session) { this.session = session; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public String getOrganization() { return organization; }
    public void setOrganization(String organization) { this.organization = organization; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public String getProfilePicture() { return profilePicture; }
    public void setProfilePicture(String profilePicture) { this.profilePicture = profilePicture; }

    public String getLinkedinUrl() { return linkedinUrl; }
    public void setLinkedinUrl(String linkedinUrl) { this.linkedinUrl = linkedinUrl; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public LocalDateTime getCreatedAt() { return createdAt; }
}
