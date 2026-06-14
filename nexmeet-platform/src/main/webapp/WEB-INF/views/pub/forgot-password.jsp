<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Forgot Password – NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
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
        .left-panel {
            width: 46%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
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
        }
        .left-brand { font-size: 1.9rem; font-weight: 800; color: white; margin-bottom: 40px; }
        .left-headline { font-size: 2rem; font-weight: 800; color: white; line-height: 1.2; margin-bottom: 14px; }
        .left-sub { font-size: 1rem; color: rgba(255,255,255,0.78); line-height: 1.7; max-width: 340px; }
        .right-panel { flex: 1; display: flex; align-items: center; justify-content: center; padding: 40px 32px; background: white; }
        .box { width: 100%; max-width: 400px; }
        .box-title { font-size: 1.8rem; font-weight: 800; color: #0f172a; margin-bottom: 6px; }
        .box-sub { font-size: 0.92rem; color: #64748b; margin-bottom: 28px; }
        .field-label { font-weight: 600; font-size: 0.85rem; color: #374151; margin-bottom: 6px; display: block; }
        .field-input {
            width: 100%; border: 1.5px solid #e2e8f0; border-radius: 10px;
            padding: 12px 14px; font-size: 0.95rem; font-family: 'Inter', sans-serif;
            transition: border-color 0.15s, box-shadow 0.15s;
            background: #fafbfc; color: #0f172a; outline: none;
        }
        .field-input:focus { border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.12); background: white; }
        .btn-main {
            display: block; width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; border: none; border-radius: 10px;
            padding: 13px; font-weight: 700; font-size: 1rem;
            font-family: 'Inter', sans-serif; cursor: pointer;
            transition: opacity 0.15s, transform 0.15s; margin-top: 8px;
        }
        .btn-main:hover { opacity: 0.92; transform: translateY(-1px); }
        .alert-error { background:#fef2f2; border:1px solid #fecaca; border-radius:10px; padding:12px 14px; color:#991b1b; font-size:0.88rem; margin-bottom:20px; }
        .alert-success { background:#f0fdf4; border:1px solid #bbf7d0; border-radius:10px; padding:12px 14px; color:#166534; font-size:0.88rem; margin-bottom:20px; }
        .back-link { text-align:center; margin-top:20px; font-size:0.85rem; color:#64748b; }
        .back-link a { color:#667eea; text-decoration:none; font-weight:600; }
        @media (max-width: 768px) { body { display: block; } .left-panel { display: none; } .right-panel { min-height: 100vh; padding: 40px 20px; } }
    </style>
</head>
<body>

<div class="left-panel">
    <div style="position:relative;z-index:1">
        <div class="left-brand">NexMeet</div>
        <div class="left-headline">Forgot your<br/>password?</div>
        <p class="left-sub">
            No problem. Enter your registered email address
            and we'll send you a secure link to reset it.
            The link expires in 1 hour.
        </p>
    </div>
</div>

<div class="right-panel">
    <div class="box">
        <div class="box-title">Reset Password</div>
        <div class="box-sub">
            Enter your email to receive a reset link
        </div>

        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert-success">✅ ${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password"
              method="post">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>

            <div style="margin-bottom:20px">
                <label class="field-label" for="email">
                    Email Address
                </label>
                <input type="email"
                       id="email"
                       name="email"
                       class="field-input"
                       placeholder="you@example.com"
                       autofocus
                       required/>
            </div>

            <button type="submit" class="btn-main">
                Send Reset Link →
            </button>
        </form>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/login">
                ← Back to Sign In
            </a>
        </div>
    </div>
</div>

</body>
</html>