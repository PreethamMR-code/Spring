package com.nexmeet.platform.entity;

import com.nexmeet.platform.enums.InstitutionType;

import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * Institution represents colleges and companies in NexMeet's outreach database.
 * These exist independently — a college can be in this table even before
 * anyone from that college has registered on NexMeet.
 *
 * The admin uses this table to contact colleges/companies and invite
 * their students/employees to conferences.
 */
@Entity
@Table(name = "institutions")
public class Institution {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name", nullable = false, length = 200)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false, length = 20)
    private InstitutionType type;

    @Column(name = "contact_person", length = 100)
    private String contactPerson;

    @Column(name = "contact_role", length = 100)
    private String contactRole;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "phone", length = 15)
    private String phone;

    @Column(name = "website", length = 300)
    private String website;

    @Column(name = "address", length = 500)
    private String address;

    @Column(name = "city", length = 100)
    private String city;

    @Column(name = "state", length = 100)
    private String state;

    @Column(name = "pincode", length = 10)
    private String pincode;

    /*
     * domains stores areas of interest as comma-separated text.
     * Example: "CSE,IT,ECE" for a tech college.
     * Later, admin can filter institutions by domain
     * when doing targeted outreach for a specific conference.
     */
    @Column(name = "domains", length = 500)
    private String domains;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public Institution() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public InstitutionType getType() { return type; }
    public void setType(InstitutionType type) { this.type = type; }

    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }

    public String getContactRole() { return contactRole; }
    public void setContactRole(String contactRole) { this.contactRole = contactRole; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getPincode() { return pincode; }
    public void setPincode(String pincode) { this.pincode = pincode; }

    public String getDomains() { return domains; }
    public void setDomains(String domains) { this.domains = domains; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }

    @Override
    public String toString() {
        return "Institution{id=" + id + ", name='" + name + "', type=" + type + "}";
    }
}
