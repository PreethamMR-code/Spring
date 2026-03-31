<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Conference - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="text-success">Edit Conference</h2>
            <c:if test="${currentStatus == 'REJECTED'}">
                <div class="alert alert-danger py-2 mt-2">
                    This conference was <strong>REJECTED</strong>.
                    Fix the issues and resubmit.
                </div>
            </c:if>
        </div>
        <a href="${pageContext.request.contextPath}/organizer/conferences"
           class="btn btn-outline-secondary">Back</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/organizer/conference/${confId}/edit"
          method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <!-- Basic Info -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Basic Information</div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label">Conference Title *</label>
                    <input type="text" name="title" class="form-control"
                           value="${dto.title}" required maxlength="300"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control"
                              rows="4">${dto.description}</textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Conference Type *</label>
                        <select name="conferenceType" class="form-select" required>
                            <option value="STUDENT"
                                ${dto.conferenceType == 'STUDENT' ? 'selected' : ''}>
                                Student</option>
                            <option value="CORPORATE"
                                ${dto.conferenceType == 'CORPORATE' ? 'selected' : ''}>
                                Corporate</option>
                            <option value="RESEARCH"
                                ${dto.conferenceType == 'RESEARCH' ? 'selected' : ''}>
                                Research</option>
                            <option value="NGO"
                                ${dto.conferenceType == 'NGO' ? 'selected' : ''}>
                                NGO</option>
                            <option value="GOVERNMENT"
                                ${dto.conferenceType == 'GOVERNMENT' ? 'selected' : ''}>
                                Government</option>
                            <option value="GENERAL"
                                ${dto.conferenceType == 'GENERAL' ? 'selected' : ''}>
                                General</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Mode *</label>
                        <select name="mode" class="form-select" required>
                            <option value="ONLINE"
                                ${dto.mode == 'ONLINE' ? 'selected' : ''}>Online</option>
                            <option value="OFFLINE"
                                ${dto.mode == 'OFFLINE' ? 'selected' : ''}>Offline</option>
                            <option value="HYBRID"
                                ${dto.mode == 'HYBRID' ? 'selected' : ''}>Hybrid</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Target Audience</label>
                        <input type="text" name="targetAudience" class="form-control"
                               value="${dto.targetAudience}"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Target Domains</label>
                        <input type="text" name="targetDomains" class="form-control"
                               value="${dto.targetDomains}"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dates -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Dates</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Start Date & Time *</label>
                        <input type="datetime-local" name="startDate"
                               class="form-control" required
                               value="${dto.startDate}"/>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">End Date & Time *</label>
                        <input type="datetime-local" name="endDate"
                               class="form-control" required
                               value="${dto.endDate}"/>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Registration Deadline *</label>
                        <input type="datetime-local" name="registrationDeadline"
                               class="form-control" required
                               value="${dto.registrationDeadline}"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- Venue -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Venue</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Venue Name</label>
                        <input type="text" name="venueName" class="form-control"
                               value="${dto.venueName}"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Venue Address</label>
                        <input type="text" name="venueAddress" class="form-control"
                               value="${dto.venueAddress}"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">City</label>
                        <input type="text" name="city" class="form-control"
                               value="${dto.city}"/>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">State</label>
                        <input type="text" name="state" class="form-control"
                               value="${dto.state}"/>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Streaming Link</label>
                        <input type="url" name="streamingLink" class="form-control"
                               value="${dto.streamingLink}"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- Capacity & Pricing -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Capacity & Pricing</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Max Delegates *</label>
                        <input type="number" name="maxDelegates" class="form-control"
                               value="${dto.maxDelegates}" min="1" required/>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Is Free?</label>
                        <select name="free" class="form-select">
                            <option value="true" ${dto.free ? 'selected' : ''}>
                                Yes - Free</option>
                            <option value="false" ${!dto.free ? 'selected' : ''}>
                                No - Paid</option>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Delegate Fee</label>
                        <input type="number" name="delegateFee" class="form-control"
                               value="${dto.delegateFee}" min="0" step="0.01"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Features</div>
            <div class="card-body">
                <div class="form-check form-check-inline">
                    <input type="checkbox" name="certificateEnabled" value="true"
                           class="form-check-input" id="cert"
                           ${dto.certificateEnabled ? 'checked' : ''}/>
                    <label class="form-check-label" for="cert">
                        Certificate Generation</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="checkbox" name="qrCheckinEnabled" value="true"
                           class="form-check-input" id="qr"
                           ${dto.qrCheckinEnabled ? 'checked' : ''}/>
                    <label class="form-check-label" for="qr">QR Check-in</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="checkbox" name="bulkUploadAllowed" value="true"
                           class="form-check-input" id="bulk"
                           ${dto.bulkUploadAllowed ? 'checked' : ''}/>
                    <label class="form-check-label" for="bulk">
                        Allow Bulk Upload</label>
                </div>
            </div>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" name="action" value="DRAFT"
                    class="btn btn-outline-secondary btn-lg">
                Save as Draft
            </button>
            <button type="submit" name="action" value="SUBMIT"
                    class="btn btn-success btn-lg">
                Submit for Approval
            </button>
        </div>
    </form>
</div>
</body>
</html>