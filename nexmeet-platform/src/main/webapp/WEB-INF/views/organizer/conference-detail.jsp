<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${conf.title} - Organizer View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>


<div class="container py-4">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-start mb-4">
        <div>
            <h2 class="text-success mb-1">${conf.title}</h2>
            <span class="badge
                ${conf.status == 'APPROVED'   ? 'bg-success' :
                  conf.status == 'SUBMITTED'  ? 'bg-warning text-dark' :
                  conf.status == 'REJECTED'   ? 'bg-danger' :
                  conf.status == 'CANCELLED'  ? 'bg-danger' :
                  conf.status == 'COMPLETED'  ? 'bg-dark' : 'bg-secondary'}
                fs-6">
                ${conf.status}
            </span>
        </div>
        <div class="d-flex gap-2">
            <c:if test="${conf.status == 'DRAFT' || conf.status == 'REJECTED'}">
                <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/edit"
                   class="btn btn-warning">Edit Conference</a>
            </c:if>
            <c:if test="${conf.status == 'APPROVED'}">
                <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates"
                   class="btn btn-outline-primary">Delegates</a>
                <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/attendance"
                   class="btn btn-success">Attendance</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/organizer/conferences"
               class="btn btn-outline-secondary">Back</a>
        </div>
    </div>

    <!-- Rejection Reason Alert -->
    <c:if test="${conf.status == 'REJECTED' && not empty conf.rejectionReason}">
        <div class="alert alert-danger">
            <strong>Rejection Reason:</strong> ${conf.rejectionReason}
        </div>
    </c:if>

    <c:if test="${conf.status == 'APPROVED' ||
                 conf.status == 'SUBMITTED' ||
                 conf.status == 'DRAFT'}">
        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers"
           class="btn btn-outline-success">
            🎤 Speakers
        </a>
    </c:if>

    <c:if test="${conf.status != 'CANCELLED'}">
        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule"
           class="btn btn-outline-info">
            📅 Schedule
        </a>
    </c:if>

    <%-- Speakers and Schedule buttons --%>

    <c:if test="${conf.status != 'CANCELLED'}">
        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers"
           class="btn btn-outline-success">
            🎤 Speakers
        </a>
        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule"
           class="btn btn-outline-info">
            📅 Schedule
        </a>
    </c:if>
    <c:if test="${conf.status == 'COMPLETED'}">
        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/speakers"
           class="btn btn-outline-secondary btn-sm">
            🎤 View Speakers
        </a>
        <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/schedule"
           class="btn btn-outline-secondary btn-sm">
            📅 View Schedule
        </a>
    </c:if>

    <!-- Stats Cards (only for APPROVED) -->
    <c:if test="${conf.status == 'APPROVED'}">
        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="card text-center p-3 border-primary">
                    <h5>Registered</h5>
                    <h2 class="text-primary">${conf.registeredCount}</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center p-3 border-success">
                    <h5>Attended</h5>
                    <h2 class="text-success">${attendedCount}</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center p-3 border-warning">
                    <h5>Seats Left</h5>
                    <h2 class="text-warning">
                        ${conf.maxDelegates - conf.registeredCount}
                    </h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center p-3 border-info">
                    <h5>Capacity</h5>
                    <h2 class="text-info">${conf.maxDelegates}</h2>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${!conf.free &&
                 (conf.status == 'APPROVED' ||
                  conf.status == 'COMPLETED')}">
        <div class="alert alert-success d-flex
                    justify-content-between align-items-center">
            <span>
                <strong>💰 Your Expected Payout:</strong>
                ₹${organizerPayout}
                <small class="text-muted ms-2">
                    (after ₹${baseFee} base +
                    ₹${perDelegateFee}/delegate platform fee)
                </small>
            </span>
            <span class="text-muted small">
                ${conf.registeredCount} registrations
                × ₹${conf.delegateFee}
            </span>
        </div>
    </c:if>

    <%-- Completion section --%>
    <c:if test="${conf.status == 'APPROVED' && endDatePassed}">
        <div class="alert alert-warning d-flex
                    justify-content-between align-items-center">
            <span>
                <strong>Conference ended.</strong>
                Mark it as completed to notify delegates
                and unlock certificates.
            </span>
            <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/complete"
                  method="post" class="ms-3">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
                <button class="btn btn-warning btn-sm fw-bold">
                    Mark as Completed
                </button>
            </form>
        </div>
    </c:if>

    <c:if test="${conf.status == 'COMPLETED'}">
        <div class="alert alert-success">
            ✅ This conference is <strong>COMPLETED</strong>.
            Delegates can download certificates and
            submit feedback.
        </div>
    </c:if>

    <%-- Cancel section — only for APPROVED or SUBMITTED --%>
    <c:if test="${conf.status == 'APPROVED' ||
                 conf.status == 'SUBMITTED'}">
        <div class="alert alert-danger d-flex
                    justify-content-between align-items-center mt-3">
            <span>
                <strong>Cancel this conference?</strong>
                This will notify all registered delegates
                and cancel their registrations.
            </span>
            <button class="btn btn-danger btn-sm ms-3"
                    data-bs-toggle="modal"
                    data-bs-target="#cancelModal">
                Cancel Conference
            </button>
        </div>

        <%-- Cancel Modal --%>
        <div class="modal fade" id="cancelModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">
                            Cancel Conference
                        </h5>
                    </div>
                    <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/cancel"
                          method="post">
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>
                        <div class="modal-body">
                            <div class="alert alert-warning">
                                <strong>⚠ Warning:</strong>
                                This action cannot be undone.
                                All
                                <strong>${conf.registeredCount}</strong>
                                registered delegate(s) will be
                                notified immediately.
                            </div>
                            <label class="form-label fw-semibold">
                                Reason for cancellation *
                            </label>
                            <textarea name="reason"
                                      class="form-control"
                                      rows="3"
                                      placeholder="e.g. Venue unavailable, speaker cancelled..."
                                      required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button"
                                    class="btn btn-secondary"
                                    data-bs-dismiss="modal">
                                Keep Conference
                            </button>
                            <button type="submit"
                                    class="btn btn-danger">
                                Yes, Cancel Conference
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <%-- Cancelled status display --%>
    <c:if test="${conf.status == 'CANCELLED'}">
        <div class="alert alert-danger mt-3">
            ❌ This conference has been
            <strong>CANCELLED</strong>.
            All delegate registrations were cancelled
            and delegates were notified.
        </div>
    </c:if>

    <!-- Conference Details -->
    <div class="card mb-3">
        <div class="card-header fw-bold bg-success text-white">
            Conference Details
        </div>
        <div class="card-body">
            <p class="text-muted">${conf.description}</p>
            <div class="row">
                <div class="col-md-4">
                    <strong>Type:</strong> ${conf.conferenceType}
                </div>
                <div class="col-md-4">
                    <strong>Mode:</strong> ${conf.mode}
                </div>
                <div class="col-md-4">
                    <strong>Fee:</strong>
                    <c:choose>
                        <c:when test="${conf.free}">
                            <span class="badge bg-success">Free</span>
                        </c:when>
                        <c:otherwise>₹${conf.delegateFee}</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4">
                    <strong>Start:</strong>
                    ${fn:substringBefore(conf.startDate.toString(),'T')}
                </div>
                <div class="col-md-4">
                    <strong>End:</strong>
                    ${fn:substringBefore(conf.endDate.toString(),'T')}
                </div>
                <div class="col-md-4">
                    <strong>Reg. Deadline:</strong>
                    ${fn:substringBefore(conf.registrationDeadline.toString(),'T')}
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-6">
                    <strong>Target Audience:</strong> ${conf.targetAudience}
                </div>
                <div class="col-md-6">
                    <strong>Target Domains:</strong> ${conf.targetDomains}
                </div>
            </div>
        </div>
    </div>

    <!-- Venue -->
    <div class="card mb-3">
        <div class="card-header fw-bold">Venue / Online Info</div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <strong>Venue:</strong> ${conf.venueName}
                </div>
                <div class="col-md-6">
                    <strong>Address:</strong> ${conf.venueAddress}
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4">
                    <strong>City:</strong> ${conf.city}
                </div>
                <div class="col-md-4">
                    <strong>State:</strong> ${conf.state}
                </div>
            </div>
            <c:if test="${not empty conf.streamingLink}">
                <div class="mt-2">
                    <strong>Streaming Link:</strong>
                    <a href="${conf.streamingLink}" target="_blank">
                        ${conf.streamingLink}
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Features -->
    <div class="card mb-4">
        <div class="card-header fw-bold">Features</div>
        <div class="card-body">
            <span class="badge ${conf.certificateEnabled ?
                'bg-success' : 'bg-secondary'} me-2">
                Certificate: ${conf.certificateEnabled ? 'Yes' : 'No'}
            </span>
            <span class="badge ${conf.qrCheckinEnabled ?
                'bg-success' : 'bg-secondary'} me-2">
                QR Check-in: ${conf.qrCheckinEnabled ? 'Yes' : 'No'}
            </span>
            <span class="badge ${conf.bulkUploadAllowed ?
                'bg-success' : 'bg-secondary'}">
                Bulk Upload: ${conf.bulkUploadAllowed ? 'Yes' : 'No'}
            </span>
        </div>
    </div>

    <%-- Feedback Section for Organizer --%>
    <div class="card mb-4">
        <div class="card-header fw-bold d-flex justify-content-between">
            <span>Delegate Feedback</span>
            <span class="text-muted">
                ${feedbackCount} review<c:if
                    test="${feedbackCount != 1}">s</c:if>
                <c:if test="${feedbackCount > 0}">
                    &nbsp;•&nbsp;
                    Avg: <span style="color:#ffc107;">★</span>
                    <fmt:formatNumber value="${avgRating}"
                                      maxFractionDigits="1"/>
                </c:if>
            </span>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty feedbackList}">
                    <p class="text-muted">
                        No feedback submitted yet.
                    </p>
                </c:when>
                <c:otherwise>
                    <table class="table table-hover table-sm">
                        <thead class="table-light">
                            <tr>
                                <th>Delegate</th>
                                <th>Overall</th>
                                <th>Org.</th>
                                <th>Content</th>
                                <th>Speaker</th>
                                <th>Comments</th>
                                <th>Date</th>
                                <th>Public</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="fb" items="${feedbackList}">
                                <tr>
                                    <td>${fb.user.fullName}</td>
                                    <td>
                                        <span style="color:#ffc107;">
                                            <c:forEach begin="1" end="5"
                                                       var="s">
                                                <c:choose>
                                                    <c:when test="${fb.overallRating >= s}">★</c:when>
                                                    <c:otherwise>☆</c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                    </td>
                                    <td>${fb.organizationRating != null ?
                                        fb.organizationRating : '—'}</td>
                                    <td>${fb.contentRating != null ?
                                        fb.contentRating : '—'}</td>
                                    <td>${fb.speakerRating != null ?
                                        fb.speakerRating : '—'}</td>
                                    <td class="text-muted small">
                                        <c:choose>
                                            <c:when test="${not empty fb.comments}">
                                                ${fn:substring(fb.comments,0,60)}
                                                <c:if test="${fn:length(fb.comments) > 60}">...</c:if>
                                            </c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="small">
                                        ${fn:substringBefore(
                                            fb.submittedAt.toString(),'T')}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fb.publiclyVisible}">
                                                <span class="badge bg-success">Yes</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">No</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>