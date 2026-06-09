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
    <title>Submit Feedback – NexMeet</title>
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
        .page-header {
            background: linear-gradient(135deg,
                #667eea 0%, #764ba2 100%);
            padding: 40px 0 60px;
            color: white;
        }
        .form-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.09);
            padding: 36px;
            max-width: 600px;
            margin: -36px auto 48px;
            position: relative;
            z-index: 10;
        }
        .section-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #94a3b8;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .section-label::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #f1f5f9;
        }

        /* ── Star Rating ──────────────────────────── */
        .star-group {
            display: flex;
            flex-direction: row-reverse;
            gap: 4px;
            justify-content: flex-end;
        }
        .star-group input[type=radio] {
            display: none;
        }
        .star-group label {
            font-size: 2rem;
            cursor: pointer;
            color: #e2e8f0;
            transition: color 0.12s;
            line-height: 1;
        }
        /*
         * CSS-only star activation.
         * When a radio is checked, colour it and
         * all labels that come AFTER it in reverse-
         * flex order (i.e. all lower-value stars).
         */
        .star-group input:checked ~ label,
        .star-group label:hover,
        .star-group label:hover ~ label {
            color: #f59e0b;
        }
        .star-group input:checked ~ label {
            color: #f59e0b;
        }
        .star-rating-wrap {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 4px;
        }
        .star-label {
            font-weight: 600;
            font-size: 0.9rem;
            color: #374151;
            min-width: 160px;
        }
        .required-dot {
            color: #ef4444;
            margin-left: 2px;
        }
        .optional-tag {
            font-size: 0.72rem;
            color: #94a3b8;
            font-weight: 400;
        }
        .rating-desc {
            font-size: 0.72rem;
            color: #94a3b8;
            margin-top: 2px;
            min-width: 60px;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.88rem;
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
        .form-control::placeholder {
            color: #94a3b8;
        }
        .form-text {
            font-size: 0.76rem;
            color: #94a3b8;
        }

        .btn-submit {
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
            transition: opacity 0.15s,
                        transform 0.15s,
                        box-shadow 0.15s;
        }
        .btn-submit:hover {
            opacity: 0.9;
            transform: translateY(-1px);
            box-shadow: 0 8px 24px
                rgba(102,126,234,0.3);
        }
        .btn-cancel {
            border: 1.5px solid #e2e8f0;
            background: white;
            color: #374151;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            text-decoration: none;
            transition: all 0.15s;
        }
        .btn-cancel:hover {
            border-color: #94a3b8;
            color: #0f172a;
        }

        .conf-info-box {
            background: #f8f7ff;
            border: 1px solid #e0d9ff;
            border-radius: 10px;
            padding: 14px 16px;
            margin-bottom: 28px;
        }
        .conf-title {
            font-weight: 700;
            color: #0f172a;
            font-size: 0.95rem;
        }
        .conf-meta {
            font-size: 0.8rem;
            color: #64748b;
            margin-top: 4px;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<%-- Page Header --%>
<div class="page-header">
    <div class="container">
        <div style="font-size:0.8rem;
             color:rgba(255,255,255,0.7);
             margin-bottom:6px">
            <a href="${pageContext.request.contextPath}/delegate/dashboard"
               style="color:rgba(255,255,255,0.7);
                      text-decoration:none">
                My Dashboard
            </a>
            → Feedback
        </div>
        <h2 style="font-weight:800;margin:0;
             letter-spacing:-0.02em">
            ⭐ Submit Feedback
        </h2>
        <p style="color:rgba(255,255,255,0.75);
             margin-top:6px;font-size:0.92rem">
            Help improve future conferences
            with your honest feedback
        </p>
    </div>
</div>

<div class="container">
<div class="form-card">

    <%-- Conference Info --%>
    <div class="conf-info-box">
        <div class="conf-title">
            ${conference.title}
        </div>
        <div class="conf-meta">
            ${conference.conferenceType}
            · ${conference.mode}
            · ${fn:substringBefore(
                conference.startDate.toString(), 'T')}
        </div>
        <div class="conf-meta" style="margin-top:2px">
            Organized by:
            <strong>
                ${conference.organizer.organizationName}
            </strong>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/delegate/conference/${conferenceId}/feedback"
          method="post">
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>

        <%-- ── Star Ratings ────────────────────── --%>
        <div class="section-label">
            ⭐ Your Ratings
        </div>

        <%--
            Overall Rating — REQUIRED
            Uses CSS reverse-flex trick for star hover.
            Radio values 5→1 placed in DOM order, flex
            reverses display so 1 star appears leftmost.
        --%>
        <div style="margin-bottom:20px">
            <div class="star-rating-wrap">
                <div class="star-label">
                    Overall Experience
                    <span class="required-dot">*</span>
                </div>
                <div class="star-group"
                     id="overallGroup">
                    <input type="radio"
                           id="overall5"
                           name="overallRating"
                           value="5" required/>
                    <label for="overall5"
                           title="5 – Excellent">★</label>

                    <input type="radio"
                           id="overall4"
                           name="overallRating"
                           value="4"/>
                    <label for="overall4"
                           title="4 – Good">★</label>

                    <input type="radio"
                           id="overall3"
                           name="overallRating"
                           value="3"/>
                    <label for="overall3"
                           title="3 – Average">★</label>

                    <input type="radio"
                           id="overall2"
                           name="overallRating"
                           value="2"/>
                    <label for="overall2"
                           title="2 – Below Average">★</label>

                    <input type="radio"
                           id="overall1"
                           name="overallRating"
                           value="1"/>
                    <label for="overall1"
                           title="1 – Poor">★</label>
                </div>
                <div class="rating-desc"
                     id="overallDesc">
                </div>
            </div>
        </div>

        <div style="margin-bottom:20px">
            <div class="star-rating-wrap">
                <div class="star-label">
                    Organization
                    <span class="optional-tag">
                        (optional)
                    </span>
                </div>
                <div class="star-group">
                    <input type="radio"
                           id="org5"
                           name="organizationRating"
                           value="5"/>
                    <label for="org5"
                           title="5 – Excellent">★</label>

                    <input type="radio"
                           id="org4"
                           name="organizationRating"
                           value="4"/>
                    <label for="org4"
                           title="4 – Good">★</label>

                    <input type="radio"
                           id="org3"
                           name="organizationRating"
                           value="3"/>
                    <label for="org3"
                           title="3 – Average">★</label>

                    <input type="radio"
                           id="org2"
                           name="organizationRating"
                           value="2"/>
                    <label for="org2"
                           title="2 – Below Average">★</label>

                    <input type="radio"
                           id="org1"
                           name="organizationRating"
                           value="1"/>
                    <label for="org1"
                           title="1 – Poor">★</label>
                </div>
            </div>
        </div>

        <div style="margin-bottom:20px">
            <div class="star-rating-wrap">
                <div class="star-label">
                    Content Quality
                    <span class="optional-tag">
                        (optional)
                    </span>
                </div>
                <div class="star-group">
                    <input type="radio"
                           id="cont5"
                           name="contentRating"
                           value="5"/>
                    <label for="cont5"
                           title="5 – Excellent">★</label>

                    <input type="radio"
                           id="cont4"
                           name="contentRating"
                           value="4"/>
                    <label for="cont4"
                           title="4 – Good">★</label>

                    <input type="radio"
                           id="cont3"
                           name="contentRating"
                           value="3"/>
                    <label for="cont3"
                           title="3 – Average">★</label>

                    <input type="radio"
                           id="cont2"
                           name="contentRating"
                           value="2"/>
                    <label for="cont2"
                           title="2 – Below Average">★</label>

                    <input type="radio"
                           id="cont1"
                           name="contentRating"
                           value="1"/>
                    <label for="cont1"
                           title="1 – Poor">★</label>
                </div>
            </div>
        </div>

        <div style="margin-bottom:24px">
            <div class="star-rating-wrap">
                <div class="star-label">
                    Speakers
                    <span class="optional-tag">
                        (optional)
                    </span>
                </div>
                <div class="star-group">
                    <input type="radio"
                           id="spk5"
                           name="speakerRating"
                           value="5"/>
                    <label for="spk5"
                           title="5 – Excellent">★</label>

                    <input type="radio"
                           id="spk4"
                           name="speakerRating"
                           value="4"/>
                    <label for="spk4"
                           title="4 – Good">★</label>

                    <input type="radio"
                           id="spk3"
                           name="speakerRating"
                           value="3"/>
                    <label for="spk3"
                           title="3 – Average">★</label>

                    <input type="radio"
                           id="spk2"
                           name="speakerRating"
                           value="2"/>
                    <label for="spk2"
                           title="2 – Below Average">★</label>

                    <input type="radio"
                           id="spk1"
                           name="speakerRating"
                           value="1"/>
                    <label for="spk1"
                           title="1 – Poor">★</label>
                </div>
            </div>
        </div>

        <%-- ── Comments ────────────────────────── --%>
        <div class="section-label">
            💬 Your Comments
        </div>

        <div class="mb-4">
            <label class="form-label" for="comments">
                Share your experience
                <span class="optional-tag">
                    (optional)
                </span>
            </label>
            <textarea id="comments"
                      name="comments"
                      class="form-control"
                      rows="4"
                      maxlength="2000"
                      placeholder="What did you enjoy most? What could be improved? Any suggestions for future events..."></textarea>
            <div class="form-text">
                Maximum 2000 characters.
                Your feedback will be visible to
                the organizer and publicly on the
                conference page.
            </div>
        </div>

        <div style="display:flex;gap:12px;
                    align-items:center;
                    flex-wrap:wrap">
            <button type="submit"
                    class="btn-submit">
                ⭐ Submit Feedback
            </button>
            <a href="${pageContext.request.contextPath}/delegate/dashboard"
               class="btn-cancel">
                Cancel
            </a>
        </div>
    </form>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>
/*
 * Show rating description text next to stars.
 * Updates as user selects a rating.
 */
var labels = {
    1: 'Poor',
    2: 'Below Average',
    3: 'Average',
    4: 'Good',
    5: 'Excellent'
};

document.querySelectorAll(
    'input[name="overallRating"]'
).forEach(function(radio) {
    radio.addEventListener('change', function() {
        var desc =
            document.getElementById('overallDesc');
        if (desc) {
            desc.textContent =
                labels[this.value] || '';
        }
    });
});
</script>
</body>
</html>