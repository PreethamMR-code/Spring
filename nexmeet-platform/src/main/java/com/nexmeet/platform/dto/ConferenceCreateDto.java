package com.nexmeet.platform.dto;

import com.nexmeet.platform.enums.ConferenceMode;
import com.nexmeet.platform.enums.ConferenceType;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ConferenceCreateDto {

    private String title;
    private String description;
    private ConferenceType conferenceType;
    private ConferenceMode mode;
    private String targetAudience;
    private String targetDomains;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime endDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime registrationDeadline;

    private String venueName;
    private String venueAddress;
    private String city;
    private String state;
    private String streamingLink;

    private Integer maxDelegates = 100;
    private boolean free = true;
    private BigDecimal delegateFee = BigDecimal.ZERO;
    private boolean certificateEnabled = false;
    private boolean qrCheckinEnabled = false;
    private boolean bulkUploadAllowed = true;


    // Getters and Setters
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public ConferenceType getConferenceType() { return conferenceType; }
    public void setConferenceType(ConferenceType conferenceType) { this.conferenceType = conferenceType; }
    public ConferenceMode getMode() { return mode; }
    public void setMode(ConferenceMode mode) { this.mode = mode; }
    public String getTargetAudience() { return targetAudience; }
    public void setTargetAudience(String targetAudience) { this.targetAudience = targetAudience; }
    public String getTargetDomains() { return targetDomains; }
    public void setTargetDomains(String targetDomains) { this.targetDomains = targetDomains; }
    public LocalDateTime getStartDate() { return startDate; }
    public void setStartDate(LocalDateTime startDate) { this.startDate = startDate; }
    public LocalDateTime getEndDate() { return endDate; }
    public void setEndDate(LocalDateTime endDate) { this.endDate = endDate; }
    public LocalDateTime getRegistrationDeadline() { return registrationDeadline; }
    public void setRegistrationDeadline(LocalDateTime registrationDeadline) { this.registrationDeadline = registrationDeadline; }
    public String getVenueName() { return venueName; }
    public void setVenueName(String venueName) { this.venueName = venueName; }
    public String getVenueAddress() { return venueAddress; }
    public void setVenueAddress(String venueAddress) { this.venueAddress = venueAddress; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getState() { return state; }
    public void setState(String state) { this.state = state; }
    public String getStreamingLink() { return streamingLink; }
    public void setStreamingLink(String streamingLink) { this.streamingLink = streamingLink; }
    public Integer getMaxDelegates() { return maxDelegates; }
    public void setMaxDelegates(Integer maxDelegates) { this.maxDelegates = maxDelegates; }
    public boolean isFree() { return free; }
    public void setFree(boolean free) { this.free = free; }
    public BigDecimal getDelegateFee() { return delegateFee; }
    public void setDelegateFee(BigDecimal delegateFee) { this.delegateFee = delegateFee; }
    public boolean isCertificateEnabled() { return certificateEnabled; }
    public void setCertificateEnabled(boolean certificateEnabled) { this.certificateEnabled = certificateEnabled; }
    public boolean isQrCheckinEnabled() { return qrCheckinEnabled; }
    public void setQrCheckinEnabled(boolean qrCheckinEnabled) { this.qrCheckinEnabled = qrCheckinEnabled; }
    public boolean isBulkUploadAllowed() { return bulkUploadAllowed; }
    public void setBulkUploadAllowed(boolean bulkUploadAllowed) { this.bulkUploadAllowed = bulkUploadAllowed; }
}
