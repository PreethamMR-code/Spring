<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"
    uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Verify Certificate - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fc;
        }
        .verify-header {
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            padding: 60px 0;
            color: white;
            text-align: center;
        }
        .verify-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            padding: 40px;
            max-width: 640px;
            margin: -40px auto 40px;
            position: relative;
            z-index: 10;
        }
        .valid-banner {
            background: linear-gradient(135deg,
                #f0fdf4, #dcfce7);
            border: 2px solid #22c55e;
            border-radius: 12px;
            padding: 24px;
            text-align: center;
            margin-bottom: 24px;
        }
        .invalid-banner {
            background: #fef2f2;
            border: 2px solid #ef4444;
            border-radius: 12px;
            padding: 24px;
            text-align: center;
            margin-bottom: 24px;
        }
        .cert-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.9rem;
        }
        .cert-row:last-child {
            border-bottom: none;
        }
        .cert-label {
            color: #64748b;
            font-weight: 500;
            min-width: 140px;
        }
        .cert-value {
            font-weight: 600;
            color: #0f172a;
            text-align: right;
        }
        .cert-number {
            font-family: monospace;
            font-size: 1.1rem;
            font-weight: 700;
            color: #667eea;
            letter-spacing: 0.05em;
        }
        .search-form {
            background: white;
            border-radius: 12px;
            border: 1.5px solid #e8ecf0;
            padding: 24px;
            max-width: 640px;
            margin: 0 auto 40px;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!-- Header -->
<div class="verify-header">
    <div class="container">
        <div style="font-size:2.5rem;margin-bottom:12px">
            🎓
        </div>
        <h1 style="font-weight:800;font-size:2rem;
             margin:0">
            Certificate Verification
        </h1>
        <p style="color:rgba(255,255,255,0.8);
             margin-top:8px;font-size:1rem">
            Verify the authenticity of a NexMeet
            certificate
        </p>
    </div>
</div>

<div class="container">

    <%-- ── Result Card ─────────────────────────── --%>
    <c:if test="${not empty certNumber}">
        <div class="verify-card">

            <%-- VALID certificate --%>
            <c:if test="${valid == true}">
                <div class="valid-banner">
                    <div style="font-size:2.5rem">✅</div>
                    <h4 style="color:#166534;
                         font-weight:800;margin:8px 0 4px">
                        Certificate Verified
                    </h4>
                    <p style="color:#15803d;margin:0;
                         font-size:0.9rem">
                        This is a genuine NexMeet
                        certificate of participation.
                    </p>
                </div>

                <!-- Certificate Details -->
                <div class="cert-row">
                    <span class="cert-label">
                        Certificate No.
                    </span>
                    <span class="cert-value cert-number">
                        ${cert.certificateNumber}
                    </span>
                </div>
                <div class="cert-row">
                    <span class="cert-label">
                        Issued To
                    </span>
                    <span class="cert-value">
                        ${cert.user.fullName}
                    </span>
                </div>
                <div class="cert-row">
                    <span class="cert-label">
                        Conference
                    </span>
                    <span class="cert-value">
                        ${cert.conference.title}
                    </span>
                </div>
                <div class="cert-row">
                    <span class="cert-label">
                        Conference Date
                    </span>
                    <span class="cert-value">
                        ${fn:substringBefore(
                            cert.conference.startDate
                            .toString(), 'T')}
                    </span>
                </div>
                <div class="cert-row">
                    <span class="cert-label">
                        Organized By
                    </span>
                    <span class="cert-value">
                        ${cert.conference.organizer
                            .organizationName}
                    </span>
                </div>
                <div class="cert-row">
                    <span class="cert-label">
                        Certificate Issued
                    </span>
                    <span class="cert-value">
                        ${fn:substringBefore(
                            cert.issuedAt.toString(),
                            'T')}
                    </span>
                </div>
                <div class="cert-row">
                    <span class="cert-label">
                        Reg. Number
                    </span>
                    <span class="cert-value">
                        <code>
                            ${cert.registration
                                .registrationNumber}
                        </code>
                    </span>
                </div>

                <div class="mt-4 p-3 text-center"
                     style="background:#f8f9fc;
                            border-radius:10px;
                            font-size:0.82rem;
                            color:#64748b">
                    This certificate was issued by
                    <strong>NexMeet</strong> after
                    confirmed attendance at the
                    above conference.
                </div>
            </c:if>

            <%-- INVALID — not found --%>
            <c:if test="${empty valid}">
                <div class="invalid-banner">
                    <div style="font-size:2.5rem">❌</div>
                    <h4 style="color:#991b1b;
                         font-weight:800;
                         margin:8px 0 4px">
                        Certificate Not Found
                    </h4>
                    <p style="color:#b91c1c;
                         margin:0;font-size:0.9rem">
                        No certificate with number
                        <strong>"${certNumber}"</strong>
                        was found in our system.
                    </p>
                </div>
                <div class="text-muted small
                            text-center">
                    <p>This could mean:</p>
                    <ul class="text-start
                               d-inline-block">
                        <li>The certificate number
                            was typed incorrectly</li>
                        <li>The certificate does not
                            exist in our system</li>
                        <li>The certificate may have
                            been issued on a different
                            platform</li>
                    </ul>
                </div>
            </c:if>

        </div>
    </c:if>

    <%-- ── Search Form ──────────────────────────── --%>
    <div class="search-form">
        <h5 class="fw-bold mb-3">
            🔍 Look up a Certificate
        </h5>
        <p class="text-muted small mb-3">
            Enter a NexMeet certificate number to
            verify its authenticity.
            Format: <code>NM-CERT-YYYY-XXXXXX</code>
        </p>
        <form id="verifySearchForm"
              action="${pageContext.request.contextPath}/verify"
              method="get"
              class="d-flex gap-2">
            <input type="text"
                   id="certInput"
                   name="certNumber"
                   class="form-control"
                   placeholder="NM-CERT-2026-A3F7K2"
                   value="${certNumber}"
                   style="font-family:monospace"/>
            <button type="submit"
                    class="btn btn-primary
                           px-4 fw-semibold
                           text-nowrap">
                Verify
            </button>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>

    /*
     * Use getElementById — not querySelector('form')
     * because when logged in, the navbar logout form
     * is the FIRST form in DOM and gets selected
     * instead of this search form.
     */
    var verifyForm =
        document.getElementById('verifySearchForm');
    if (verifyForm) {
        verifyForm.addEventListener(
                'submit', function(e) {
            e.preventDefault();
            var val = document
                    .getElementById('certInput')
                    .value.trim();
            if (val) {
                window.location.href =
                    '${pageContext.request.contextPath}'
                    + '/verify/'
                    + encodeURIComponent(val);
            }
        });
    }
</script>
</body>
</html>