package com.nexmeet.platform.dto;

/*
 * SpeakerDto — used when adding a speaker to a conference.
 *
 * WHY NO conferenceId here:
 * The conferenceId comes from the URL path variable {id} in
 * the controller and is passed directly to the service.
 * Never put resource ownership IDs in form bodies — a user
 * could manipulate them to target another conference.
 *
 * WHY NO topic:
 * The speakers table has no topic column. Speaker's topic
 * is represented by the Session they are assigned to.
 * Use session.title as the topic concept.
 *
 * WHY NO photoUrl:
 * speakers table has profile_picture (a URL/path field).
 * Photo upload is a separate feature for future.
 * For now, we don't ask for it in the form.
 */
public class SpeakerDto {
    private String fullName;
    private String designation;
    private String organization;
    private String bio;
    private String email;
    private String linkedinUrl;  // maps to linkedin_url column

    public String getFullName() { return fullName; }
    public void setFullName(String v) { fullName = v; }
    public String getDesignation() { return designation; }
    public void setDesignation(String v) { designation = v; }
    public String getOrganization() { return organization; }
    public void setOrganization(String v) { organization = v; }
    public String getBio() { return bio; }
    public void setBio(String v) { bio = v; }
    public String getEmail() { return email; }
    public void setEmail(String v) { email = v; }
    public String getLinkedinUrl() { return linkedinUrl; }
    public void setLinkedinUrl(String v) { linkedinUrl = v; }
}