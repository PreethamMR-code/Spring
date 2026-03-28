<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>500 - Server Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body { background: #f8f9fa; }
        .error-box { margin-top: 120px; text-align: center; }
        .error-code { font-size: 8rem; font-weight: 900; color: #fff3cd; line-height: 1; }
        .error-title { font-size: 1.8rem; font-weight: 700; color: #343a40; }
    </style>
</head>
<body>
<div class="container error-box">
    <div class="error-code">500</div>
    <div class="error-title mt-2">Something Went Wrong</div>
    <p class="text-muted mt-3">
        An unexpected error occurred on our end.<br>
        Please try again or contact support if the problem persists.
    </p>
    <div class="mt-4 d-flex justify-content-center gap-3">
        <a href="${pageContext.request.contextPath}/"
           class="btn btn-warning px-4">Go to Home</a>
        <a href="javascript:history.back()"
           class="btn btn-outline-secondary px-4">Go Back</a>
    </div>
</div>
</body>
</html>