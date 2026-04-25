package com.nexmeet.platform.dto;

public class SessionDto {

    private Long conferenceId;
    private Long speakerId;
    private String title;
    private String description;
    private String startTime;  // datetime-local input format
    private String endTime;
    private String roomOrLink;
    private String sessionType;

    public Long getConferenceId() { return conferenceId; }
    public void setConferenceId(Long v) { conferenceId = v; }
    public Long getSpeakerId() { return speakerId; }
    public void setSpeakerId(Long v) { speakerId = v; }
    public String getTitle() { return title; }
    public void setTitle(String v) { title = v; }
    public String getDescription() { return description; }
    public void setDescription(String v) { description = v; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String v) { startTime = v; }
    public String getEndTime() { return endTime; }
    public void setEndTime(String v) { endTime = v; }
    public String getRoomOrLink() { return roomOrLink; }
    public void setRoomOrLink(String v) { roomOrLink = v; }
    public String getSessionType() { return sessionType; }
    public void setSessionType(String v) { sessionType = v; }
}
