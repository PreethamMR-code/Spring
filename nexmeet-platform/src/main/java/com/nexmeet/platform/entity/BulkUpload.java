package com.nexmeet.platform.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * BulkUpload tracks every Excel file uploaded by an institutional admin.
 * When a college HR uploads 200 student names, ONE BulkUpload record
 * is created, then 200 Registration records are created linked to it.
 *
 * The error_log stores details about rows that failed —
 * e.g. "Row 5: Email already registered", "Row 12: Invalid phone number"
 * This helps the HR know exactly which students didn't get registered.
 */
@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "bulk_uploads")
public class BulkUpload {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    /*
     * uploaded_by = the institutional admin who uploaded the file.
     * We store the User, not the InstitutionalAdmin, because
     * the user_id is what we have in the security context.
     */
    @ManyToOne
    @JoinColumn(name = "uploaded_by", nullable = false)
    private User uploadedBy;

    @Column(name = "file_name", nullable = false, length = 300)
    private String fileName;

    @Column(name = "file_path", nullable = false, length = 500)
    private String filePath;

    // Counters updated as the file is processed
    @Column(name = "total_rows")
    private Integer totalRows = 0;

    @Column(name = "successful_rows")
    private Integer successfulRows = 0;

    @Column(name = "failed_rows")
    private Integer failedRows = 0;

    /*
     * error_log is a detailed text of what went wrong row by row.
     * Format: "Row 3: Email already exists\nRow 7: Missing phone\n..."
     * Stored as LONGTEXT because it can be large for big files.
     */
    @Lob
    @Column(name = "error_log")
    private String errorLog;

    // PROCESSING, COMPLETED, or FAILED
    @Column(name = "status", nullable = false, length = 20)
    private String status = "PROCESSING";

    @Column(name = "uploaded_at", nullable = false, updatable = false)
    private LocalDateTime uploadedAt;

    @Column(name = "completed_at")
    private LocalDateTime completedAt;

    @PrePersist
    protected void onCreate() {
        uploadedAt = LocalDateTime.now();
    }


}
