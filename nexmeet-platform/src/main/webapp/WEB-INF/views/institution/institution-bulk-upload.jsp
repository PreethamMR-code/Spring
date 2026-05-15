<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bulk Register Students - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4"
     style="max-width:700px">

    <!-- Conference Info -->
    <div class="card mb-3 border-0 shadow-sm">
        <div class="card-body">
            <div class="text-muted small mb-1">
                Bulk Registration for
            </div>
            <h4 class="fw-bold mb-0">
                ${conference.title}
            </h4>
            <div class="small text-muted mt-1">
                ${fn:substringBefore(
                    conference.startDate.toString(), 'T')}
                ·
                ${conference.venueName}, ${conference.city}
                ·
                ${conference.maxDelegates
                    - conference.registeredCount}
                seats remaining
            </div>
        </div>
    </div>

    <!-- Institution Info -->
    <div class="card mb-3 border-0 shadow-sm">
        <div class="card-body d-flex
                    align-items-center gap-3">
            <div style="font-size:2rem">🏫</div>
            <div>
                <div class="fw-bold">
                    ${instAdmin.institution.name}
                </div>
                <div class="small text-muted">
                    Uploading as:
                    ${instAdmin.user.fullName}
                    — ${instAdmin.jobTitle},
                    ${instAdmin.department}
                </div>
            </div>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">
            ✅ ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ❌ ${error}
        </div>
    </c:if>

    <!-- Upload Card -->
    <div class="card border-0 shadow-sm">
        <div class="card-header fw-bold bg-white
                    border-bottom">
            📋 Upload Student List
        </div>
        <div class="card-body">

            <!-- Format Guide -->
            <div class="alert alert-info
                        d-flex gap-3 align-items-start">
                <div style="font-size:1.5rem">💡</div>
                <div>
                    <strong>CSV/Excel Format</strong><br/>
                    First row must be headers.
                    Required column: <code>email</code>
                    <br/>
                    Optional columns:
                    <code>full_name</code>,
                    <code>phone</code>
                    <br/><br/>
                    <strong>Example:</strong><br/>
                    <code>
                        full_name,email,phone<br/>
                        Ravi Kumar,ravi@bmsce.ac.in,9876543210<br/>
                        Priya Sharma,priya@bmsce.ac.in,
                    </code>
                    <br/><br/>
                    New students get an account created
                    with a temporary password.
                    They receive a welcome email.
                </div>
            </div>

            <!-- Upload Form -->
            <form action="${pageContext.request.contextPath}/conference/${conference.id}/institution-bulk-upload?${_csrf.parameterName}=${_csrf.token}"
                  method="post"
                  enctype="multipart/form-data">

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Choose File (CSV or Excel)
                    </label>
                    <input type="file"
                           name="file"
                           class="form-control"
                           accept=".csv,.xlsx,.xls"
                           required/>
                    <div class="form-text">
                        Max file size: 5MB.
                        Supported: .csv, .xlsx, .xls
                    </div>
                </div>

                <button type="submit"
                        class="btn btn-primary w-100 py-2
                               fw-semibold">
                    📤 Upload & Register Students
                </button>
            </form>

            <!-- Download Template -->
            <div class="mt-3 text-center">
                <a href="${pageContext.request.contextPath}/conference/${conference.id}/institution-bulk-upload/template"
                   class="btn btn-outline-secondary btn-sm">
                    ⬇ Download CSV Template
                </a>
            </div>
        </div>
    </div>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/conference/${conference.id}"
           class="btn btn-outline-secondary btn-sm">
            ← Back to Conference
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>