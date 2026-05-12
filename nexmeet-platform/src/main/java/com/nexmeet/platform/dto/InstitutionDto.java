package com.nexmeet.platform.dto;

import com.nexmeet.platform.enums.InstitutionType;

public class InstitutionDto {

    private String name;
    private InstitutionType type;
    private String contactPerson;
    private String contactRole;
    private String email;
    private String phone;
    private String website;
    private String address;
    private String city;
    private String state;
    private String pincode;
    private String domains;

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String n) { name = n; }
    public InstitutionType getType() { return type; }
    public void setType(InstitutionType t) { type = t; }
    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String c) { contactPerson = c; }
    public String getContactRole() { return contactRole; }
    public void setContactRole(String c) { contactRole = c; }
    public String getEmail() { return email; }
    public void setEmail(String e) { email = e; }
    public String getPhone() { return phone; }
    public void setPhone(String p) { phone = p; }
    public String getWebsite() { return website; }
    public void setWebsite(String w) { website = w; }
    public String getAddress() { return address; }
    public void setAddress(String a) { address = a; }
    public String getCity() { return city; }
    public void setCity(String c) { city = c; }
    public String getState() { return state; }
    public void setState(String s) { state = s; }
    public String getPincode() { return pincode; }
    public void setPincode(String p) { pincode = p; }
    public String getDomains() { return domains; }
    public void setDomains(String d) { domains = d; }
}