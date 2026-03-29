<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                ${conf.status == 'APPROVED' ? 'bg-success' :
                  conf.status == 'SUBMITTED' ? 'bg-warning text-dark' :
                  conf.status == 'REJECTED' ? 'bg-danger' : 'bg-secondary'}
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

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>