<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .register-card {
            max-width: 460px;
            margin: 60px auto;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.10);
        }
        .brand { color: #4f46e5; font-weight: 700; font-size: 1.5rem; }
        .btn-primary { background: #4f46e5; border-color: #4f46e5; }
        .btn-primary:hover { background: #4338ca; border-color: #4338ca; }
    </style>
</head>
<body>

<div class="container">
    <div class="card register-card">
        <div class="card-body p-4">

            <!-- Brand -->
            <div class="text-center mb-4">
                <div class="brand">NexMeet</div>
                <p class="text-muted mt-1">Create your account</p>
            </div>

            <!-- Error message -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!--
                Form action uses contextPath so it works at any deployment path.
                method="post" sends data in the request body (not visible in URL).
                Spring Security requires a CSRF token — we include it as a hidden field.
            -->
            <form action="${pageContext.request.contextPath}/register" method="post">

                <!-- CSRF token — Spring Security rejects POST requests without this -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                <div class="mb-3">
                    <label for="fullName" class="form-label fw-semibold">Full Name</label>
                    <input type="text"
                           class="form-control"
                           id="fullName"
                           name="fullName"
                           value="${registerDto.fullName}"
                           placeholder="Your full name"
                           required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label fw-semibold">Email address</label>
                    <input type="email"
                           class="form-control"
                           id="email"
                           name="email"
                           value="${registerDto.email}"
                           placeholder="you@example.com"
                           required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label fw-semibold">Password</label>
                    <input type="password"
                           class="form-control"
                           id="password"
                           name="password"
                           placeholder="At least 6 characters"
                           required>
                </div>

                <div class="mb-4">
                    <label for="confirmPassword" class="form-label fw-semibold">Confirm Password</label>
                    <input type="password"
                           class="form-control"
                           id="confirmPassword"
                           name="confirmPassword"
                           placeholder="Repeat your password"
                           required>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                    Create Account
                </button>

            </form>

            <hr class="my-4">

            <div class="text-center">
                <span class="text-muted">Already have an account?</span>
                <a href="${pageContext.request.contextPath}/login" class="ms-1 text-decoration-none fw-semibold">
                    Sign in
                </a>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>