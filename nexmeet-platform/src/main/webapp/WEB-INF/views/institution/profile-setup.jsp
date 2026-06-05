<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Institution Profile Setup – NexMeet</title>
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
        .setup-header {
            background: linear-gradient(135deg,
                #0ea5e9 0%, #0284c7 100%);
            padding: 48px 0 64px;
            color: white;
            text-align: center;
        }
        .setup-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.09);
            padding: 36px;
            max-width: 560px;
            margin: -36px auto 48px;
            position: relative;
            z-index: 10;
        }
        .info-box {
            background: #f0f9ff;
            border: 1px solid #bae6fd;
            border-radius: 10px;
            padding: 14px 16px;
            font-size: 0.85rem;
            color: #075985;
            margin-bottom: 24px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }
        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #374151;
        }
        .form-control,
        .form-select {
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 11px 14px;
            font-size: 0.93rem;
            font-family: 'Inter', sans-serif;
            background: #fafbfc;
            transition: border-color 0.15s,
                        box-shadow 0.15s;
        }
        .form-control:focus,
        .form-select:focus {
            border-color: #0ea5e9;
            box-shadow: 0 0 0 3px
                rgba(14,165,233,0.12);
            background: white;
        }
        .form-control::placeholder { color: #94a3b8; }
        .form-text {
            font-size: 0.76rem;
            color: #94a3b8;
            margin-top: 4px;
        }
        .btn-submit {
            background: linear-gradient(135deg,
                #0ea5e9 0%, #0284c7 100%);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 13px;
            width: 100%;
            font-weight: 700;
            font-size: 0.97rem;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: opacity 0.15s, transform 0.15s;
        }
        .btn-submit:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
        .section-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #94a3b8;
            margin-bottom: 14px;
            margin-top: 24px;
            display: block;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<%-- Gradient header --%>
<div class="setup-header">
    <div style="font-size:2.4rem;margin-bottom:10px">
        🏫
    </div>
    <h1 style="font-weight:800;font-size:1.8rem;
         margin:0;letter-spacing:-0.02em">
        Set Up Institutional Admin Profile
    </h1>
    <p style="color:rgba(255,255,255,0.78);
         margin-top:8px;font-size:0.95rem">
        Link your account to your institution
    </p>
</div>

<div class="container">
    <div class="setup-card">

        <div class="info-box">
            <span style="font-size:1.1rem;
                  flex-shrink:0">
                ℹ️
            </span>
            <div>
                Select your institution and enter your
                role. The NexMeet admin team will verify
                your account before you can perform bulk
                registrations for your students or employees.
            </div>
        </div>

        <c:if test="${not empty error}">
            <div style="background:#fef2f2;
                        border:1px solid #fecaca;
                        border-radius:10px;
                        padding:12px 14px;
                        color:#991b1b;
                        font-size:0.88rem;
                        margin-bottom:20px;
                        display:flex;gap:10px">
                <span>⚠️</span>
                <span>${error}</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/institution/profile/setup"
              method="post">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>

            <span class="section-label"
                  style="margin-top:0">
                Institution Details
            </span>

            <div class="mb-3">
                <label class="form-label"
                       for="institutionId">
                    Your Institution *
                </label>
                <select name="institutionId"
                        id="institutionId"
                        class="form-select"
                        required>
                    <option value="">
                        Select your institution...
                    </option>
                    <c:forEach var="inst"
                               items="${institutions}">
                        <option value="${inst.id}">
                            ${inst.name}
                            (${inst.type})
                            — ${inst.city}
                        </option>
                    </c:forEach>
                </select>
                <div class="form-text">
                    Don't see your institution?
                    Contact the NexMeet admin to add it
                    at <strong>admin@nexmeet.com</strong>.
                </div>
            </div>

            <span class="section-label">Your Role</span>

            <div class="mb-3">
                <label class="form-label"
                       for="jobTitle">
                    Job Title
                </label>
                <input type="text"
                       id="jobTitle"
                       name="jobTitle"
                       class="form-control"
                       placeholder="e.g. HOD, Placement Officer, HR Manager"/>
            </div>

            <div class="mb-4">
                <label class="form-label"
                       for="department">
                    Department
                </label>
                <input type="text"
                       id="department"
                       name="department"
                       class="form-control"
                       placeholder="e.g. CSE, MBA, Human Resources"/>
            </div>

            <button type="submit" class="btn-submit">
                Submit Profile for Verification →
            </button>
            <div class="form-text text-center mt-2">
                You'll be notified by email and
                in-app once your account is approved.
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>