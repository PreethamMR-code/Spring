package com.nexmeet.platform.entity;

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

    public BulkUpload() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public User getUploadedBy() { return uploadedBy; }
    public void setUploadedBy(User uploadedBy) { this.uploadedBy = uploadedBy; }

    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public Integer getTotalRows() { return totalRows; }
    public void setTotalRows(Integer totalRows) { this.totalRows = totalRows; }

    public Integer getSuccessfulRows() { return successfulRows; }
    public void setSuccessfulRows(Integer successfulRows) { this.successfulRows = successfulRows; }

    public Integer getFailedRows() { return failedRows; }
    public void setFailedRows(Integer failedRows) { this.failedRows = failedRows; }

    public String getErrorLog() { return errorLog; }
    public void setErrorLog(String errorLog) { this.errorLog = errorLog; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getUploadedAt() { return uploadedAt; }

    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }
}
