<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Organizer Profile – NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .edit-card {
            max-width: 640px;
            margin: 40px auto;
            border: none;
            border-radius: 14px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.09);
        }
        .brand {
            color: #667eea;
            font-weight: 800;
            font-size: 1.3rem;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container">
    <div class="card edit-card">
        <div class="card-body p-4">

            <div class="text-center mb-4">
                <div class="brand">NexMeet</div>
                <h5 class="mt-2 fw-bold">
                    Edit Organizer Profile
                </h5>
                <p class="text-muted small">
                    Update your organization details.
                    Your verification status is not affected.
                </p>
            </div>

            <%-- Verification status banner --%>
            <c:choose>
                <c:when test="${organizer.verificationStatus
                               == 'APPROVED'}">
                    <div class="alert alert-success
                                py-2 small mb-3">
                        ✅ Your account is verified.
                        Profile changes take effect immediately.
                    </div>
                </c:when>
                <c:when test="${organizer.verificationStatus
                               == 'PENDING'}">
                    <div class="alert alert-warning
                                py-2 small mb-3">
                        ⏳ Your account is pending verification.
                        Admin will review your profile.
                    </div>
                </c:when>
            </c:choose>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/organizer/profile/edit"
                  method="post">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Organization Name *
                    </label>
                    <input type="text"
                           class="form-control"
                           name="organizationName"
                           value="${dto.organizationName}"
                           required
                           maxlength="200"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Organization Type *
                    </label>
                    <select name="organizationType"
                            class="form-select"
                            required>
                        <option value="">Select type...</option>
                        <option value="College"
                            ${dto.organizationType == 'College'
                                ? 'selected' : ''}>
                            College / University
                        </option>
                        <option value="Corporate"
                            ${dto.organizationType == 'Corporate'
                                ? 'selected' : ''}>
                            Corporate / Company
                        </option>
                        <option value="NGO"
                            ${dto.organizationType == 'NGO'
                                ? 'selected' : ''}>
                            NGO
                        </option>
                        <option value="Government"
                            ${dto.organizationType == 'Government'
                                ? 'selected' : ''}>
                            Government Body
                        </option>
                        <option value="Individual"
                            ${dto.organizationType == 'Individual'
                                ? 'selected' : ''}>
                            Individual
                        </option>
                        <option value="Other"
                            ${dto.organizationType == 'Other'
                                ? 'selected' : ''}>
                            Other
                        </option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Website URL
                        <span class="text-muted fw-normal small">
                            (optional)
                        </span>
                    </label>
                    <input type="url"
                           class="form-control"
                           name="websiteUrl"
                           value="${dto.websiteUrl}"
                           placeholder="https://www.yourorg.com"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Address
                    </label>
                    <input type="text"
                           class="form-control"
                           name="address"
                           value="${dto.address}"
                           placeholder="Street address"/>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-5">
                        <label class="form-label fw-semibold">
                            City *
                        </label>
                        <input type="text"
                               class="form-control"
                               name="city"
                               value="${dto.city}"
                               required/>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            State *
                        </label>
                        <input type="text"
                               class="form-control"
                               name="state"
                               value="${dto.state}"
                               required/>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">
                            Pincode
                        </label>
                        <input type="text"
                               class="form-control"
                               name="pincode"
                               value="${dto.pincode}"
                               maxlength="10"/>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit"
                            class="btn btn-success
                                   flex-grow-1 py-2 fw-semibold">
                        Save Changes →
                    </button>
                    <a href="${pageContext.request.contextPath}/organizer/dashboard"
                       class="btn btn-outline-secondary py-2">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>