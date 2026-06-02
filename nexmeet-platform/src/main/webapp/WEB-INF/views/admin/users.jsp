<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Users – Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .role-badge {
            font-size: 0.7rem;
            padding: 2px 8px;
            border-radius: 20px;
            font-weight: 600;
        }
        .filter-bar {
            background: white;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <div>
            <h2 class="text-danger mb-0">All Users</h2>
            <p class="text-muted small mb-0">
                ${fn:length(users)} user(s) registered
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary btn-sm">
            ← Dashboard
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <%-- Search + Filter bar (client-side, no backend call) --%>
    <div class="filter-bar">
        <div class="row g-2 align-items-end">
            <div class="col-md-5">
                <label class="form-label small fw-semibold
                              text-muted mb-1">
                    Search
                </label>
                <input type="text"
                       id="userSearch"
                       class="form-control form-control-sm"
                       placeholder="Name or email..."
                       oninput="filterUsers()"/>
            </div>
            <div class="col-md-3">
                <label class="form-label small fw-semibold
                              text-muted mb-1">
                    Filter by Role
                </label>
                <select id="roleFilter"
                        class="form-select form-select-sm"
                        onchange="filterUsers()">
                    <option value="">All Roles</option>
                    <option value="SUPER_ADMIN">Admin</option>
                    <option value="ORGANIZER">Organizer</option>
                    <option value="DELEGATE">Delegate</option>
                    <option value="INSTITUTIONAL_ADMIN">
                        Institutional Admin
                    </option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label small fw-semibold
                              text-muted mb-1">
                    Filter by Status
                </label>
                <select id="statusFilter"
                        class="form-select form-select-sm"
                        onchange="filterUsers()">
                    <option value="">All Statuses</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                </select>
            </div>
            <div class="col-md-1">
                <button class="btn btn-outline-secondary
                               btn-sm w-100"
                        onclick="clearFilters()">
                    Clear
                </button>
            </div>
        </div>
        <div class="mt-2 small text-muted">
            Showing <span id="visibleCount">
                ${fn:length(users)}
            </span>
            of ${fn:length(users)} users
        </div>
    </div>

    <div class="card"
         style="border:none;border-radius:14px;
                box-shadow:0 2px 12px rgba(0,0,0,0.09)">
        <div class="card-body p-0">
            <div class="table-responsive">
            <table class="table table-hover mb-0 small"
                   id="usersTable">
                <thead style="background:#fef2f2">
                    <tr>
                        <th class="ps-3">#</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Roles</th>
                        <th>Status</th>
                        <th>Joined</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="usersBody">
                    <c:forEach var="user"
                               items="${users}"
                               varStatus="loop">
                        <%--
                            data-name, data-email, data-role,
                            data-status are used by the JS filter.
                            Keeping all data inline avoids a
                            second server request.
                        --%>
                        <tr class="${!user.active ?
                                'table-secondary text-muted' : ''}"
                            data-name="${fn:toLowerCase(user.fullName)}"
                            data-email="${fn:toLowerCase(user.email)}"
                            data-role="<c:forEach var='r' items='${user.roles}'>${r.name} </c:forEach>"
                            data-status="${user.active ? 'active' : 'inactive'}">

                            <td class="ps-3 text-muted">
                                ${loop.index + 1}
                            </td>
                            <td class="fw-semibold">
                                ${user.fullName}
                            </td>
                            <td class="text-muted">
                                <a href="mailto:${user.email}"
                                   class="text-decoration-none
                                          text-muted">
                                    ${user.email}
                                </a>
                            </td>
                            <td class="text-muted">
                                ${not empty user.phone
                                    ? user.phone : '—'}
                            </td>
                            <td>
                                <c:forEach var="role"
                                           items="${user.roles}">
                                    <c:choose>
                                        <c:when test="${role.name == 'SUPER_ADMIN'}">
                                            <span class="role-badge badge bg-danger">
                                                ADMIN
                                            </span>
                                        </c:when>
                                        <c:when test="${role.name == 'ORGANIZER'}">
                                            <span class="role-badge badge bg-primary">
                                                ORGANIZER
                                            </span>
                                        </c:when>
                                        <c:when test="${role.name == 'DELEGATE'}">
                                            <span class="role-badge badge bg-success">
                                                DELEGATE
                                            </span>
                                        </c:when>
                                        <c:when test="${role.name == 'INSTITUTIONAL_ADMIN'}">
                                            <span class="role-badge badge bg-info text-dark">
                                                INST. ADMIN
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="role-badge badge bg-secondary">
                                                ${role.name}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.active}">
                                        <span class="badge bg-success">
                                            Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">
                                            Inactive
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-muted">
                                ${fn:substringBefore(
                                    user.createdAt.toString(),'T')}
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/user/${user.id}/toggle-active"
                                      method="post"
                                      class="d-inline">
                                    <input type="hidden"
                                           name="${_csrf.parameterName}"
                                           value="${_csrf.token}"/>
                                    <button class="btn btn-sm
                                        ${user.active
                                            ? 'btn-outline-danger'
                                            : 'btn-outline-success'}">
                                        ${user.active
                                            ? 'Deactivate'
                                            : 'Activate'}
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
            <%-- Empty state --%>
            <div id="noResults"
                 class="text-center py-5 text-muted d-none">
                <div style="font-size:2.5rem">🔍</div>
                <div class="mt-2">
                    No users match your search.
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>

<script>
/*
 * Client-side filter — no backend call needed.
 * Users list is small (< 500 rows typically).
 * Reads data-* attributes set in each <tr>.
 */
function filterUsers() {
    var search  = document.getElementById('userSearch')
                      .value.toLowerCase().trim();
    var role    = document.getElementById('roleFilter').value;
    var status  = document.getElementById('statusFilter').value;

    var rows    = document.querySelectorAll(
                      '#usersBody tr');
    var visible = 0;

    rows.forEach(function(row) {
        var name      = row.dataset.name    || '';
        var email     = row.dataset.email   || '';
        var rowRole   = row.dataset.role    || '';
        var rowStatus = row.dataset.status  || '';

        var matchSearch = !search
            || name.includes(search)
            || email.includes(search);

        var matchRole = !role
            || rowRole.includes(role);

        var matchStatus = !status
            || rowStatus === status;

        if (matchSearch && matchRole && matchStatus) {
            row.style.display = '';
            visible++;
        } else {
            row.style.display = 'none';
        }
    });

    document.getElementById('visibleCount')
        .textContent = visible;

    document.getElementById('noResults')
        .classList.toggle('d-none', visible > 0);
}

function clearFilters() {
    document.getElementById('userSearch').value = '';
    document.getElementById('roleFilter').value = '';
    document.getElementById('statusFilter').value = '';
    filterUsers();
}
</script>
</body>
</html>