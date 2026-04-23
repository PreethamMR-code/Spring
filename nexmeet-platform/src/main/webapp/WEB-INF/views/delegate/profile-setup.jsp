<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complete Your Profile - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="card mx-auto" style="max-width:520px;
         border:none; border-radius:12px;
         box-shadow:0 4px 20px rgba(0,0,0,0.10);">
        <div class="card-body p-4">
            <div class="text-center mb-4">
                <div style="font-size:2.5rem">🎓</div>
                <h4 class="fw-bold mt-2">
                    Complete Your Profile
                </h4>
                <p class="text-muted small">
                    Help organizers know more about you
                </p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/delegate/profile/setup"
                  method="post">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Organization / Institution
                    </label>
                    <input type="text" name="organization"
                           class="form-control"
                           placeholder="e.g. IIT Bangalore, Infosys Ltd"
                           value="${dto.organization}"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Designation / Role
                    </label>
                    <input type="text" name="designation"
                           class="form-control"
                           placeholder="e.g. Software Engineer, PhD Student"
                           value="${dto.designation}"/>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">
                            City
                        </label>
                        <input type="text" name="city"
                               class="form-control"
                               placeholder="Bengaluru"
                               value="${dto.city}"/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">
                            State
                        </label>
                        <input type="text" name="state"
                               class="form-control"
                               placeholder="Karnataka"
                               value="${dto.state}"/>
                    </div>
                </div>

                <div class="d-flex gap-3 mt-2">
                    <button type="submit"
                            class="btn btn-primary px-5
                                   fw-semibold">
                        Save Profile
                    </button>
                    <a href="${pageContext.request.contextPath}/delegate/dashboard"
                       class="btn btn-outline-secondary">
                        Skip for now
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