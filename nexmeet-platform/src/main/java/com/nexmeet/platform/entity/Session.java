package com.nexmeet.platform.entity;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/*
 * A Session is one talk/workshop/panel inside a Conference.
 * One Conference has MANY Sessions.
 * This is a @ManyToOne from Session's side (many sessions, one conference).
 */
@Entity
@Table(name = "sessions")
public class Session {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /*
     * This is the parent relationship.
     * When you load a Session, you can call session.getConference()
     * to get the full Conference object without a separate query.
     * Hibernate handles the JOIN automatically.
     */
    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    @Column(name = "title", nullable = false, length = 300)
    private String title;

    @Lob
    @Column(name = "description")
    private String description;

    /*
     * session_type is stored as VARCHAR in MySQL (we already altered it).
     * Possible values: KEYNOTE, WORKSHOP, PANEL, PRESENTATION, QA, NETWORKING
     * We keep it as String here (not an enum) to keep things simple for now.
     * You could create a SessionType enum later if needed.
     */
    @Column(name = "session_type", length = 20)
    private String sessionType = "PRESENTATION";

    @Column(name = "start_time", nullable = false)
    private LocalDateTime startTime;

    @Column(name = "end_time", nullable = false)
    private LocalDateTime endTime;

    @Column(name = "room_or_link", length = 300)
    private String roomOrLink;

    @Column(name = "capacity")
    private Integer capacity;

    @OneToMany(mappedBy = "session", fetch = FetchType.LAZY)
    private List<Speaker> speakers =
            new ArrayList<>();

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public Session() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getSessionType() { return sessionType; }
    public void setSessionType(String sessionType) { this.sessionType = sessionType; }

    public LocalDateTime getStartTime() { return startTime; }
    public void setStartTime(LocalDateTime startTime) { this.startTime = startTime; }

    public LocalDateTime getEndTime() { return endTime; }
    public void setEndTime(LocalDateTime endTime) { this.endTime = endTime; }

    public String getRoomOrLink() { return roomOrLink; }
    public void setRoomOrLink(String roomOrLink) { this.roomOrLink = roomOrLink; }

    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }

    public java.util.List<Speaker> getSpeakers() {
        return speakers;
    }
    public void setSpeakers(java.util.List<Speaker> s) {
        speakers = s;
    }

    public LocalDateTime getCreatedAt() { return createdAt; }
}
