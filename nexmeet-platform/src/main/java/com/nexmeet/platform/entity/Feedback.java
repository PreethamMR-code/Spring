package com.nexmeet.platform.entity;


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
    private boolean isPublic = true;

    @Column(name = "submitted_at", nullable = false, updatable = false)
    private LocalDateTime submittedAt;

    @PrePersist
    protected void onCreate() {
        submittedAt = LocalDateTime.now();
    }

    public Feedback() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Integer getOverallRating() { return overallRating; }
    public void setOverallRating(Integer overallRating) { this.overallRating = overallRating; }

    public Integer getOrganizationRating() { return organizationRating; }
    public void setOrganizationRating(Integer organizationRating) { this.organizationRating = organizationRating; }

    public Integer getContentRating() { return contentRating; }
    public void setContentRating(Integer contentRating) { this.contentRating = contentRating; }

    public Integer getSpeakerRating() { return speakerRating; }
    public void setSpeakerRating(Integer speakerRating) { this.speakerRating = speakerRating; }

    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }

    public boolean isPublic() { return isPublic; }
    public void setPublic(boolean aPublic) { isPublic = aPublic; }

    public LocalDateTime getSubmittedAt() { return submittedAt; }
}
