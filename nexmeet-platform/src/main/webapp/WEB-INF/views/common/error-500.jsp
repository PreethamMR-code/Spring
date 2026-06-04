<%@ page contentType="text/html;charset=UTF-8"
         isErrorPage="true" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>500 – Server Error · NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: #fffbeb;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            -webkit-font-smoothing: antialiased;
        }
        .brand {
            font-size: 1.4rem;
            font-weight: 800;
            background: linear-gradient(135deg,
                #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-decoration: none;
            margin-bottom: 48px;
        }
        .error-wrap {
            text-align: center;
            max-width: 480px;
        }
        .error-emoji {
            font-size: 4rem;
            margin-bottom: 8px;
            line-height: 1;
        }
        .error-code {
            font-size: 7rem;
            font-weight: 800;
            color: #fde68a;
            line-height: 1;
            letter-spacing: -0.04em;
        }
        .error-title {
            font-size: 1.6rem;
            font-weight: 800;
            color: #0f172a;
            margin: 12px 0 12px;
            letter-spacing: -0.02em;
        }
        .error-desc {
            color: #64748b;
            font-size: 0.95rem;
            line-height: 1.7;
            margin-bottom: 32px;
        }
        .btn-home {
            background: linear-gradient(135deg,
                #f59e0b, #d97706);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 28px;
            font-weight: 700;
            font-size: 0.95rem;
            text-decoration: none;
            transition: opacity 0.15s, transform 0.15s;
        }
        .btn-home:hover {
            opacity: 0.9;
            color: white;
            transform: translateY(-1px);
        }
        .btn-retry {
            border: 1.5px solid #e2e8f0;
            background: white;
            color: #374151;
            border-radius: 10px;
            padding: 11px 24px;
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.15s;
        }
        .btn-retry:hover {
            border-color: #f59e0b;
            color: #d97706;
        }
        .info-box {
            background: white;
            border: 1px solid #fde68a;
            border-radius: 12px;
            padding: 16px 20px;
            margin-top: 28px;
            text-align: left;
            font-size: 0.82rem;
            color: #64748b;
            line-height: 1.6;
        }
        .info-box strong {
            color: #0f172a;
            display: block;
            margin-bottom: 4px;
        }
    </style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/"
       class="brand">
        NexMeet
    </a>

    <div class="error-wrap">
        <div class="error-emoji">⚙️</div>
        <div class="error-code">500</div>
        <div class="error-title">Something Went Wrong</div>
        <p class="error-desc">
            An unexpected error occurred on our end.
            This is not your fault. Please try again
            in a moment, or go back to safety.
        </p>

        <div class="d-flex justify-content-center
                    gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/"
               class="btn-home">
                ← Go to Home
            </a>
            <a href="javascript:location.reload()"
               class="btn-retry">
                Try Again
            </a>
        </div>

        <div class="info-box">
            <strong>What can I do?</strong>
            Refresh the page and try again. If the
            problem keeps happening, the team has
            been notified and is working on a fix.
            You can also try clearing your browser
            cache or using a different browser.
        </div>
    </div>

</body>
</html>