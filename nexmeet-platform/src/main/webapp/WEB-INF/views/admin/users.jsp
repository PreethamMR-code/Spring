<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Users - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-danger">All Users</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary">Back to Dashboard</a>
    </div>

    <div class="card">
        <div class="card-header fw-bold">
            Total Users: ${users.size()}
        </div>
        <div class="card-body p-0">
            <table class="table table-hover table-bordered mb-0">
                <thead class="table-danger">
                    <tr>
                        <th>#</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Roles</th>
                        <th>Active</th>
                        <th>Joined</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}" varStatus="s">
                        <tr>
                            <td>${s.count}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty user.phone}">
                                        ${user.phone}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">—</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:forEach var="role" items="${user.roles}">
                                    <span class="badge bg-secondary">
                                        ${fn:replace(role.name,'ROLE_','')}
                                    </span>
                                </c:forEach>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.active}">
                                        <span class="badge bg-success">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${fn:substringBefore(
                                user.createdAt.toString(),'T')}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>