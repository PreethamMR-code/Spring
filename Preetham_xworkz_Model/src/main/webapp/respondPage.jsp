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
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; }
        .respond-card { border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); overflow: hidden; max-width: 520px; width: 100%; }
        .respond-header { background: linear-gradient(135deg, #0d6efd, #0a58ca); padding: 2rem; text-align: center; color: white; }
        .yes-btn { background: #10b981; border: none; color: white; padding: 14px 48px; font-size: 1.1rem; border-radius: 50px; font-weight: 700; transition: all 0.2s; }
        .yes-btn:hover { background: #059669; transform: scale(1.05); }
        .no-btn  { background: #ef4444; border: none; color: white; padding: 14px 48px; font-size: 1.1rem; border-radius: 50px; font-weight: 700; transition: all 0.2s; }
        .no-btn:hover  { background: #dc2626; transform: scale(1.05); }
        .message-box { background: #f8fafc; border-left: 4px solid #0d6efd; border-radius: 0 8px 8px 0; padding: 1.25rem; line-height: 1.7; }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center py-5">
    <div class="respond-card bg-white">

        <%-- Header --%>
        <div class="respond-header">
            <div class="mb-2"><i class="bi bi-mortarboard" style="font-size:2.5rem;opacity:0.9;"></i></div>
            <h4 class="fw-bold mb-1">X-Workz Institute</h4>
            <small class="opacity-75">Response Portal</small>
        </div>

        <div class="p-4">

            <%-- ══════ CASE 1: Invalid token ══════ --%>
            <c:if test="${not empty error}">
                <div class="text-center py-3">
                    <i class="bi bi-exclamation-circle text-danger" style="font-size:3rem;"></i>
                    <h5 class="mt-3 text-danger">${error}</h5>
                    <p class="text-muted">This link may be invalid or has expired. Please contact X-Workz if you believe this is an error.</p>
                </div>
            </c:if>

            <%-- ══════ CASE 2: Already responded ══════ --%>
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
                    <small class="text-muted">Sent by: ${notification.sentBy} &nbsp;|&nbsp; Batch: ${notification.batchId}</small>
                </div>
            </c:if>

            <%-- ══════ CASE 3: Response just saved ══════ --%>
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
                    <div class="bg-light rounded p-3 mt-3 text-start">
                        <small class="text-muted">
                            <strong>Name:</strong> ${notification.studentName}<br>
                            <strong>Sent by:</strong> ${notification.sentBy}
                        </small>
                    </div>
                </div>
            </c:if>

            <%-- ══════ CASE 4: Show the question with Yes/No buttons ══════ --%>
            <c:if test="${not empty notification and empty alreadyResponded and not responseSaved and empty error}">

                <div class="mb-4">
                    <p class="text-muted small mb-1">Hello, <strong>${notification.studentName}</strong> — message from <strong>${notification.sentBy}</strong>:</p>
                    <div class="message-box">
                        ${notification.responsePageMessage}
                    </div>
                </div>

                <p class="text-center text-muted mb-4">Please select your response:</p>

                <form action="<c:url value='/respond'/>" method="post">
                    <input type="hidden" name="token" value="${token}">
                    <div class="d-flex justify-content-center gap-4">
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

        <div class="bg-light px-4 py-2 text-center border-top">
            <small class="text-muted">© 2026 X-Workz Training Institute</small>
        </div>
    </div>
</div>
</body>
</html>
