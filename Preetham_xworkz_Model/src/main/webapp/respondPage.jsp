<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Respond | X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --navy:#0f172a; --accent:#3b82f6; --text:#1e293b; --muted:#64748b; }
        * { box-sizing:border-box; }
        body { font-family:'Inter',sans-serif; background:linear-gradient(135deg,#1e3a5f 0%,#0f172a 60%,#1e293b 100%); min-height:100vh; display:flex; align-items:center; justify-content:center; padding:1rem; }
        h1,h2,h3,h4,h5,h6 { font-family:'Sora',sans-serif; }

        .respond-card { background:rgba(255,255,255,0.98); border-radius:24px; box-shadow:0 20px 60px rgba(0,0,0,0.3); overflow:hidden; max-width:540px; width:100%; }
        .respond-header { background:linear-gradient(135deg,var(--accent),#2563eb); padding:2rem; text-align:center; color:white; }
        .respond-header i { font-size:2.5rem; opacity:0.95; margin-bottom:0.5rem; }
        .respond-body { padding:2.5rem; }
        .message-box { background:#f8fafc; border-left:4px solid var(--accent); border-radius:0 12px 12px 0; padding:1.25rem; line-height:1.7; margin-bottom:1.5rem; }
        .yes-btn { background:#10b981; border:none; color:white; padding:0.9rem 3rem; font-size:1.1rem; border-radius:50px; font-weight:700; transition:all 0.2s; font-family:'Sora',sans-serif; }
        .yes-btn:hover { background:#059669; transform:scale(1.05); box-shadow:0 8px 24px rgba(16,185,129,0.4); }
        .no-btn { background:#ef4444; border:none; color:white; padding:0.9rem 3rem; font-size:1.1rem; border-radius:50px; font-weight:700; transition:all 0.2s; font-family:'Sora',sans-serif; }
        .no-btn:hover { background:#dc2626; transform:scale(1.05); box-shadow:0 8px 24px rgba(239,68,68,0.4); }
        .respond-footer { background:#f8fafc; padding:1rem; text-align:center; border-top:1px solid #e2e8f0; color:var(--muted); font-size:0.85rem; }
    </style>
</head>
<body>

<div class="respond-card">
    <div class="respond-header">
        <i class="bi bi-mortarboard"></i>
        <h4 class="fw-bold mb-1">X-Workz Institute</h4>
        <small style="opacity:0.85;">Response Portal</small>
    </div>

    <div class="respond-body">
        <%-- CASE 1: Invalid token --%>
        <c:if test="${not empty error}">
            <div class="text-center py-3">
                <i class="bi bi-exclamation-circle text-danger" style="font-size:3.5rem;"></i>
                <h5 class="mt-3 text-danger fw-bold">${error}</h5>
                <p class="text-muted">This link may be invalid or has expired. Please contact X-Workz if you believe this is an error.</p>
            </div>
        </c:if>

        <%-- CASE 2: Already responded --%>
        <c:if test="${alreadyResponded}">
            <div class="text-center py-3">
                <c:choose>
                    <c:when test="${previousResponse == 'YES'}">
                        <i class="bi bi-check-circle-fill text-success" style="font-size:3.5rem;"></i>
                        <h4 class="mt-3 fw-bold text-success">You already responded: YES</h4>
                    </c:when>
                    <c:otherwise>
                        <i class="bi bi-x-circle-fill text-danger" style="font-size:3.5rem;"></i>
                        <h4 class="mt-3 fw-bold text-danger">You already responded: NO</h4>
                    </c:otherwise>
                </c:choose>
                <p class="text-muted mt-2">Your response has already been recorded. Thank you!</p>
                <small class="text-muted">Sent by: ${notification.sentBy}</small>
            </div>
        </c:if>

        <%-- CASE 3: Response just saved --%>
        <c:if test="${responseSaved}">
            <div class="text-center py-3">
                <c:choose>
                    <c:when test="${chosenResponse == 'YES'}">
                        <i class="bi bi-check-circle-fill text-success" style="font-size:3.5rem;"></i>
                        <h4 class="mt-3 fw-bold text-success">Thank you! You said YES ✅</h4>
                        <p class="text-muted mt-2">Your response has been recorded. X-Workz will follow up with you shortly.</p>
                    </c:when>
                    <c:otherwise>
                        <i class="bi bi-x-circle-fill text-danger" style="font-size:3.5rem;"></i>
                        <h4 class="mt-3 fw-bold text-danger">Response recorded: NO ❌</h4>
                        <p class="text-muted mt-2">Your response has been recorded. If you change your mind, please contact X-Workz directly.</p>
                    </c:otherwise>
                </c:choose>
                <div style="background:#f8fafc;border-radius:12px;padding:1rem;margin-top:1rem;text-align:left;">
                    <small class="text-muted">
                        <strong>Name:</strong> ${notification.studentName}<br>
                        <strong>Sent by:</strong> ${notification.sentBy}
                    </small>
                </div>
            </div>
        </c:if>

        <%-- CASE 4: Show YES/NO buttons --%>
        <c:if test="${not empty notification and empty alreadyResponded and not responseSaved and empty error}">
            <p class="text-muted small mb-2">Hello, <strong>${notification.studentName}</strong> — message from <strong>${notification.sentBy}</strong>:</p>
            <div class="message-box">${notification.responsePageMessage}</div>

            <p class="text-center text-muted mb-3">Please select your response:</p>

            <form action="<c:url value='/respond'/>" method="post">
                <input type="hidden" name="token" value="${token}">
                <div class="d-flex justify-content-center gap-3">
                    <button type="submit" name="response" value="YES" class="yes-btn">
                        <i class="bi bi-check2 me-2"></i>Yes
                    </button>
                    <button type="submit" name="response" value="NO" class="no-btn">
                        <i class="bi bi-x-lg me-2"></i>No
                    </button>
                </div>
            </form>

            <p class="text-center text-muted mt-4 small">
                <i class="bi bi-shield-check me-1"></i>Your response is private and only visible to X-Workz staff.
            </p>
        </c:if>
    </div>

    <div class="respond-footer">
        © 2026 X-Workz Training Institute
    </div>
</div>

</body>
</html>
