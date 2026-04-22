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

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <h2 class="text-danger">All Users</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary">Back</a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card">
        <div class="card-body p-0">
            <table class="table table-hover table-bordered mb-0">
                <thead class="table-danger">
                    <tr>
                        <th>#</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Roles</th>
                        <th>Status</th>
                        <th>Joined</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}"
                               varStatus="loop">
                        <tr class="${!user.active ?
                            'table-secondary text-muted' : ''}">
                            <td>${loop.index + 1}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>
                                <c:forEach var="role"
                                           items="${user.roles}">
                                    <span class="badge bg-info
                                        text-dark small">
                                        ${fn:replace(role.name,
                                            'ROLE_','')}
                                    </span>
                                </c:forEach>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.active}">
                                        <span class="badge
                                            bg-success">
                                            Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge
                                            bg-danger">
                                            Inactive
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="small">
                                ${fn:substringBefore(
                                    user.createdAt.toString(),
                                    'T')}
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/user/${user.id}/toggle-active"
                                      method="post"
                                      class="d-inline">
                                    <input type="hidden"
                                        name="${_csrf.parameterName}"
                                        value="${_csrf.token}"/>
                                    <button class="btn btn-sm
                                        ${user.active ?
                                        'btn-outline-danger' :
                                        'btn-outline-success'}">
                                        ${user.active ?
                                            'Deactivate' :
                                            'Activate'}
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>