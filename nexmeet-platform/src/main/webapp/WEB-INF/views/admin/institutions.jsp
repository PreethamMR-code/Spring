<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Institutions - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <h2 class="fw-bold mb-0">🏫 Institutions</h2>
        <button class="btn btn-primary"
                data-bs-toggle="modal"
                data-bs-target="#addModal">
            + Add Institution
        </button>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- Pending Institutional Admins -->
    <c:if test="${not empty pendingAdmins}">
    <div class="card mb-4 border-warning">
        <div class="card-header bg-warning text-dark fw-bold">
            ⏳ Pending Institutional Admin Verifications
            (${fn:length(pendingAdmins)})
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Institution</th>
                        <th>Job Title</th>
                        <th>Applied</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ia"
                               items="${pendingAdmins}">
                        <tr>
                            <td>${ia.user.fullName}</td>
                            <td class="small text-muted">
                                ${ia.user.email}
                            </td>
                            <td>
                                <strong>
                                    ${ia.institution.name}
                                </strong>
                                <span class="badge bg-secondary
                                             ms-1 small">
                                    ${ia.institution.type}
                                </span>
                            </td>
                            <td class="small">
                                ${ia.jobTitle}
                                <c:if test="${not empty ia.department}">
                                    · ${ia.department}
                                </c:if>
                            </td>
                            <td class="small text-muted">
                                ${fn:substringBefore(
                                    ia.createdAt.toString(),
                                    'T')}
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/institutional-admin/${ia.id}/approve"
                                      method="post"
                                      class="d-inline">
                                    <input type="hidden"
                                        name="${_csrf.parameterName}"
                                        value="${_csrf.token}"/>
                                    <button class="btn btn-success btn-sm">
                                        ✓ Approve
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    </c:if>

    <!-- Institutions Table -->
    <div class="card">
        <div class="card-header fw-bold bg-white
                    border-bottom d-flex
                    justify-content-between">
            <span>All Institutions
                (${fn:length(institutions)})</span>
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty institutions}">
                    <p class="text-muted p-4">
                        No institutions added yet.
                        Click "+ Add Institution" to start.
                    </p>
                </c:when>
                <c:otherwise>
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Contact</th>
                                <th>City</th>
                                <th>Domains</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="inst"
                                       items="${institutions}">
                                <tr>
                                    <td>
                                        <strong>
                                            ${inst.name}
                                        </strong>
                                        <c:if test="${not empty inst.website}">
                                            <a href="${inst.website}"
                                               target="_blank"
                                               class="ms-1"
                                               style="font-size:0.75rem">
                                                ↗
                                            </a>
                                        </c:if>
                                    </td>
                                    <td>
                                        <span class="badge bg-primary">
                                            ${inst.type}
                                        </span>
                                    </td>
                                    <td class="small">
                                        <c:if test="${not empty inst.contactPerson}">
                                            ${inst.contactPerson}<br/>
                                        </c:if>
                                        <c:if test="${not empty inst.email}">
                                            <span class="text-muted">
                                                ${inst.email}
                                            </span>
                                        </c:if>
                                    </td>
                                    <td class="small">
                                        ${inst.city}
                                        <c:if test="${not empty inst.state}">
                                            , ${inst.state}
                                        </c:if>
                                    </td>
                                    <td class="small text-muted">
                                        ${inst.domains}
                                    </td>
                                    <td>
                                        <span class="badge ${inst.active ? 'bg-success' : 'bg-secondary'}">
                                            ${inst.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/institution/${inst.id}/toggle"
                                              method="post"
                                              class="d-inline">
                                            <input type="hidden"
                                                name="${_csrf.parameterName}"
                                                value="${_csrf.token}"/>
                                            <button class="btn btn-sm ${inst.active ? 'btn-outline-danger' : 'btn-outline-success'}">
                                                ${inst.active ? 'Deactivate' : 'Activate'}
                                            </button>
                                        </form>
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

<!-- Add Institution Modal -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold">
                    Add Institution
                </h5>
                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/institution/add"
                  method="post">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="form-label fw-semibold">
                                Institution Name *
                            </label>
                            <input type="text"
                                   name="name"
                                   class="form-control"
                                   placeholder="e.g. BMS College of Engineering"
                                   required/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">
                                Type *
                            </label>
                            <select name="type"
                                    class="form-select"
                                    required>
                                <option value="">Select type</option>
                                <c:forEach var="t"
                                           items="${institutionTypes}">
                                    <option value="${t}">
                                        ${t}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">
                                Contact Person
                            </label>
                            <input type="text"
                                   name="contactPerson"
                                   class="form-control"
                                   placeholder="Principal / HR Name"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">
                                Their Role
                            </label>
                            <input type="text"
                                   name="contactRole"
                                   class="form-control"
                                   placeholder="Principal / HR Manager"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">
                                Email
                            </label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   placeholder="contact@institution.edu"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">
                                Phone
                            </label>
                            <input type="text"
                                   name="phone"
                                   class="form-control"
                                   placeholder="9876543210"/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                City
                            </label>
                            <input type="text"
                                   name="city"
                                   class="form-control"/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                State
                            </label>
                            <input type="text"
                                   name="state"
                                   class="form-control"/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                Website
                            </label>
                            <input type="text"
                                   name="website"
                                   class="form-control"
                                   placeholder="https://..."/>
                        </div>
                        <div class="col-12">
                            <label class="form-label">
                                Domains (comma-separated)
                            </label>
                            <input type="text"
                                   name="domains"
                                   class="form-control"
                                   placeholder="CSE, IT, ECE, MBA"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">
                        Cancel
                    </button>
                    <button type="submit"
                            class="btn btn-primary">
                        Add Institution
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>