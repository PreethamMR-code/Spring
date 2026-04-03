package com.nexmeet.platform.dto;

public class OrganizerProfileDto {

    private String organizationName;
    private String organizationType;
    private String websiteUrl;
    private String address;
    private String city;
    private String state;
    private String pincode;


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


}
