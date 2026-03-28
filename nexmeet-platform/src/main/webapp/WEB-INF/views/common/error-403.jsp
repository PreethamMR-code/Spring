<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>403 - Access Denied</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body { background: #f8f9fa; }
        .error-box { margin-top: 120px; text-align: center; }
        .error-code { font-size: 8rem; font-weight: 900; color: #f8d7da; line-height: 1; }
        .error-title { font-size: 1.8rem; font-weight: 700; color: #343a40; }
    </style>
</head>
<body>
<div class="container error-box">
    <div class="error-code">403</div>
    <div class="error-title mt-2">Access Denied</div>
    <p class="text-muted mt-3">
        You do not have permission to access this page.<br>
        Please login with an account that has the required role.
    </p>
    <div class="mt-4 d-flex justify-content-center gap-3">
        <a href="${pageContext.request.contextPath}/"
           class="btn btn-danger px-4">Go to Home</a>
        <a href="${pageContext.request.contextPath}/login"
           class="btn btn-outline-danger px-4">Login</a>
    </div>
</div>
</body>
</html>