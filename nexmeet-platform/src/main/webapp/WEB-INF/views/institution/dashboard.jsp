<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Institution Dashboard - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card p-4 shadow-sm">
        <h2 class="text-warning">Institution Dashboard</h2>
        <p>Welcome, <strong><sec:authentication property="name"/></strong></p>
        <p class="text-muted">Role: INSTITUTIONAL_ADMIN</p>
        <hr>
        <div class="row g-3">
            <div class="col-md-4">
                <div class="card text-center p-3 border-warning">
                    <h5>Bulk Uploads</h5>
                    <h2 class="text-warning">0</h2>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center p-3 border-primary">
                    <h5>Total Delegates</h5>
                    <h2 class="text-primary">0</h2>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center p-3 border-success">
                    <h5>Active Conferences</h5>
                    <h2 class="text-success">0</h2>
                </div>
            </div>
        </div>
        <div class="mt-4">
           <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
               <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
               <button type="submit" class="btn btn-outline-danger">Logout</button>
           </form>
        </div>
    </div>
</div>
</body>
</html>
