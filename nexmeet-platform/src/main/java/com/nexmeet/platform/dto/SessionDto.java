package com.nexmeet.platform.dto;

/*
 * SessionDto — used when adding a session to a conference schedule.
 *
 * WHY NO conferenceId:
 * Same as SpeakerDto — comes from URL {id}, not form body.
 *
 * WHY NO speakerId:
 * Speaker assignment to session is a separate operation via
 * POST /schedule/{sessionId}/assign-speaker.
 * This allows organizer to first create all sessions,
 * then assign speakers to each — better UX and workflow.
 *
 * startTime and endTime are Strings because HTML datetime-local
 * input sends "2026-06-10T09:00" format which we parse to
 * LocalDateTime in the service layer.
 */
public class SessionDto {
    private String title;
    private String description;
    private String sessionType;
    private String startTime;   // "2026-06-10T09:00" format
    private String endTime;
    private String roomOrLink;
    private Integer capacity;   // maps to capacity column

    public String getTitle() { return title; }
    public void setTitle(String v) { title = v; }
    public String getDescription() { return description; }
    public void setDescription(String v) { description = v; }
    public String getSessionType() { return sessionType; }
    public void setSessionType(String v) { sessionType = v; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String v) { startTime = v; }
    public String getEndTime() { return endTime; }
    public void setEndTime(String v) { endTime = v; }
    public String getRoomOrLink() { return roomOrLink; }
    public void setRoomOrLink(String v) { roomOrLink = v; }
    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer v) { capacity = v; }
}