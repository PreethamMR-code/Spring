package com.nexmeet.platform.dto;

public class SpeakerDto {

    private Long conferenceId;
    private String fullName;
    private String designation;
    private String organization;
    private String bio;
    private String topic;
    private String email;
    private String photoUrl;

    public Long getConferenceId() { return conferenceId; }
    public void setConferenceId(Long v) { conferenceId = v; }
    public String getFullName() { return fullName; }
    public void setFullName(String v) { fullName = v; }
    public String getDesignation() { return designation; }
    public void setDesignation(String v) { designation = v; }
    public String getOrganization() { return organization; }
    public void setOrganization(String v) { organization = v; }
    public String getBio() { return bio; }
    public void setBio(String v) { bio = v; }
    public String getTopic() { return topic; }
    public void setTopic(String v) { topic = v; }
    public String getEmail() { return email; }
    public void setEmail(String v) { email = v; }
    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String v) { photoUrl = v; }
}
