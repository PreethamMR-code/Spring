<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>404 - Page Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body { background: #f8f9fa; }
        .error-box { margin-top: 120px; text-align: center; }
        .error-code { font-size: 8rem; font-weight: 900; color: #dee2e6; line-height: 1; }
        .error-title { font-size: 1.8rem; font-weight: 700; color: #343a40; }
    </style>
</head>
<body>
<div class="container error-box">
    <div class="error-code">404</div>
    <div class="error-title mt-2">Page Not Found</div>
    <p class="text-muted mt-3">
        The page you are looking for does not exist or has been moved.
    </p>
    <div class="mt-4 d-flex justify-content-center gap-3">
        <a href="${pageContext.request.contextPath}/"
           class="btn btn-primary px-4">Go to Home</a>
        <a href="javascript:history.back()"
           class="btn btn-outline-secondary px-4">Go Back</a>
    </div>
</div>
</body>
</html>