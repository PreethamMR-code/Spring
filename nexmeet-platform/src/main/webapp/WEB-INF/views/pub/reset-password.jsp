<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Reset Password – NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; min-height: 100vh; margin: 0; display: flex; background: #f8f9fc; -webkit-font-smoothing: antialiased; }
        .left-panel { width: 46%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; flex-direction: column; justify-content: center; padding: 56px 52px; position: relative; overflow: hidden; }
        .left-panel::before { content: ''; position: absolute; top: -120px; right: -100px; width: 450px; height: 450px; background: rgba(255,255,255,0.07); border-radius: 50%; }
        .left-brand { font-size: 1.9rem; font-weight: 800; color: white; margin-bottom: 40px; }
        .left-headline { font-size: 2rem; font-weight: 800; color: white; line-height: 1.2; margin-bottom: 14px; }
        .left-sub { font-size: 1rem; color: rgba(255,255,255,0.78); line-height: 1.7; max-width: 340px; }
        .req-item { display:flex; align-items:center; gap:10px; color:rgba(255,255,255,0.85); font-size:0.88rem; margin-bottom:12px; }
        .right-panel { flex: 1; display: flex; align-items: center; justify-content: center; padding: 40px 32px; background: white; }
        .box { width: 100%; max-width: 400px; }
        .box-title { font-size: 1.8rem; font-weight: 800; color: #0f172a; margin-bottom: 6px; }
        .box-sub { font-size: 0.92rem; color: #64748b; margin-bottom: 28px; }
        .field-label { font-weight: 600; font-size: 0.85rem; color: #374151; margin-bottom: 6px; display: block; }
        .field-input { width: 100%; border: 1.5px solid #e2e8f0; border-radius: 10px; padding: 12px 14px; font-size: 0.95rem; font-family: 'Inter', sans-serif; transition: border-color 0.15s, box-shadow 0.15s; background: #fafbfc; color: #0f172a; outline: none; }
        .field-input:focus { border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.12); background: white; }
        .password-wrap { position: relative; }
        .password-wrap .field-input { padding-right: 48px; }
        .toggle-pw { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; padding: 0; color: #94a3b8; font-size: 1rem; transition: color 0.15s; }
        .toggle-pw:hover { color: #667eea; }
        .strength-bar { height: 6px; background: #f1f5f9; border-radius: 3px; margin-top: 8px; overflow: hidden; }
        .strength-fill { height: 100%; border-radius: 3px; transition: width 0.3s, background 0.3s; width: 0%; }
        .strength-text { font-size: 0.75rem; color: #94a3b8; margin-top: 4px; }
        .btn-main { display: block; width: 100%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 10px; padding: 13px; font-weight: 700; font-size: 1rem; font-family: 'Inter', sans-serif; cursor: pointer; transition: opacity 0.15s, transform 0.15s; margin-top: 8px; }
        .btn-main:hover { opacity: 0.92; transform: translateY(-1px); }
        .alert-error { background:#fef2f2; border:1px solid #fecaca; border-radius:10px; padding:12px 14px; color:#991b1b; font-size:0.88rem; margin-bottom:20px; }
        .back-link { text-align:center; margin-top:20px; font-size:0.85rem; color:#64748b; }
        .back-link a { color:#667eea; text-decoration:none; font-weight:600; }
        @media (max-width: 768px) { body { display: block; } .left-panel { display: none; } .right-panel { min-height: 100vh; padding: 40px 20px; } }
    </style>
</head>
<body>

<div class="left-panel">
    <div style="position:relative;z-index:1">
        <div class="left-brand">NexMeet</div>
        <div class="left-headline">Choose a new<br/>password</div>
        <p class="left-sub" style="margin-bottom:28px">
            Pick something strong that you haven't used before.
        </p>
        <div class="req-item">🔒 At least 8 characters</div>
        <div class="req-item">✅ Use letters, numbers, and symbols</div>
        <div class="req-item">⚠️ Link expires in 1 hour</div>
    </div>
</div>

<div class="right-panel">
    <div class="box">
        <div class="box-title">New Password</div>
        <div class="box-sub">Enter and confirm your new password</div>

        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password"
              method="post"
              onsubmit="return validateForm()">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>
            <%-- Token passed as hidden field, not in URL on POST --%>
            <input type="hidden"
                   name="token"
                   value="${token}"/>

            <div style="margin-bottom:16px">
                <label class="field-label" for="newPassword">
                    New Password
                </label>
                <div class="password-wrap">
                    <input type="password"
                           id="newPassword"
                           name="newPassword"
                           class="field-input"
                           placeholder="Min. 8 characters"
                           autofocus
                           required
                           oninput="checkStrength(this.value)"/>
                    <button type="button" class="toggle-pw"
                            onclick="togglePwd('newPassword')"
                            tabindex="-1">👁</button>
                </div>
                <div class="strength-bar">
                    <div class="strength-fill" id="strengthFill"></div>
                </div>
                <div class="strength-text" id="strengthText"></div>
            </div>

            <div style="margin-bottom:20px">
                <label class="field-label" for="confirmPassword">
                    Confirm New Password
                </label>
                <div class="password-wrap">
                    <input type="password"
                           id="confirmPassword"
                           name="confirmPassword"
                           class="field-input"
                           placeholder="Repeat your password"
                           required/>
                    <button type="button" class="toggle-pw"
                            onclick="togglePwd('confirmPassword')"
                            tabindex="-1">👁</button>
                </div>
                <div id="matchMsg"
                     style="font-size:0.75rem;margin-top:4px"></div>
            </div>

            <button type="submit" class="btn-main" id="submitBtn">
                Reset Password →
            </button>
        </form>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/forgot-password">
                ← Request a new link
            </a>
        </div>
    </div>
</div>

<script>
function togglePwd(id) {
    var f = document.getElementById(id);
    f.type = f.type === 'password' ? 'text' : 'password';
}

function checkStrength(val) {
    var fill = document.getElementById('strengthFill');
    var text = document.getElementById('strengthText');
    var score = 0;
    if (val.length >= 8) score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;

    var colors = ['#ef4444','#f97316','#eab308','#22c55e'];
    var labels = ['Weak','Fair','Good','Strong'];
    var widths = ['25%','50%','75%','100%'];

    if (val.length === 0) {
        fill.style.width = '0%';
        text.textContent = '';
    } else {
        var idx = Math.min(score - 1, 3);
        if (idx < 0) idx = 0;
        fill.style.width = widths[idx];
        fill.style.background = colors[idx];
        text.textContent = labels[idx];
        text.style.color = colors[idx];
    }
}

document.getElementById('confirmPassword')
    .addEventListener('input', function() {
        var pw = document.getElementById('newPassword').value;
        var msg = document.getElementById('matchMsg');
        if (this.value.length === 0) {
            msg.textContent = '';
        } else if (this.value === pw) {
            msg.textContent = '✅ Passwords match';
            msg.style.color = '#16a34a';
        } else {
            msg.textContent = '❌ Passwords do not match';
            msg.style.color = '#dc2626';
        }
    });

function validateForm() {
    var pw = document.getElementById('newPassword').value;
    var cpw = document.getElementById('confirmPassword').value;
    if (pw !== cpw) {
        alert('Passwords do not match.');
        return false;
    }
    if (pw.length < 8) {
        alert('Password must be at least 8 characters.');
        return false;
    }
    return true;
}
</script>

</body>
</html>