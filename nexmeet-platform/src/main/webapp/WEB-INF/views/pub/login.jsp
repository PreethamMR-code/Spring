<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Sign In – NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            margin: 0;
            display: flex;
            background: #f8f9fc;
            -webkit-font-smoothing: antialiased;
        }

        /* ── Left Panel ──────────────────────────────── */
        .left-panel {
            width: 46%;
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 56px 52px;
            position: relative;
            overflow: hidden;
        }
        .left-panel::before {
            content: '';
            position: absolute;
            top: -120px; right: -100px;
            width: 450px; height: 450px;
            background: rgba(255,255,255,0.07);
            border-radius: 50%;
            pointer-events: none;
        }
        .left-panel::after {
            content: '';
            position: absolute;
            bottom: -100px; left: -80px;
            width: 320px; height: 320px;
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
            pointer-events: none;
        }
        .left-content {
            position: relative;
            z-index: 1;
        }
        .left-brand {
            font-size: 1.9rem;
            font-weight: 800;
            color: white;
            letter-spacing: -0.02em;
            margin-bottom: 52px;
        }
        .left-headline {
            font-size: 2.3rem;
            font-weight: 800;
            color: white;
            line-height: 1.2;
            letter-spacing: -0.02em;
            margin-bottom: 14px;
        }
        .left-sub {
            font-size: 1rem;
            color: rgba(255,255,255,0.78);
            line-height: 1.7;
            margin-bottom: 40px;
            max-width: 340px;
        }
        .feature-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .feature-item {
            display: flex;
            align-items: center;
            gap: 14px;
            color: rgba(255,255,255,0.88);
            font-size: 0.9rem;
            margin-bottom: 18px;
            font-weight: 500;
        }
        .feature-icon {
            width: 36px; height: 36px;
            background: rgba(255,255,255,0.15);
            border-radius: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            flex-shrink: 0;
            backdrop-filter: blur(4px);
        }
        .stats-row {
            display: flex;
            gap: 36px;
            padding-top: 32px;
            border-top: 1px solid rgba(255,255,255,0.18);
            position: relative;
            z-index: 1;
        }
        .stat-num {
            font-size: 1.5rem;
            font-weight: 800;
            color: white;
            line-height: 1;
        }
        .stat-label {
            font-size: 0.72rem;
            color: rgba(255,255,255,0.6);
            margin-top: 4px;
            text-transform: uppercase;
            letter-spacing: 0.06em;
        }

        /* ── Right Panel ─────────────────────────────── */
        .right-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 32px;
            background: white;
        }
        .login-box {
            width: 100%;
            max-width: 400px;
        }
        .login-title {
            font-size: 1.85rem;
            font-weight: 800;
            color: #0f172a;
            letter-spacing: -0.02em;
            margin-bottom: 6px;
        }
        .login-subtitle {
            font-size: 0.92rem;
            color: #64748b;
            margin-bottom: 28px;
        }

        /* ── Form Controls ───────────────────────────── */
        .field-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #374151;
            margin-bottom: 6px;
            display: block;
        }
        .field-input {
            width: 100%;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 14px;
            font-size: 0.95rem;
            font-family: 'Inter', sans-serif;
            transition: border-color 0.15s, box-shadow 0.15s;
            background: #fafbfc;
            color: #0f172a;
            outline: none;
        }
        .field-input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.12);
            background: white;
        }
        .field-input::placeholder { color: #94a3b8; }

        .password-wrap {
            position: relative;
        }
        .password-wrap .field-input {
            padding-right: 48px;
        }
        .toggle-pw {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            color: #94a3b8;
            font-size: 1rem;
            line-height: 1;
            transition: color 0.15s;
        }
        .toggle-pw:hover { color: #667eea; }

        .btn-signin {
            display: block;
            width: 100%;
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 13px;
            font-weight: 700;
            font-size: 1rem;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: opacity 0.15s, transform 0.15s,
                        box-shadow 0.15s;
            margin-top: 8px;
            letter-spacing: 0.01em;
        }
        .btn-signin:hover {
            opacity: 0.92;
            transform: translateY(-1px);
            box-shadow: 0 8px 24px
                rgba(102,126,234,0.35);
        }
        .btn-signin:active { transform: translateY(0); }

        /* ── Alerts ──────────────────────────────────── */
        .alert-error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 10px;
            padding: 12px 14px;
            color: #991b1b;
            font-size: 0.88rem;
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 20px;
        }
        .alert-success {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            border-radius: 10px;
            padding: 12px 14px;
            color: #166534;
            font-size: 0.88rem;
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 20px;
        }
        .alert-icon {
            font-size: 1.05rem;
            flex-shrink: 0;
            margin-top: 1px;
        }

        /* ── Divider ─────────────────────────────────── */
        .divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 24px 0;
        }
        .divider-line {
            flex: 1;
            height: 1px;
            background: #e2e8f0;
        }
        .divider-text {
            font-size: 0.78rem;
            color: #94a3b8;
            font-weight: 500;
            white-space: nowrap;
        }

        /* ── Register button ─────────────────────────── */
        .btn-register {
            display: block;
            width: 100%;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            font-size: 0.95rem;
            font-family: 'Inter', sans-serif;
            color: #374151;
            background: white;
            text-align: center;
            text-decoration: none;
            transition: all 0.15s;
            cursor: pointer;
        }
        .btn-register:hover {
            border-color: #667eea;
            color: #667eea;
            background: #f8f7ff;
        }

        /* ── Footer link ─────────────────────────────── */
        .footer-link {
            text-align: center;
            font-size: 0.78rem;
            color: #94a3b8;
            margin-top: 24px;
        }
        .footer-link a {
            color: #94a3b8;
            text-decoration: none;
            transition: color 0.15s;
        }
        .footer-link a:hover { color: #667eea; }

        /* ── Mobile ──────────────────────────────────── */
        @media (max-width: 768px) {
            body { display: block; }
            .left-panel { display: none; }
            .right-panel {
                min-height: 100vh;
                padding: 40px 20px;
            }
        }
        .mobile-brand {
            display: none;
            text-align: center;
            margin-bottom: 32px;
        }
        .mobile-brand-text {
            font-size: 1.7rem;
            font-weight: 800;
            background: linear-gradient(135deg,
                #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        @media (max-width: 768px) {
            .mobile-brand { display: block; }
        }
    </style>
</head>
<body>

    <!-- ── LEFT PANEL ──────────────────────────────── -->
    <div class="left-panel">
        <div class="left-content">
            <div class="left-brand">NexMeet</div>

            <div class="left-headline">
                Your conference<br/>journey starts here
            </div>
            <p class="left-sub">
                The all-in-one platform for professional
                conferences — from registration to
                certificates, everything handled for you.
            </p>

            <ul class="feature-list">
                <li class="feature-item">
                    <div class="feature-icon">📋</div>
                    Instant registration with QR code tickets
                </li>
                <li class="feature-item">
                    <div class="feature-icon">📱</div>
                    Camera-based QR check-in at the venue
                </li>
                <li class="feature-item">
                    <div class="feature-icon">📄</div>
                    Auto-generated attendance certificates
                </li>
                <li class="feature-item">
                    <div class="feature-icon">📊</div>
                    Real-time analytics and delegate insights
                </li>
            </ul>
        </div>

        <div class="stats-row">
            <div>
                <div class="stat-num">29+</div>
                <div class="stat-label">Conf. Types</div>
            </div>
            <div>
                <div class="stat-num">100%</div>
                <div class="stat-label">Digital</div>
            </div>
            <div>
                <div class="stat-num">Free</div>
                <div class="stat-label">To Join</div>
            </div>
        </div>
    </div>

    <!-- ── RIGHT PANEL ─────────────────────────────── -->
    <div class="right-panel">
        <div class="login-box">

            <%-- Mobile brand — only shows on small screens --%>
            <div class="mobile-brand">
                <div class="mobile-brand-text">NexMeet</div>
                <p style="color:#64748b;font-size:0.88rem;
                          margin-top:4px;margin-bottom:0">
                    Sign in to continue
                </p>
            </div>

            <div class="login-title">Welcome back</div>
            <div class="login-subtitle">
                Sign in to your NexMeet account
            </div>

            <%--
                Error state — pure JSTL, zero scriptlets.
                Spring Security appends ?error=true on failure.
                The param EL variable reads query parameters directly.
            --%>
            <c:if test="${param.error != null}">
                <div class="alert-error">
                    <span class="alert-icon">⚠️</span>
                    <span>
                        Invalid email or password.
                        Please check your credentials
                        and try again.
                    </span>
                </div>
            </c:if>

            <%-- Logout success — Spring Security appends ?logout=true --%>
            <c:if test="${param.logout != null}">
                <div class="alert-success">
                    <span class="alert-icon">✅</span>
                    <span>
                        You've been signed out safely.
                        See you next time!
                    </span>
                </div>
            </c:if>

            <%--
                Flash message from RegisterController after
                successful registration (PRG pattern).
                Stored as a redirect flash attribute.
            --%>
            <c:if test="${not empty success}">
                <div class="alert-success">
                    <span class="alert-icon">🎉</span>
                    <span>${success}</span>
                </div>
            </c:if>

            <%--
                Form posts to /login/process — this URL is
                handled entirely by Spring Security.
                We never write a controller method for it.
                spring-security.xml: login-processing-url="/login/process"
            --%>
            <form action="${pageContext.request.contextPath}/login/process"
                  method="post"
                  autocomplete="on">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <div style="margin-bottom:16px">
                    <label class="field-label" for="username">
                        Email Address
                    </label>
                    <input type="email"
                           id="username"
                           name="username"
                           class="field-input"
                           placeholder="you@example.com"
                           autocomplete="email"
                           autofocus
                           required/>
                </div>

                <div style="margin-bottom:6px">
                    <label class="field-label" for="password">
                        Password
                    </label>
                    <div class="password-wrap">
                        <input type="password"
                               id="password"
                               name="password"
                               class="field-input"
                               placeholder="Your password"
                               autocomplete="current-password"
                               required/>
                        <button type="button"
                                class="toggle-pw"
                                onclick="togglePwd()"
                                title="Show / hide password"
                                tabindex="-1">
                            👁
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-signin">
                    Sign In →
                </button>
            </form>

            <div class="divider">
                <div class="divider-line"></div>
                <div class="divider-text">
                    New to NexMeet?
                </div>
                <div class="divider-line"></div>
            </div>

            <a href="${pageContext.request.contextPath}/register"
               class="btn-register">
                Create a free account
            </a>

            <div class="footer-link">
                <a href="${pageContext.request.contextPath}/verify">
                    🎓 Verify a certificate without signing in
                </a>
            </div>

        </div>
    </div>

<script>
function togglePwd() {
    var f = document.getElementById('password');
    f.type = f.type === 'password' ? 'text' : 'password';
}
</script>
</body>
</html>