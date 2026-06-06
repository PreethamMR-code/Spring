package com.nexmeet.platform.entity;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * Feedback is submitted by delegates after a conference ends.
 * One delegate can submit feedback for one conference only once
 * (enforced by the unique constraint).
 *
 * Ratings are 1-5 for different aspects.
 * The organizer's average_rating in the Organizer table is
 * calculated from all feedback records for their conferences.
 */



@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "feedback",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "one_feedback_per_user",
                        columnNames = {"conference_id", "user_id"}
                )
        }
)
public class Feedback {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // Rating 1-5. Validation happens in the Service layer.
    @Column(name = "overall_rating", nullable = false)
    private Integer overallRating;

    @Column(name = "organization_rating")
    private Integer organizationRating;

    @Column(name = "content_rating")
    private Integer contentRating;

    @Column(name = "speaker_rating")
    private Integer speakerRating;

    @Lob
    @Column(name = "comments")
    private String comments;

    /*
     * isPublic controls whether this feedback is shown on the
     * public conference page. Default is true.
     * Admins can hide specific feedback if needed.
     */
    @Column(name = "is_public", nullable = false)
    private boolean publiclyVisible = true;

    @Column(name = "submitted_at", nullable = false, updatable = false)
    private LocalDateTime submittedAt;

    @PrePersist
    protected void onCreate() {
        submittedAt = LocalDateTime.now();
    }


}
