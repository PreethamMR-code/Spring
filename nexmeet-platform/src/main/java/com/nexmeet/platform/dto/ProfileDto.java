package com.nexmeet.platform.dto;

public class ProfileDto {

    private String fullName;
    private String phone;

    // Organizer-specific fields
    private String organizationName;
    private String organizationType;
    private String websiteUrl;
    private String address;
    private String city;
    private String state;
    private String pincode;

    // Current password (for change password)
    private String currentPassword;
    private String newPassword;
    private String confirmNewPassword;

    public String getFullName() { return fullName; }
    public void setFullName(String v) { this.fullName = v; }
    public String getPhone() { return phone; }
    public void setPhone(String v) { this.phone = v; }
    public String getOrganizationName() { return organizationName; }
    public void setOrganizationName(String v) { this.organizationName = v; }
    public String getOrganizationType() { return organizationType; }
    public void setOrganizationType(String v) { this.organizationType = v; }
    public String getWebsiteUrl() { return websiteUrl; }
    public void setWebsiteUrl(String v) { this.websiteUrl = v; }
    public String getAddress() { return address; }
    public void setAddress(String v) { this.address = v; }
    public String getCity() { return city; }
    public void setCity(String v) { this.city = v; }
    public String getState() { return state; }
    public void setState(String v) { this.state = v; }
    public String getPincode() { return pincode; }
    public void setPincode(String v) { this.pincode = v; }
    public String getCurrentPassword() { return currentPassword; }
    public void setCurrentPassword(String v) { this.currentPassword = v; }
    public String getNewPassword() { return newPassword; }
    public void setNewPassword(String v) { this.newPassword = v; }
    public String getConfirmNewPassword() { return confirmNewPassword; }
    public void setConfirmNewPassword(String v) { this.confirmNewPassword = v; }


}
