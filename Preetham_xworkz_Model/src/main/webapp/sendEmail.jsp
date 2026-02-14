<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Email | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f0f4f8; }
        .compose-card { border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .student-badge { background: linear-gradient(135deg, #667eea, #764ba2); color: white; border-radius: 12px; padding: 1.25rem; }
        .preview-box { background: #f8fafc; border: 2px dashed #cbd5e1; border-radius: 10px; padding: 1rem; font-size: 0.88rem; color: #475569; }
        .label-sm { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; font-weight: 700; color: #64748b; margin-bottom: 0.4rem; }
        textarea { resize: vertical; min-height: 100px; }
    </style>
</head>
<body>

<%-- Navbar --%>
<nav class="navbar navbar-dark bg-primary shadow-sm">
    <div class="container-fluid px-4">
        <span class="navbar-brand fw-bold">
            <i class="bi bi-envelope-paper me-2"></i>Compose Email
        </span>
        <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>" class="btn btn-outline-light btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Back to Batch
        </a>
    </div>
</nav>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <%-- Student Info Card --%>
            <div class="student-badge mb-4">
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-white bg-opacity-25 rounded-circle d-flex align-items-center justify-content-center"
                         style="width:55px;height:55px;flex-shrink:0;">
                        <i class="bi bi-person-fill text-white fs-3"></i>
                    </div>
                    <div>
                        <h5 class="mb-0 fw-bold">${student.name}</h5>
                        <div class="d-flex gap-3 mt-1 flex-wrap">
                            <small><i class="bi bi-envelope me-1"></i>${student.email}</small>
                            <small><i class="bi bi-phone me-1"></i>${student.phone}</small>
                            <small><i class="bi bi-tag me-1"></i>${student.studentId}</small>
                        </div>
                        <small class="opacity-75 mt-1 d-block"><i class="bi bi-layers me-1"></i>Batch: ${batch.batchName}</small>
                    </div>
                </div>
            </div>

            <%-- Compose Form --%>
            <div class="card compose-card border-0">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-4"><i class="bi bi-pencil-square text-primary me-2"></i>Write Your Message</h5>

                    <form action="<c:url value='/dashboard/sendEmail'/>" method="post" id="composeForm">
                        <input type="hidden" name="studentId" value="${student.id}">
                        <input type="hidden" name="batchId"   value="${batch.id}">

                        <%-- Subject --%>
                        <div class="mb-3">
                            <div class="label-sm">Email Subject *</div>
                            <input type="text" class="form-control" name="subject" required
                                   placeholder="e.g. Important update about your course"
                                   value="Important Update from X-Workz - Action Required">
                        </div>

                        <%-- Email Body --%>
                        <div class="mb-3">
                            <div class="label-sm">Email Message *
                                <span class="text-muted text-lowercase fw-normal">(This is what the student reads in their inbox)</span>
                            </div>
                            <textarea class="form-control" name="emailMessage" rows="5" required
                                      placeholder="Dear [Student Name],&#10;&#10;Write your message here...&#10;&#10;This email will include a link for the student to respond."
                                      id="emailMsg"></textarea>
                        </div>

                        <%-- Response Page Message --%>
                        <div class="mb-4">
                            <div class="label-sm">Response Page Message *
                                <span class="text-muted text-lowercase fw-normal">(Shown to student AFTER they click the link — above the Yes/No buttons)</span>
                            </div>
                            <textarea class="form-control" name="responsePageMessage" rows="3" required
                                      placeholder="e.g. Are you available for the rescheduled class on March 15th at 2PM?"
                                      id="responseMsg"></textarea>
                        </div>

                        <%-- Live Preview --%>
                        <div class="mb-4">
                            <div class="label-sm">Preview</div>
                            <div class="preview-box" id="previewBox">
                                <strong>To:</strong> ${student.email}<br>
                                <strong>Subject:</strong> <span id="prevSubject">Important Update from X-Workz - Action Required</span><br><br>
                                <span id="prevMsg" style="white-space:pre-wrap;"></span><br><br>
                                <span class="text-primary">[ Click Here to Respond ] ← student will see a button linking to your response page</span>
                            </div>
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>"
                               class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary px-4" id="sendBtn">
                                <i class="bi bi-send me-1"></i>Send Email
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <%-- Info box --%>
            <div class="alert alert-info border-0 mt-3 d-flex gap-2" style="border-radius:10px;">
                <i class="bi bi-info-circle-fill mt-1 flex-shrink-0"></i>
                <div>
                    <strong>How it works:</strong> The student receives your email with a "Click Here to Respond" button.
                    When they click it, they see your <em>Response Page Message</em> along with <strong>Yes</strong> and <strong>No</strong> buttons.
                    Their answer is saved and shown in the batch details page.
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Live preview update
    const subjectInput = document.querySelector('input[name="subject"]');
    const emailMsgTA   = document.getElementById('emailMsg');
    const prevSubject  = document.getElementById('prevSubject');
    const prevMsg      = document.getElementById('prevMsg');

    function updatePreview() {
        prevSubject.textContent = subjectInput.value || 'Your subject here';
        prevMsg.textContent     = emailMsgTA.value  || 'Your message here...';
    }

    subjectInput.addEventListener('input', updatePreview);
    emailMsgTA.addEventListener('input', updatePreview);
    updatePreview();

    // Disable button on submit to prevent double-send
    document.getElementById('composeForm').addEventListener('submit', function() {
        const btn = document.getElementById('sendBtn');
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Sending...';
    });
</script>
</body>
</html>
