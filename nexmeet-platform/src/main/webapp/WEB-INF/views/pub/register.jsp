<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .register-card {
            max-width: 500px;
            margin: 50px auto;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.10);
        }
        .brand { color: #667eea; font-weight: 800; font-size: 1.6rem; }
        .btn-primary { background: #667eea; border-color: #667eea; }
        .btn-primary:hover { background: #5a67d8; border-color: #5a67d8; }
        .role-card {
            border: 2px solid #dee2e6;
            border-radius: 8px;
            padding: 12px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .role-card:hover { border-color: #667eea; background: #f8f7ff; }
        .role-card.selected { border-color: #667eea; background: #f0eeff; }
        .role-card input[type=radio] { display: none; }
    </style>
</head>
<body>
<div class="container">
    <div class="card register-card">
        <div class="card-body p-4">

            <div class="text-center mb-4">
                <a href="${pageContext.request.contextPath}/"
                   class="text-decoration-none">
                    <div class="brand">NexMeet</div>
                </a>
                <p class="text-muted mt-1">Create your account</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible">
                    ${error}
                    <button type="button" class="btn-close"
                            data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register"
                  method="post">
                <input type="hidden" name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <!-- Role Selection -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">I am registering as</label>
                    <div class="row g-2">
                        <div class="col-6">
                            <label class="role-card d-block" id="delegateCard">
                                <input type="radio" name="role"
                                       value="DELEGATE" checked/>
                                <div class="text-center">
                                    <div style="font-size:1.5rem">🎓</div>
                                    <div class="fw-bold small">Delegate</div>
                                    <div class="text-muted" style="font-size:0.75rem">
                                        Attend conferences
                                    </div>
                                </div>
                            </label>
                        </div>
                        <div class="col-6">
                            <label class="role-card d-block" id="organizerCard">
                                <input type="radio" name="role"
                                       value="ORGANIZER"/>
                                <div class="text-center">
                                    <div style="font-size:1.5rem">🎯</div>
                                    <div class="fw-bold small">Organizer</div>
                                    <div class="text-muted" style="font-size:0.75rem">
                                        Host conferences
                                    </div>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Full Name</label>
                    <input type="text" class="form-control" name="fullName"
                           value="${registerDto.fullName}"
                           placeholder="Your full name" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Email Address</label>
                    <input type="email" class="form-control" name="email"
                           value="${registerDto.email}"
                           placeholder="you@example.com" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Phone Number
                        <span class="text-muted fw-normal">(optional)</span>
                    </label>
                    <input type="tel" class="form-control" name="phone"
                           value="${registerDto.phone}"
                           placeholder="+91 98765 43210"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Password</label>
                    <input type="password" class="form-control" name="password"
                           placeholder="At least 6 characters" required/>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Confirm Password</label>
                    <input type="password" class="form-control"
                           name="confirmPassword"
                           placeholder="Repeat your password" required/>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                    Create Account
                </button>
            </form>

            <hr class="my-3"/>
            <div class="text-center">
                <span class="text-muted">Already have an account?</span>
                <a href="${pageContext.request.contextPath}/login"
                   class="ms-1 text-decoration-none fw-semibold">Sign in</a>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Highlight selected role card
    document.querySelectorAll('.role-card input[type=radio]').forEach(function(radio) {
        radio.addEventListener('change', function() {
            document.querySelectorAll('.role-card').forEach(function(card) {
                card.classList.remove('selected');
            });
            this.closest('.role-card').classList.add('selected');
        });
    });
    // Set initial selected state
    document.querySelector('.role-card input[type=radio]:checked')
        .closest('.role-card').classList.add('selected');
</script>
</body>
</html>