package com.nexmeet.platform.entity;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/*
 * A Speaker belongs to a Conference and optionally to a specific Session.
 * conference_id is always required (NOT NULL).
 * session_id is optional (NULL means they speak at the whole conference).
 */

@Getter
@Setter
@NoArgsConstructor
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
    @ManyToMany(mappedBy = "speakers",
            fetch = FetchType.LAZY)
    private List<Session> sessions =
            new ArrayList<>();


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


}
