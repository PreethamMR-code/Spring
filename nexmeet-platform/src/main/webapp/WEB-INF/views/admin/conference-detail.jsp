<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>${conf.title} - Admin Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-danger">Admin Review</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary">← Back</a>
    </div>

    <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <!-- Conference Info -->
    <div class="card mb-3">
        <div class="card-header fw-bold bg-danger text-white">Conference Details</div>
        <div class="card-body">
            <h4>${conf.title}</h4>
            <p class="text-muted">${conf.description}</p>
            <div class="row">
                <div class="col-md-4"><strong>Type:</strong> ${conf.conferenceType}</div>
                <div class="col-md-4"><strong>Mode:</strong> ${conf.mode}</div>
                <div class="col-md-4"><strong>Status:</strong>
                    <span class="badge bg-warning">${conf.status}</span>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4"><strong>Start:</strong> ${fn:substringBefore(conf.startDate.toString(),'T')}</div>
                <div class="col-md-4"><strong>End:</strong> ${fn:substringBefore(conf.endDate.toString(),'T')}</div>
                <div class="col-md-4"><strong>Reg. Deadline:</strong> ${fn:substringBefore(conf.registrationDeadline.toString(),'T')}</div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4"><strong>Target Audience:</strong> ${conf.targetAudience}</div>
                <div class="col-md-4"><strong>Target Domains:</strong> ${conf.targetDomains}</div>
            </div>
        </div>
    </div>

    <!-- Venue -->
    <div class="card mb-3">
        <div class="card-header fw-bold">Venue / Online Info</div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6"><strong>Venue:</strong> ${conf.venueName}</div>
                <div class="col-md-6"><strong>Address:</strong> ${conf.venueAddress}</div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4"><strong>City:</strong> ${conf.city}</div>
                <div class="col-md-4"><strong>State:</strong> ${conf.state}</div>
            </div>
            <c:if test="${not empty conf.streamingLink}">
                <div class="mt-2"><strong>Streaming Link:</strong>
                    <a href="${conf.streamingLink}" target="_blank">${conf.streamingLink}</a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Capacity & Pricing -->
    <div class="card mb-3">
        <div class="card-header fw-bold">Capacity & Pricing</div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4"><strong>Max Delegates:</strong> ${conf.maxDelegates}</div>
                <div class="col-md-4"><strong>Free Event:</strong> ${conf.free ? 'Yes' : 'No'}</div>
                <div class="col-md-4"><strong>Delegate Fee:</strong>
                    <c:choose>
                        <c:when test="${conf.free}">Free</c:when>
                        <c:otherwise>₹${conf.delegateFee} (collected at venue)</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Features -->
    <div class="card mb-3">
        <div class="card-header fw-bold">Features</div>
        <div class="card-body">
            <span class="badge ${conf.certificateEnabled ? 'bg-success' : 'bg-secondary'} me-2">
                Certificate: ${conf.certificateEnabled ? 'Yes' : 'No'}
            </span>
            <span class="badge ${conf.qrCheckinEnabled ? 'bg-success' : 'bg-secondary'} me-2">
                QR Check-in: ${conf.qrCheckinEnabled ? 'Yes' : 'No'}
            </span>
            <span class="badge ${conf.bulkUploadAllowed ? 'bg-success' : 'bg-secondary'}">
                Bulk Upload: ${conf.bulkUploadAllowed ? 'Yes' : 'No'}
            </span>
        </div>
    </div>

    <!-- Organizer Info -->
    <div class="card mb-4">
        <div class="card-header fw-bold">Organizer Information</div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4"><strong>Name:</strong> ${conf.organizer.user.fullName}</div>
                <div class="col-md-4"><strong>Email:</strong> ${conf.organizer.user.email}</div>
                <div class="col-md-4"><strong>Phone:</strong> ${conf.organizer.user.phone}</div>
            </div>
            <div class="row mt-2">
                <div class="col-md-4"><strong>Organization:</strong> ${conf.organizer.organizationName}</div>
                <div class="col-md-4"><strong>Org Type:</strong> ${conf.organizer.organizationType}</div>
                <div class="col-md-4"><strong>Website:</strong>
                    <c:if test="${not empty conf.organizer.websiteUrl}">
                        <a href="${conf.organizer.websiteUrl}" target="_blank">${conf.organizer.websiteUrl}</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <c:if test="${conf.status == 'SUBMITTED'}">
        <div class="d-flex gap-3">
            <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/approve" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button class="btn btn-success btn-lg">✅ Approve Conference</button>
            </form>

            <button class="btn btn-danger btn-lg" data-bs-toggle="modal" data-bs-target="#rejectModal">
                ❌ Reject Conference
            </button>
        </div>

        <!-- Reject Modal -->
        <div class="modal fade" id="rejectModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Reject Conference</h5>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/conference/${conf.id}/reject" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="modal-body">
                            <label class="form-label">Reason for rejection</label>
                            <textarea name="reason" class="form-control" rows="4" required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Confirm Reject</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${conf.status != 'SUBMITTED'}">
        <div class="alert alert-info mt-3">
            This conference has already been <strong>${conf.status}</strong>.
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>