<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --navy:#0f172a; --accent:#3b82f6; --text:#1e293b; --muted:#64748b; }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter',sans-serif; background:linear-gradient(135deg,#f5f7fa 0%,#c3cfe2 100%); min-height:100vh; display:flex; flex-direction:column; }
        h1,h2,h3,h4,h5,h6 { font-family:'Sora',sans-serif; }

        .navbar-custom { background:rgba(255,255,255,0.95); backdrop-filter:blur(20px); box-shadow:0 2px 20px rgba(0,0,0,0.06); }
        .navbar-brand { font-family:'Sora',sans-serif; font-weight:800; font-size:1.3rem; color:var(--navy)!important; }
        .btn-nav-primary { background:var(--accent); color:white; border:none; padding:0.6rem 1.75rem; border-radius:50px; font-weight:700; font-size:0.9rem; transition:all 0.3s; }
        .btn-nav-primary:hover { background:#2563eb; color:white; transform:translateY(-2px); }
        .btn-nav-outline { border:2px solid var(--accent); color:var(--accent); background:transparent; padding:0.55rem 1.5rem; border-radius:50px; font-weight:700; font-size:0.9rem; transition:all 0.3s; }
        .btn-nav-outline:hover { background:var(--accent); color:white; }

        main { flex:1; display:flex; align-items:center; justify-content:center; padding:6rem 1rem 2rem; }
        .otp-card { background:rgba(255,255,255,0.98); backdrop-filter:blur(20px); border-radius:24px; border:1px solid rgba(255,255,255,0.3); box-shadow:0 20px 60px rgba(0,0,0,0.15); padding:3rem; max-width:480px; width:100%; }
        .otp-title { font-family:'Sora',sans-serif; font-size:2rem; font-weight:800; margin-bottom:0.5rem; background:linear-gradient(135deg,#60a5fa,#3b82f6); -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text; }
        .form-control-custom { border-radius:12px; border:2px solid #e2e8f0; padding:0.85rem 1.25rem; font-size:0.95rem; transition:all 0.2s; }
        .form-control-custom:focus { border-color:var(--accent); box-shadow:0 0 0 4px rgba(59,130,246,0.12); outline:none; }
        .btn-send { background:linear-gradient(135deg,#3b82f6,#2563eb); border:none; border-radius:12px; padding:0.75rem 1.5rem; font-weight:700; font-size:0.9rem; transition:all 0.3s; box-shadow:0 8px 25px rgba(59,130,246,0.4); white-space:nowrap; }
        .btn-send:hover:not(:disabled) { transform:translateY(-2px); box-shadow:0 12px 35px rgba(59,130,246,0.5); }
        .btn-send:disabled { opacity:0.6; cursor:not-allowed; }
        .btn-verify { background:linear-gradient(135deg,#3b82f6,#2563eb); border:none; border-radius:12px; padding:0.85rem 2rem; font-weight:700; font-size:1rem; transition:all 0.3s; box-shadow:0 8px 25px rgba(59,130,246,0.4); }
        .btn-verify:hover:not(:disabled) { transform:translateY(-2px); box-shadow:0 12px 35px rgba(59,130,246,0.5); }
        .btn-verify:disabled { opacity:0.6; cursor:not-allowed; }
        .countdown-box { background:rgba(239,68,68,0.1); border:2px solid #fee2e2; border-radius:10px; padding:0.75rem 1rem; text-align:center; margin-top:0.5rem; }
        .countdown-num { font-family:'Sora',sans-serif; font-size:1.5rem; font-weight:800; color:#dc2626; }
        footer { background:rgba(0,0,0,0.9); color:white; text-align:center; padding:1.5rem; }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-4">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/'/>">
            <img src="https://x-workz.com/Logo.png" height="40" class="me-2" alt="X-Workz">
            <span>X-Workz</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="<c:url value='/'/>">Home</a></li>
            </ul>
            <div class="d-flex gap-2">
                <a href="<c:url value='/signUp'/>" class="btn btn-nav-outline">Sign Up</a>
                <a href="<c:url value='/signIn'/>" class="btn btn-nav-primary">Sign In</a>
            </div>
        </div>
    </div>
</nav>

<!-- MAIN -->
<main>
    <div class="otp-card">
        <div class="text-center mb-4">
            <div class="mb-3"><i class="bi bi-shield-check" style="font-size:3.5rem;color:var(--accent);"></i></div>
            <h1 class="otp-title">OTP Verification</h1>
            <p style="color:var(--muted);font-size:0.95rem;">Enter your email to receive a one-time password</p>
        </div>

        <!-- STEP 1: Send OTP Form -->
        <form id="sendOtpForm" action="<c:url value='/sendOTP'/>" method="post">
            <c:if test="${not empty msg}">
                <div class="alert alert-success border-0 mb-3" style="border-radius:12px;background:rgba(16,185,129,0.1);color:#065f46;">
                    <i class="bi bi-check-circle me-2"></i>${msg}
                </div>
            </c:if>
            <c:if test="${not empty msgUnsuccess}">
                <div class="alert alert-danger border-0 mb-3" style="border-radius:12px;background:rgba(239,68,68,0.1);color:#991b1b;">
                    <i class="bi bi-exclamation-circle me-2"></i>${msgUnsuccess}
                </div>
            </c:if>

            <div class="mb-3">
                <label class="form-label fw-semibold" style="font-size:0.85rem;"><i class="bi bi-envelope me-2"></i>Email Address</label>
                <div class="d-flex gap-2">
                    <input type="email" id="email" name="email" class="form-control form-control-custom" value="${email}" placeholder="your.email@example.com" required>
                    <button type="submit" class="btn btn-send text-white" id="sendOtpBtn">
                        <span id="otpActionBtn">Send OTP</span>
                    </button>
                </div>
            </div>
        </form>

        <hr style="margin:1.5rem 0;opacity:0.2;">

        <!-- STEP 2: Verify OTP Form -->
        <form id="verifyOtpForm" action="<c:url value='/signInWithOTP'/>" method="post">
            <input type="hidden" name="email" value="${email}"/>

            <div class="mb-3">
                <label class="form-label fw-semibold" style="font-size:0.85rem;"><i class="bi bi-key me-2"></i>Enter OTP</label>
                <input type="text" id="otp" name="otp" class="form-control form-control-custom" placeholder="Enter 6-digit OTP" maxlength="6" required>
                <div class="countdown-box" id="countdownBox" style="display:none;">
                    <div style="font-size:0.75rem;color:var(--muted);margin-bottom:4px;">Time Remaining</div>
                    <div class="countdown-num"><span id="countdown">60</span> seconds</div>
                </div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-verify text-white" id="verifyBtn">
                    <i class="bi bi-check-circle me-2"></i>Verify OTP
                </button>
            </div>

            <c:if test="${not empty wrongOTP}">
                <div class="alert alert-danger border-0 mb-0" style="border-radius:12px;background:rgba(239,68,68,0.1);color:#991b1b;">
                    <i class="bi bi-x-circle me-2"></i>${wrongOTP}
                </div>
            </c:if>
        </form>

        <div class="text-center mt-3">
            <a href="<c:url value='/signIn'/>" style="color:var(--accent);font-weight:700;text-decoration:none;font-size:0.9rem;">
                <i class="bi bi-arrow-left me-1"></i>Back to Sign In
            </a>
        </div>
    </div>
</main>

<!-- FOOTER -->
<footer>
    <p class="mb-0">© 2026 X-Workz Training Institute. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
let timeLeft = 60;
let timerRunning = false;
const countdownElement = document.getElementById('countdown');
const countdownBox = document.getElementById('countdownBox');
const otpInput = document.getElementById('otp');
const verifyForm = document.getElementById('verifyOtpForm');
const verifyBtn = document.getElementById('verifyBtn');
const sendForm = document.getElementById('sendOtpForm');
const sendButton = document.getElementById('sendOtpBtn');
const actionBtnText = document.getElementById('otpActionBtn');

// ONLY start timer if OTP was just sent
<c:if test="${not empty msg}">
    timerRunning = true;
    countdownBox.style.display = 'block';
    startCountDown();
</c:if>

function startCountDown() {
    const countdownTimer = setInterval(function() {
        timeLeft--;
        countdownElement.textContent = timeLeft;

        if (timeLeft <= 10) {
            countdownBox.style.background = 'rgba(239,68,68,0.15)';
            countdownBox.style.borderColor = '#fecaca';
        }

        if (timeLeft <= 0) {
            clearInterval(countdownTimer);
            endOtpSession();
        }
    }, 1000);
}

function endOtpSession() {
    countdownElement.textContent = 'EXPIRED';
    countdownElement.style.color = '#dc2626';

    // Disable OTP form
    otpInput.disabled = true;
    verifyBtn.disabled = true;
    sendButton.disabled = false;
    actionBtnText.textContent = "RESEND OTP";

    alert('OTP has expired! Please request a new OTP.');
}

// Block form submission if expired
verifyForm.addEventListener('submit', function(e) {
    if (timeLeft <= 0 || otpInput.disabled) {
        e.preventDefault();
        alert('OTP expired! Please request a new OTP.');
        return false;
    }
});
</script>
</body>
</html>
