package com.nexmeet.platform.dto;

public class FeedbackDto {

    private Long conferenceId;
    private Integer overallRating;
    private Integer organizationRating;
    private Integer contentRating;
    private Integer speakerRating;
    private String comments;
    private boolean isPublic = true;

    public Long getConferenceId() { return conferenceId; }
    public void setConferenceId(Long v) { this.conferenceId = v; }
    public Integer getOverallRating() { return overallRating; }
    public void setOverallRating(Integer v) { this.overallRating = v; }
    public Integer getOrganizationRating() { return organizationRating; }
    public void setOrganizationRating(Integer v) { this.organizationRating = v; }
    public Integer getContentRating() { return contentRating; }
    public void setContentRating(Integer v) { this.contentRating = v; }
    public Integer getSpeakerRating() { return speakerRating; }
    public void setSpeakerRating(Integer v) { this.speakerRating = v; }
    public String getComments() { return comments; }
    public void setComments(String v) { this.comments = v; }
    public boolean isPublic() { return isPublic; }
    public void setPublic(boolean v) { this.isPublic = v; }


}
