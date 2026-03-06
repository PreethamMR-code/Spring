package com.nexmeet.platform.entity;


import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * Attendance records when a delegate actually shows up at an event.
 * This is separate from Registration because:
 * - Registration = "I plan to attend"
 * - Attendance   = "I actually attended" (QR was scanned at the door)
 *
 * One Registration = at most One Attendance record (OneToOne).
 */
@Entity
@Table(name = "attendance")
public class Attendance {

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
     * checkedInBy = the organizer/staff member who scanned the QR.
     * We track this for accountability — you can see who checked in
     * which delegate, and when.
     */
    @ManyToOne
    @JoinColumn(name = "checked_in_by", nullable = false)
    private User checkedInBy;

    @Column(name = "checked_in_at", nullable = false, updatable = false)
    private LocalDateTime checkedInAt;

    @PrePersist
    protected void onCreate() {
        checkedInAt = LocalDateTime.now();
    }

    public Attendance() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Registration getRegistration() { return registration; }
    public void setRegistration(Registration registration) { this.registration = registration; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public User getCheckedInBy() { return checkedInBy; }
    public void setCheckedInBy(User checkedInBy) { this.checkedInBy = checkedInBy; }

    public LocalDateTime getCheckedInAt() { return checkedInAt; }
}
