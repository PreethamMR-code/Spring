package com.nexmeet.platform.entity;

import com.nexmeet.platform.enums.InstitutionType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
@Getter
@Setter
@NoArgsConstructor
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



    @Override
    public String toString() {
        return "Institution{id=" + id + ", name='" + name + "', type=" + type + "}";
    }
}
