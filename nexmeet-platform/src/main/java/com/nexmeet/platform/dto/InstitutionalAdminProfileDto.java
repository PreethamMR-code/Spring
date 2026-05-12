package com.nexmeet.platform.dto;

public class InstitutionalAdminProfileDto {

    private Long institutionId;
    private String jobTitle;
    private String department;

    public Long getInstitutionId() { return institutionId; }
    public void setInstitutionId(Long i) { institutionId = i; }
    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String j) { jobTitle = j; }
    public String getDepartment() { return department; }
    public void setDepartment(String d) { department = d; }

}