<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .profile-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }
        .avatar-circle {
            width: 80px; height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .section-title {
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #6c757d;
            margin-bottom: 1rem;
        }
        .nav-pills .nav-link.active {
            background: #667eea;
        }
        .nav-pills .nav-link {
            color: #495057;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4" style="max-width: 860px;">

    <!-- Profile Header -->
    <div class="card profile-card p-4 mb-4">
        <div class="d-flex align-items-center gap-4">
            <div class="avatar-circle flex-shrink-0">
                ${fn:substring(user.fullName, 0, 1)}
            </div>
            <div>
                <h4 class="fw-bold mb-1">${user.fullName}</h4>
                <p class="text-muted mb-1">${user.email}</p>
                <div>
                    <c:forEach var="role" items="${user.roles}">
                        <span class="badge
                            ${role.name == 'SUPER_ADMIN' ? 'bg-danger' :
                              role.name == 'ORGANIZER'   ? 'bg-success' :
                              role.name == 'DELEGATE'    ? 'bg-primary' :
                              'bg-warning text-dark'}">
                            ${fn:replace(role.name, '_', ' ')}
                        </span>
                    </c:forEach>
                </div>
            </div>
            <div class="ms-auto text-end text-muted small">
                <div>Member since</div>
                <div class="fw-semibold">
                    ${fn:substringBefore(user.createdAt.toString(), 'T')}
                </div>
            </div>
        </div>
    </div>

    <!-- Tab Navigation -->
    <ul class="nav nav-pills mb-4 gap-2" id="profileTabs">
        <li class="nav-item">
            <a class="nav-link active" id="tab-basic"
               href="#" onclick="showTab('basic')">
                👤 Basic Info
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="tab-password"
               href="#" onclick="showTab('password')">
                🔒 Change Password
            </a>
        </li>
        <sec:authorize access="hasRole('ROLE_ORGANIZER')">
            <li class="nav-item">
                <a class="nav-link" id="tab-org"
                   href="#" onclick="showTab('org')">
                    🏢 Organization
                </a>
            </li>
        </sec:authorize>
    </ul>

    <!-- Tab: Basic Info -->
    <div id="section-basic">

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="card profile-card p-4">
            <div class="section-title">Personal Information</div>
            <form action="${pageContext.request.contextPath}/profile"
                  method="post">
                <input type="hidden" name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Full Name *</label>
                    <input type="text" class="form-control"
                           name="fullName" value="${dto.fullName}"
                           required/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Email Address
                        <span class="badge bg-secondary ms-1 fw-normal"
                              style="font-size:0.7rem">
                            Cannot be changed
                        </span>
                    </label>
                    <input type="email" class="form-control"
                           value="${user.email}" disabled/>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">
                        Phone Number
                        <span class="text-muted fw-normal">(optional)</span>
                    </label>
                    <input type="tel" class="form-control"
                           name="phone" value="${dto.phone}"
                           placeholder="+91 98765 43210"/>
                </div>

                <button type="submit"
                        class="btn btn-primary px-4 fw-semibold">
                    Save Changes
                </button>
            </form>
        </div>
    </div>

    <!-- Tab: Change Password -->
    <div id="section-password" style="display:none;">

        <c:if test="${not empty pwSuccess}">
            <div class="alert alert-success">${pwSuccess}</div>
        </c:if>
        <c:if test="${not empty pwError}">
            <div class="alert alert-danger">${pwError}</div>
        </c:if>

        <div class="card profile-card p-4">
            <div class="section-title">Change Password</div>
            <form action="${pageContext.request.contextPath}/profile/password"
                  method="post" style="max-width: 420px;">
                <input type="hidden" name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Current Password
                    </label>
                    <input type="password" class="form-control"
                           name="currentPassword"
                           placeholder="Enter current password"
                           required/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        New Password
                    </label>
                    <input type="password" class="form-control"
                           name="newPassword"
                           placeholder="At least 6 characters"
                           required/>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">
                        Confirm New Password
                    </label>
                    <input type="password" class="form-control"
                           name="confirmNewPassword"
                           placeholder="Repeat new password"
                           required/>
                </div>

                <button type="submit"
                        class="btn btn-warning px-4 fw-semibold">
                    Change Password
                </button>
            </form>
        </div>
    </div>

    <!-- Tab: Organization (Organizer only) -->
    <sec:authorize access="hasRole('ROLE_ORGANIZER')">
        <div id="section-org" style="display:none;">

            <c:if test="${not empty orgSuccess}">
                <div class="alert alert-success">${orgSuccess}</div>
            </c:if>
            <c:if test="${not empty orgError}">
                <div class="alert alert-danger">${orgError}</div>
            </c:if>

            <!-- Verification Status Banner -->
            <c:if test="${not empty organizer}">
                <div class="alert
                    ${organizer.verificationStatus == 'APPROVED' ?
                      'alert-success' :
                      organizer.verificationStatus == 'REJECTED' ?
                      'alert-danger' : 'alert-warning'} py-2 mb-3">
                    <strong>Verification Status:</strong>
                    ${organizer.verificationStatus}
                    <c:if test="${organizer.verificationStatus == 'PENDING'}">
                        — Admin will review your profile soon.
                    </c:if>
                    <c:if test="${organizer.verificationStatus == 'REJECTED'
                                 && not empty organizer.rejectionReason}">
                        — Reason: ${organizer.rejectionReason}
                    </c:if>
                </div>
            </c:if>

            <div class="card profile-card p-4">
                <div class="section-title">Organization Details</div>
                <form action="${pageContext.request.contextPath}/profile/organizer"
                      method="post">
                    <input type="hidden" name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">
                            Organization Name *
                        </label>
                        <input type="text" class="form-control"
                               name="organizationName"
                               value="${dto.organizationName}"
                               required maxlength="200"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">
                            Organization Type
                        </label>
                        <select name="organizationType"
                                class="form-select">
                            <option value="">Select type...</option>
                            <option value="College"
                                ${dto.organizationType == 'College' ?
                                  'selected' : ''}>
                                College / University</option>
                            <option value="Corporate"
                                ${dto.organizationType == 'Corporate' ?
                                  'selected' : ''}>
                                Corporate / Company</option>
                            <option value="NGO"
                                ${dto.organizationType == 'NGO' ?
                                  'selected' : ''}>NGO</option>
                            <option value="Government"
                                ${dto.organizationType == 'Government' ?
                                  'selected' : ''}>
                                Government Body</option>
                            <option value="Individual"
                                ${dto.organizationType == 'Individual' ?
                                  'selected' : ''}>
                                Individual</option>
                            <option value="Other"
                                ${dto.organizationType == 'Other' ?
                                  'selected' : ''}>Other</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">
                            Website URL
                        </label>
                        <input type="url" class="form-control"
                               name="websiteUrl"
                               value="${dto.websiteUrl}"
                               placeholder="https://www.yourorg.com"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">
                            Address
                        </label>
                        <input type="text" class="form-control"
                               name="address"
                               value="${dto.address}"/>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-5">
                            <label class="form-label fw-semibold">
                                City
                            </label>
                            <input type="text" class="form-control"
                                   name="city"
                                   value="${dto.city}"/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">
                                State
                            </label>
                            <input type="text" class="form-control"
                                   name="state"
                                   value="${dto.state}"/>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">
                                Pincode
                            </label>
                            <input type="text" class="form-control"
                                   name="pincode"
                                   value="${dto.pincode}"
                                   maxlength="10"/>
                        </div>
                    </div>

                    <button type="submit"
                            class="btn btn-success px-4 fw-semibold">
                        Update Organization
                    </button>
                </form>
            </div>
        </div>
    </sec:authorize>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>
    function showTab(tab) {
        // Hide all sections
        ['basic', 'password', 'org'].forEach(function(t) {
            var el = document.getElementById('section-' + t);
            if (el) el.style.display = 'none';
            var tabEl = document.getElementById('tab-' + t);
            if (tabEl) tabEl.classList.remove('active');
        });
        // Show selected
        var section = document.getElementById('section-' + tab);
        if (section) section.style.display = 'block';
        var tabBtn = document.getElementById('tab-' + tab);
        if (tabBtn) tabBtn.classList.add('active');
    }

    // Auto-open correct tab if flash message present
    window.addEventListener('load', function() {
        var hasPwMsg = ${not empty pwSuccess || not empty pwError};
        var hasOrgMsg = ${not empty orgSuccess || not empty orgError};
        if (hasPwMsg) showTab('password');
        else if (hasOrgMsg) showTab('org');
    });
</script>
</body>
</html>