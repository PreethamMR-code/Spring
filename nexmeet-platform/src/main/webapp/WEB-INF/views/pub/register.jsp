<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Create Account – NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fc;
            -webkit-font-smoothing: antialiased;
        }
        .register-card {
            max-width: 520px;
            margin: 48px auto 48px;
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 28px rgba(0,0,0,0.10);
        }
        .brand {
            background: linear-gradient(135deg,
                #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 800;
            font-size: 1.7rem;
            letter-spacing: -0.02em;
        }

        /* Role cards */
        .role-card {
            border: 2px solid #e8ecf0;
            border-radius: 10px;
            padding: 14px 10px;
            cursor: pointer;
            transition: all 0.18s;
            text-align: center;
            display: block;
            background: #fafbfc;
            height: 100%;
        }
        .role-card:hover {
            border-color: #667eea;
            background: #f8f7ff;
        }
        .role-card.selected {
            border-color: #667eea;
            background: #f0eeff;
        }
        .role-card input[type=radio] {
            display: none;
        }
        .role-icon { font-size: 1.6rem; margin-bottom: 6px; }
        .role-name {
            font-weight: 700;
            font-size: 0.82rem;
            color: #0f172a;
        }
        .role-desc {
            font-size: 0.7rem;
            color: #64748b;
            margin-top: 2px;
            line-height: 1.4;
        }

        /* Form */
        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #374151;
        }
        .form-control {
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 11px 14px;
            font-size: 0.93rem;
            background: #fafbfc;
            font-family: 'Inter', sans-serif;
            transition: border-color 0.15s, box-shadow 0.15s;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.12);
            background: white;
        }
        .form-control::placeholder { color: #94a3b8; }

        .btn-create {
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 13px;
            font-weight: 700;
            font-size: 0.97rem;
            width: 100%;
            transition: opacity 0.15s, transform 0.15s,
                        box-shadow 0.15s;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
        }
        .btn-create:hover {
            opacity: 0.9;
            transform: translateY(-1px);
            box-shadow: 0 8px 24px rgba(102,126,234,0.3);
        }

        .section-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #94a3b8;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card register-card">
        <div class="card-body p-4 p-md-5">

            <%-- Header --%>
            <div class="text-center mb-4">
                <a href="${pageContext.request.contextPath}/"
                   class="text-decoration-none">
                    <div class="brand">NexMeet</div>
                </a>
                <h5 class="mt-2 fw-bold"
                    style="color:#0f172a">
                    Create your free account
                </h5>
                <p class="text-muted"
                   style="font-size:0.88rem">
                    Join thousands of delegates and organizers
                </p>
            </div>

            <%-- Error alert --%>
            <c:if test="${not empty error}">
                <div style="background:#fef2f2;
                            border:1px solid #fecaca;
                            border-radius:10px;
                            padding:12px 14px;
                            color:#991b1b;
                            font-size:0.88rem;
                            display:flex;gap:10px;
                            align-items:flex-start;
                            margin-bottom:20px">
                    <span>⚠️</span>
                    <span>${error}</span>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register"
                  method="post">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <%--
                    ROLE SELECTION
                    BUG FIX: The original JSP was missing the closing
                    </div> for this mb-3 wrapper, causing all subsequent
                    form fields to be nested inside this div.
                    Fixed below — wrapper div explicitly closed after
                    the row div.
                --%>
                <div class="mb-4">
                    <div class="section-label">
                        I am registering as
                    </div>
                    <div class="row g-2">
                        <div class="col-4">
                            <label class="role-card"
                                   id="card-DELEGATE">
                                <input type="radio"
                                       name="role"
                                       value="DELEGATE"
                                       checked/>
                                <div class="role-icon">🎓</div>
                                <div class="role-name">
                                    Delegate
                                </div>
                                <div class="role-desc">
                                    Attend conferences
                                </div>
                            </label>
                        </div>
                        <div class="col-4">
                            <label class="role-card"
                                   id="card-ORGANIZER">
                                <input type="radio"
                                       name="role"
                                       value="ORGANIZER"/>
                                <div class="role-icon">🎯</div>
                                <div class="role-name">
                                    Organizer
                                </div>
                                <div class="role-desc">
                                    Host conferences
                                </div>
                            </label>
                        </div>
                        <div class="col-4">
                            <label class="role-card"
                                   id="card-INSTITUTIONAL_ADMIN">
                                <input type="radio"
                                       name="role"
                                       value="INSTITUTIONAL_ADMIN"/>
                                <div class="role-icon">🏫</div>
                                <div class="role-name">
                                    Institution
                                </div>
                                <div class="role-desc">
                                    Register students
                                </div>
                            </label>
                        </div>
                    </div>
                </div>
                <%-- ↑ THIS </div> was missing in the original.
                       All fields below were incorrectly nested. --%>

                <div class="mb-3">
                    <label class="form-label"
                           for="fullName">
                        Full Name *
                    </label>
                    <input type="text"
                           id="fullName"
                           class="form-control"
                           name="fullName"
                           value="${registerDto.fullName}"
                           placeholder="Your full name"
                           required/>
                </div>

                <div class="mb-3">
                    <label class="form-label"
                           for="email">
                        Email Address *
                    </label>
                    <input type="email"
                           id="email"
                           class="form-control"
                           name="email"
                           value="${registerDto.email}"
                           placeholder="you@example.com"
                           required/>
                </div>

                <div class="mb-3">
                    <label class="form-label"
                           for="phone">
                        Phone Number
                        <span class="text-muted fw-normal">
                            (optional)
                        </span>
                    </label>
                    <input type="tel"
                           id="phone"
                           class="form-control"
                           name="phone"
                           value="${registerDto.phone}"
                           placeholder="+91 98765 43210"/>
                </div>

                <div class="mb-3">
                    <label class="form-label"
                           for="password">
                        Password *
                    </label>
                    <input type="password"
                           id="password"
                           class="form-control"
                           name="password"
                           placeholder="At least 6 characters"
                           required/>
                    <div class="form-text text-muted"
                         style="font-size:0.78rem">
                        Minimum 6 characters
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label"
                           for="confirmPassword">
                        Confirm Password *
                    </label>
                    <input type="password"
                           id="confirmPassword"
                           class="form-control"
                           name="confirmPassword"
                           placeholder="Repeat your password"
                           required/>
                </div>

                <button type="submit"
                        class="btn-create">
                    Create Account →
                </button>
            </form>

            <hr style="margin:24px 0;border-color:#f0f2f5"/>

            <div class="text-center"
                 style="font-size:0.9rem;color:#64748b">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login"
                   style="color:#667eea;
                          font-weight:600;
                          text-decoration:none">
                    Sign in
                </a>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>
/*
 * Role card selection highlight.
 * Reads the role value from the radio input's data
 * and adds/removes the 'selected' class on the label.
 */
function syncCards() {
    document.querySelectorAll(
        '.role-card input[type=radio]'
    ).forEach(function(radio) {
        var card = radio.closest('.role-card');
        if (radio.checked) {
            card.classList.add('selected');
        } else {
            card.classList.remove('selected');
        }
    });
}

// Wire up change events
document.querySelectorAll(
    '.role-card input[type=radio]'
).forEach(function(radio) {
    radio.addEventListener('change', syncCards);
});

// Set initial state on page load
syncCards();

// Optional: confirm passwords match before submit
document.querySelector('form').addEventListener(
    'submit',
    function(e) {
        var pw = document.getElementById('password').value;
        var cp = document.getElementById('confirmPassword').value;
        if (pw !== cp) {
            e.preventDefault();
            alert('Passwords do not match. Please check and try again.');
            document.getElementById('confirmPassword').focus();
        }
    }
);
</script>
</body>
</html>