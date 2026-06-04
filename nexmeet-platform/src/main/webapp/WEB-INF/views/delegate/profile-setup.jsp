<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Complete Your Profile – NexMeet</title>
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
                #667eea 0%, #764ba2 100%);
            padding: 48px 0 64px;
            color: white;
            text-align: center;
        }
        .setup-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.09);
            padding: 36px;
            max-width: 540px;
            margin: -36px auto 48px;
            position: relative;
            z-index: 10;
        }
        .why-box {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            border-radius: 10px;
            padding: 14px 16px;
            font-size: 0.85rem;
            color: #166534;
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
        .form-control {
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 11px 14px;
            font-size: 0.93rem;
            font-family: 'Inter', sans-serif;
            background: #fafbfc;
            transition: border-color 0.15s,
                        box-shadow 0.15s;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px
                rgba(102,126,234,0.12);
            background: white;
        }
        .form-control::placeholder { color: #94a3b8; }
        .form-text {
            font-size: 0.76rem;
            color: #94a3b8;
            margin-top: 4px;
        }
        .btn-save {
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 13px 32px;
            font-weight: 700;
            font-size: 0.97rem;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: opacity 0.15s, transform 0.15s;
        }
        .btn-save:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
        .btn-skip {
            border: 1.5px solid #e2e8f0;
            background: white;
            color: #94a3b8;
            border-radius: 10px;
            padding: 12px 20px;
            font-size: 0.88rem;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.15s;
        }
        .btn-skip:hover {
            border-color: #94a3b8;
            color: #64748b;
        }
        .divider-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #94a3b8;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<%-- Gradient header --%>
<div class="setup-header">
    <div style="font-size:2.4rem;margin-bottom:10px">
        🎓
    </div>
    <h1 style="font-weight:800;font-size:1.8rem;
         margin:0;letter-spacing:-0.02em">
        Complete Your Profile
    </h1>
    <p style="color:rgba(255,255,255,0.78);
         margin-top:8px;font-size:0.95rem">
        One-time setup — takes 30 seconds
    </p>
</div>

<div class="container">
    <div class="setup-card">

        <%-- Why this matters --%>
        <div class="why-box">
            <span style="font-size:1.1rem;
                  flex-shrink:0">
                ℹ️
            </span>
            <div>
                <strong>Why is this needed?</strong>
                Organizers use your profile to know who is
                attending their conference. This is required
                before you can register for any event.
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

        <form action="${pageContext.request.contextPath}/delegate/profile/setup"
              method="post">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>

            <div class="mb-3">
                <label class="form-label"
                       for="organization">
                    Organization / Institution
                </label>
                <input type="text"
                       id="organization"
                       name="organization"
                       class="form-control"
                       placeholder="e.g. IIT Bangalore, Infosys Ltd, Self-employed"
                       value="${dto.organization}"/>
                <div class="form-text">
                    Company, college or institution you
                    are affiliated with.
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label"
                       for="designation">
                    Designation / Role
                </label>
                <input type="text"
                       id="designation"
                       name="designation"
                       class="form-control"
                       placeholder="e.g. Software Engineer, PhD Student, Manager"
                       value="${dto.designation}"/>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-6">
                    <label class="form-label"
                           for="city">
                        City
                    </label>
                    <input type="text"
                           id="city"
                           name="city"
                           class="form-control"
                           placeholder="Bengaluru"
                           value="${dto.city}"/>
                </div>
                <div class="col-6">
                    <label class="form-label"
                           for="state">
                        State
                    </label>
                    <input type="text"
                           id="state"
                           name="state"
                           class="form-control"
                           placeholder="Karnataka"
                           value="${dto.state}"/>
                </div>
            </div>

            <div class="d-flex gap-3 align-items-center">
                <button type="submit" class="btn-save">
                    Save Profile →
                </button>
                <a href="${pageContext.request.contextPath}/delegate/dashboard"
                   class="btn-skip"
                   onclick="return confirm(
                       'Without completing your profile, you cannot register for conferences.\n\nSkip anyway?')">
                    Skip for now
                </a>
            </div>
            <div class="form-text mt-2"
                 style="color:#ef4444">
                ⚠️ Skipping blocks conference registration
                until your profile is complete.
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>