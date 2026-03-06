package com.nexmeet.platform.entity;


import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * OutreachContact records every time the platform contacts
 * a college or company for a specific conference.
 *
 * This is NexMeet's unique feature — the admin proactively
 * reaches out to institutions to drive registrations.
 *
 * The status tracks the conversation:
 * CONTACTED -> RESPONDED -> INTERESTED -> REGISTERED
 *                        -> NOT_INTERESTED
 */
@Entity
@Table(name = "outreach_contacts")
public class OutreachContact {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    @ManyToOne
    @JoinColumn(name = "institution_id", nullable = false)
    private Institution institution;

    // The admin who made this outreach
    @ManyToOne
    @JoinColumn(name = "contacted_by", nullable = false)
    private User contactedBy;

    // EMAIL, PHONE, or BOTH
    @Column(name = "contact_method", nullable = false, length = 10)
    private String contactMethod = "EMAIL";

    /*
     * Status of the outreach conversation:
     * CONTACTED     = we sent an email/called
     * RESPONDED     = they replied
     * INTERESTED    = they want to participate
     * NOT_INTERESTED = they declined
     * REGISTERED    = delegates from this institution actually registered
     */
    @Column(name = "status", nullable = false, length = 20)
    private String status = "CONTACTED";

    @Lob
    @Column(name = "notes")
    private String notes;

    @Column(name = "contacted_at", nullable = false, updatable = false)
    private LocalDateTime contactedAt;

    @Column(name = "responded_at")
    private LocalDateTime respondedAt;

    @PrePersist
    protected void onCreate() {
        contactedAt = LocalDateTime.now();
    }

    public OutreachContact() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public Institution getInstitution() { return institution; }
    public void setInstitution(Institution institution) { this.institution = institution; }

    public User getContactedBy() { return contactedBy; }
    public void setContactedBy(User contactedBy) { this.contactedBy = contactedBy; }

    public String getContactMethod() { return contactMethod; }
    public void setContactMethod(String contactMethod) { this.contactMethod = contactMethod; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public LocalDateTime getContactedAt() { return contactedAt; }

    public LocalDateTime getRespondedAt() { return respondedAt; }
    public void setRespondedAt(LocalDateTime respondedAt) { this.respondedAt = respondedAt; }
}
