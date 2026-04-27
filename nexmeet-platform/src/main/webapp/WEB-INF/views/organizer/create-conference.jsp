<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Conference - NexMeet</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-success">Create New Conference</h2>
        <a href="${pageContext.request.contextPath}/organizer/dashboard" class="btn btn-outline-secondary">Back to Dashboard</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/organizer/conference/create" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <!-- Basic Info -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Basic Information</div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label">Conference Title *</label>
                    <input type="text" name="title" class="form-control" required maxlength="300"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="4"></textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Conference Type *</label>
                       <select name="conferenceType" class="form-select" required>
                           <option value="">-- Select Conference Type --</option>

                           <optgroup label="📚 Academic &amp; Research">
                               <option value="STUDENT">Student Academic Conference</option>
                               <option value="ACADEMIC">Academic Conference</option>
                               <option value="RESEARCH">Research Symposium</option>
                               <option value="EDUCATION">Education Conference</option>
                           </optgroup>

                           <optgroup label="💻 Technical &amp; IT">
                               <option value="TECHNICAL">Technical Conference</option>
                               <option value="AI_ML">AI / Machine Learning</option>
                               <option value="DATA_SCIENCE">Data Science</option>
                               <option value="CYBERSECURITY">Cybersecurity</option>
                               <option value="CLOUD_COMPUTING">Cloud Computing</option>
                           </optgroup>

                           <optgroup label="💼 Business &amp; Management">
                               <option value="CORPORATE">Corporate Conference</option>
                               <option value="BUSINESS">Business Conference</option>
                               <option value="STARTUP">Startup / Entrepreneurship</option>
                               <option value="FINANCE">Finance &amp; Investment</option>
                               <option value="MARKETING">Marketing Conference</option>
                               <option value="LEADERSHIP">Leadership Summit</option>
                           </optgroup>

                           <optgroup label="🏥 Industry Specific">
                               <option value="HEALTHCARE">Healthcare / Medical</option>
                               <option value="ENGINEERING">Engineering Conference</option>
                               <option value="LEGAL">Legal Conference</option>
                               <option value="ENVIRONMENTAL">Environmental / Sustainability</option>
                           </optgroup>

                           <optgroup label="🌐 Civic &amp; Social">
                               <option value="NGO">NGO / Social Sector</option>
                               <option value="GOVERNMENT">Government / Public Sector</option>
                           </optgroup>

                           <optgroup label="🎤 Event Formats">
                               <option value="WORKSHOP">Workshop</option>
                               <option value="SEMINAR">Seminar</option>
                               <option value="WEBINAR">Webinar</option>
                               <option value="PANEL">Panel Discussion</option>
                               <option value="BOOTCAMP">Bootcamp</option>
                               <option value="TRAINING">Training Program</option>
                           </optgroup>

                           <optgroup label="🌟 General">
                               <option value="INNOVATION">Innovation Conference</option>
                               <option value="GENERAL">General / Multi-domain</option>
                           </optgroup>
                       </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Mode *</label>
                        <select name="mode" class="form-select" required>
                            <option value="">Select Mode</option>
                            <option value="ONLINE">Online</option>
                            <option value="OFFLINE">Offline</option>
                            <option value="HYBRID">Hybrid</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Target Audience</label>
                        <input type="text" name="targetAudience" class="form-control" maxlength="500"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Target Domains</label>
                        <input type="text" name="targetDomains" class="form-control" maxlength="500"/>
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
                        <input type="datetime-local" name="startDate" class="form-control" required/>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">End Date & Time *</label>
                        <input type="datetime-local" name="endDate" class="form-control" required/>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Registration Deadline *</label>
                        <input type="datetime-local" name="registrationDeadline" class="form-control" required/>
                    </div>
                </div>
            </div>
        </div>

        <!-- Venue -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Venue (for Offline/Hybrid)</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Venue Name</label>
                        <input type="text" name="venueName" class="form-control" maxlength="300"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Venue Address</label>
                        <input type="text" name="venueAddress" class="form-control" maxlength="500"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">City</label>
                        <input type="text" name="city" class="form-control" maxlength="100"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">State</label>
                        <input type="text" name="state" class="form-control" maxlength="100"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Streaming Link (for Online/Hybrid)</label>
                        <input type="url" name="streamingLink" class="form-control" maxlength="500"/>
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
                        <input type="number" name="maxDelegates" class="form-control" value="100" min="1" required/>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Is Free?</label>
                        <select name="free" class="form-select">
                            <option value="true">Yes - Free</option>
                            <option value="false">No - Paid</option>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Delegate Fee (₹)</label>
                        <input type="number" name="delegateFee" class="form-control" value="0" min="0" step="0.01"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features -->
        <div class="card mb-4">
            <div class="card-header fw-bold">Features</div>
            <div class="card-body">
                <div class="form-check form-check-inline">
                    <input type="checkbox" name="certificateEnabled" value="true" class="form-check-input" id="cert"/>
                    <label class="form-check-label" for="cert">Certificate Generation</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="checkbox" name="qrCheckinEnabled" value="true" class="form-check-input" id="qr"/>
                    <label class="form-check-label" for="qr">QR Check-in</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="checkbox" name="bulkUploadAllowed" value="true" class="form-check-input" id="bulk" checked/>
                    <label class="form-check-label" for="bulk">Allow Bulk Upload</label>
                </div>
            </div>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" name="action" value="DRAFT" class="btn btn-outline-secondary btn-lg">
                Save as Draft
            </button>
            <button type="submit" name="action" value="SUBMIT" class="btn btn-success btn-lg">
                Submit for Approval
            </button>
        </div>
    </form>
</div>
</body>
</html>