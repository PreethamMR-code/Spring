package com.xworkz.model.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "email_notifications")
public class EmailNotificationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // Which batch this email belongs to
    @Column(name = "batch_id", nullable = false)
    private int batchId;

    // Which student this was sent to
    @Column(name = "student_id", nullable = false)  // FK to batch_students.id
    private int studentId;

    @Column(name = "student_name", length = 100)
    private String studentName;

    @Column(name = "student_email", nullable = false, length = 100)
    private String studentEmail;

    // Subject line of the email
    @Column(name = "subject", length = 255)
    private String subject;

    // The message body the admin wrote
    @Column(name = "message", columnDefinition = "TEXT")
    private String message;

    // The message shown on the response page (can be same or different from message)
    @Column(name = "response_page_message", columnDefinition = "TEXT")
    private String responsePageMessage;

    // Unique token embedded in the link sent to student
    // Used to identify which notification the student is responding to
    @Column(name = "response_token", unique = true, length = 100)
    private String responseToken;

    // When the admin sent the email
    @Column(name = "sent_at")
    private LocalDateTime sentAt;

    // NULL = not responded, "YES" = clicked Yes, "NO" = clicked No
    @Column(name = "response", length = 10)
    private String response;  // null | "YES" | "NO"

    // When the student clicked Yes or No
    @Column(name = "responded_at")
    private LocalDateTime respondedAt;

    // Sent by which admin (from session)
    @Column(name = "sent_by", length = 100)
    private String sentBy;
}


