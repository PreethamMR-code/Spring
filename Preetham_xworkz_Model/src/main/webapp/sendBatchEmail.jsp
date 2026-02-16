<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Entire Batch | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f0f4f8; }
        .compose-card  { border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .batch-banner  { background: linear-gradient(135deg, #0d6efd, #0a58ca); color: white; border-radius: 14px; padding: 1.5rem; }
        .student-chip  { background: white; border: 1px solid #e2e8f0; border-radius: 20px; padding: 4px 14px; font-size: 0.82rem; display: inline-flex; align-items: center; gap: 6px; }
        .label-sm      { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; font-weight: 700; color: #64748b; margin-bottom: 0.4rem; }
        .preview-box   { background: #f8fafc; border: 2px dashed #cbd5e1; border-radius: 10px; padding: 1.2rem; font-size: 0.88rem; color: #475569; }
        textarea       { resize: vertical; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-primary shadow-sm">
    <div class="container-fluid px-4">
        <span class="navbar-brand fw-bold">
            <i class="bi bi-envelope-paper me-2"></i>Email Entire Batch
        </span>
        <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>" class="btn btn-outline-light btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Back to Batch
        </a>
    </div>
</nav>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-9">

            <%-- Batch info + recipients banner --%>
            <div class="batch-banner mb-4">
                <div class="d-flex align-items-start justify-content-between flex-wrap gap-3">
                    <div>
                        <h5 class="fw-bold mb-1">
                            <i class="bi bi-layers me-2"></i>${batch.batchName}
                        </h5>
                        <div class="opacity-75 small mb-3">
                            ${batch.course} &nbsp;·&nbsp; ${batch.instructor} &nbsp;·&nbsp; ${batch.batchType}
                        </div>
                        <%-- Recipient chips --%>
                        <div class="d-flex flex-wrap gap-2">
                            <c:forEach var="s" items="${students}">
                                <span class="student-chip text-dark">
                                    <i class="bi bi-person-fill text-primary"></i>
                                    ${s.name}
                                </span>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="text-end">
                        <div class="bg-white bg-opacity-25 rounded-3 px-3 py-2 text-center">
                            <div class="fw-bold" style="font-size:2rem;">${studentCount}</div>
                            <small class="opacity-75">Recipients</small>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Compose form --%>
            <div class="card compose-card border-0">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-1"><i class="bi bi-pencil-square text-primary me-2"></i>Compose Message</h5>
                    <p class="text-muted small mb-4">Each student gets a personalized email with their own unique response link so you can track who said Yes and who said No.</p>

                    <form action="<c:url value='/dashboard/sendBatchEmail'/>" method="post" id="batchForm">
                        <input type="hidden" name="batchId" value="${batch.id}">

                        <%-- Subject --%>
                        <div class="mb-3">
                            <div class="label-sm">Email Subject *</div>
                            <input type="text" class="form-control" name="subject" required
                                   id="subjectInput"
                                   placeholder="e.g. Class rescheduled — please confirm attendance"
                                   value="Important Update from X-Workz - Action Required">
                        </div>

                        <%-- Email Body --%>
                        <div class="mb-3">
                            <div class="label-sm">Email Message *
                                <span class="text-muted text-lowercase fw-normal">(what student reads in their inbox)</span>
                            </div>
                            <textarea class="form-control" name="emailMessage" rows="5" required
                                      id="emailMsgInput"
                                      placeholder="Write your message here. Each student's name will be shown as a greeting (Hello, [Name]!)."></textarea>
                        </div>

                        <%-- Response page message --%>
                        <div class="mb-4">
                            <div class="label-sm">Response Page Question *
                                <span class="text-muted text-lowercase fw-normal">(shown above Yes / No buttons after student clicks the link)</span>
                            </div>
                            <textarea class="form-control" name="responsePageMessage" rows="3" required
                                      id="responseMsgInput"
                                      placeholder="e.g. Are you available for the rescheduled class on March 15th at 2PM?"></textarea>
                        </div>

                        <%-- Live preview --%>
                        <div class="mb-4">
                            <div class="label-sm">Email Preview</div>
                            <div class="preview-box">
                                <div class="mb-2">
                                    <strong>To:</strong>
                                    <c:forEach var="s" items="${students}" varStatus="loop">
                                        ${s.email}<c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                </div>
                                <div class="mb-2"><strong>Subject:</strong> <span id="prevSubject">Important Update from X-Workz - Action Required</span></div>
                                <hr class="my-2">
                                <div><em>Hello, [Student Name]!</em></div>
                                <div id="prevMsg" style="white-space:pre-wrap; margin-top:8px; color:#1e293b;"></div>
                                <div class="mt-3 p-2 bg-white rounded border text-center">
                                    <span class="text-primary fw-bold">[ Click Here to Respond ]</span>
                                </div>
                                <div class="mt-2 text-muted" style="font-size:0.8rem;">
                                    <em>— After clicking, they see: "<span id="prevResponseMsg"></span>"</em>
                                </div>
                            </div>
                        </div>

                        <%-- Warning + Submit --%>
                        <div class="alert alert-warning d-flex gap-2 mb-3" style="border-radius:10px;">
                            <i class="bi bi-exclamation-triangle-fill mt-1 flex-shrink-0"></i>
                            <div>
                                This will send <strong>${studentCount} separate emails</strong> — one to each student.
                                Each email has a unique link so their responses are tracked individually.
                                <strong>This cannot be undone.</strong>
                            </div>
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <a href="<c:url value='/dashboard/batchDetails/${batch.id}'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary px-4" id="sendBtn">
                                <i class="bi bi-send me-1"></i>Send to All ${studentCount} Students
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <%-- How it works info box --%>
            <div class="alert alert-info border-0 mt-3 d-flex gap-2" style="border-radius:10px;">
                <i class="bi bi-info-circle-fill mt-1 flex-shrink-0"></i>
                <div>
                    <strong>How batch email works:</strong> Each student gets their own email with a personalized "Click Here to Respond" button.
                    When they click it, they see your <em>Response Page Question</em> with <strong>Yes</strong> and <strong>No</strong> buttons.
                    All responses appear in the <strong>Email Responses</strong> page where you can see who said Yes, No, or hasn't responded yet.
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const subjectInput     = document.getElementById('subjectInput');
    const emailMsgInput    = document.getElementById('emailMsgInput');
    const responseMsgInput = document.getElementById('responseMsgInput');
    const prevSubject      = document.getElementById('prevSubject');
    const prevMsg          = document.getElementById('prevMsg');
    const prevResponseMsg  = document.getElementById('prevResponseMsg');

    function updatePreview() {
        prevSubject.textContent     = subjectInput.value     || '(subject here)';
        prevMsg.textContent         = emailMsgInput.value    || '(your message here)';
        prevResponseMsg.textContent = responseMsgInput.value || '(your question here)';
    }

    subjectInput.addEventListener('input', updatePreview);
    emailMsgInput.addEventListener('input', updatePreview);
    responseMsgInput.addEventListener('input', updatePreview);
    updatePreview();

    // Prevent double-submit — disable button and show spinner
    document.getElementById('batchForm').addEventListener('submit', function () {
        const btn = document.getElementById('sendBtn');
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Sending to all students...';
    });
</script>
</body>
</html>
