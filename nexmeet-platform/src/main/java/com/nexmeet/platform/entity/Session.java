package com.nexmeet.platform.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/*
 * A Session is one talk/workshop/panel inside a Conference.
 * One Conference has MANY Sessions.
 * This is a @ManyToOne from Session's side (many sessions, one conference).
 */

@Getter
@Setter
@NoArgsConstructor
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

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "session_speakers",

            joinColumns =
            @JoinColumn(name = "session_id"),

            inverseJoinColumns =
            @JoinColumn(name = "speaker_id")
    )
    private List<Speaker> speakers =
            new ArrayList<>();

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }


}
