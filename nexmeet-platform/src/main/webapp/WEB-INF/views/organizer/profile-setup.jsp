<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complete Your Profile - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .setup-card {
            max-width: 600px;
            margin: 50px auto;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.10);
        }
        .brand { color: #667eea; font-weight: 800; font-size: 1.4rem; }
        .btn-success { background: #28a745; border-color: #28a745; }
        .step-badge {
            background: #667eea;
            color: white;
            border-radius: 50%;
            width: 28px; height: 28px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.85rem;
            margin-right: 8px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card setup-card">
        <div class="card-body p-4">

            <div class="text-center mb-4">
                <div class="brand">NexMeet</div>
                <h5 class="mt-2 fw-bold">Complete Your Organizer Profile</h5>
                <p class="text-muted small">
                    This information helps admins verify your account
                    and delegates know who is hosting the conference.
                </p>
            </div>

            <div class="alert alert-info py-2 small">
                <strong>📋 Next steps:</strong> Fill your profile →
                Admin verifies → You can create conferences
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/organizer/profile/setup"
                  method="post">
                <input type="hidden" name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Organization Name *
                    </label>
                    <input type="text" class="form-control"
                           name="organizationName"
                           placeholder="e.g. ABC College of Engineering"
                           required maxlength="200"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Organization Type *
                    </label>
                    <select name="organizationType" class="form-select" required>
                        <option value="">Select type...</option>
                        <option value="College">College / University</option>
                        <option value="Corporate">Corporate / Company</option>
                        <option value="NGO">NGO</option>
                        <option value="Government">Government Body</option>
                        <option value="Individual">Individual</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Website URL
                        <span class="text-muted fw-normal">(optional)</span>
                    </label>
                    <input type="url" class="form-control"
                           name="websiteUrl"
                           placeholder="https://www.yourorg.com"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Address</label>
                    <input type="text" class="form-control"
                           name="address"
                           placeholder="Street address"/>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-5">
                        <label class="form-label fw-semibold">City *</label>
                        <input type="text" class="form-control"
                               name="city" placeholder="Bengaluru" required/>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">State *</label>
                        <input type="text" class="form-control"
                               name="state" placeholder="Karnataka" required/>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Pincode</label>
                        <input type="text" class="form-control"
                               name="pincode" placeholder="560001"
                               maxlength="10"/>
                    </div>
                </div>

                <button type="submit"
                        class="btn btn-success w-100 py-2 fw-semibold mt-2">
                    Save Profile & Continue →
                </button>
            </form>

        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>