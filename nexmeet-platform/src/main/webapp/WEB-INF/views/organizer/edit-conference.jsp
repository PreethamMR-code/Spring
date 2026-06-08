<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1"/>
    <title>Edit Conference – NexMeet</title>
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
                #10b981 0%, #059669 100%);
            padding: 36px 0 56px;
            color: white;
        }
        .form-wrap {
            max-width: 860px;
            margin: -32px auto 48px;
            position: relative;
            z-index: 10;
        }
        .form-card {
            background: white;
            border-radius: 14px;
            border: 1.5px solid #e8ecf0;
            padding: 28px;
            margin-bottom: 18px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .section-label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #94a3b8;
            margin-bottom: 20px;
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
        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #374151;
        }
        .form-control,
        .form-select {
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 10px 14px;
            font-size: 0.92rem;
            font-family: 'Inter', sans-serif;
            background: #fafbfc;
            transition: border-color 0.15s,
                        box-shadow 0.15s;
        }
        .form-control:focus,
        .form-select:focus {
            border-color: #10b981;
            box-shadow: 0 0 0 3px
                rgba(16,185,129,0.12);
            background: white;
        }
        .form-control::placeholder { color: #94a3b8; }
        .form-text {
            font-size: 0.76rem;
            color: #94a3b8;
            margin-top: 4px;
        }
        .feature-card {
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            padding: 16px;
            height: 100%;
            cursor: pointer;
            transition: all 0.15s;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        .feature-card:hover {
            border-color: #10b981;
            background: #f0fdf4;
        }
        .feature-card input[type=checkbox] {
            width: 18px;
            height: 18px;
            flex-shrink: 0;
            margin-top: 2px;
            cursor: pointer;
            accent-color: #10b981;
        }
        .feature-title {
            font-weight: 700;
            font-size: 0.88rem;
            color: #0f172a;
            margin-bottom: 4px;
        }
        .feature-desc {
            font-size: 0.77rem;
            color: #64748b;
            line-height: 1.5;
        }
        .btn-submit-conf {
            background: linear-gradient(135deg,
                #10b981, #059669);
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
        .btn-submit-conf:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
        .btn-draft {
            border: 1.5px solid #e2e8f0;
            background: white;
            color: #374151;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 600;
            font-size: 0.95rem;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: all 0.15s;
        }
        .btn-draft:hover {
            border-color: #94a3b8;
        }
    </style>
</head>
<body>

<%--
    CRITICAL FIX: Navbar was missing in original
    edit-conference.jsp — added here.
--%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <div style="font-size:0.82rem;
             color:rgba(255,255,255,0.7);
             margin-bottom:6px">
            <a href="${pageContext.request.contextPath}/organizer/conferences"
               style="color:rgba(255,255,255,0.7);
                      text-decoration:none">
                My Conferences
            </a>
            → Edit
        </div>
        <h2 style="font-weight:800;margin:0;
             letter-spacing:-0.02em">
            ✏️ Edit Conference
        </h2>
        <p style="color:rgba(255,255,255,0.75);
             margin-top:6px;font-size:0.92rem">
            Update details and resubmit for approval.
        </p>
    </div>
</div>

<div class="container">
<div class="form-wrap">

    <%--
        REJECTION REASON BANNER
        Controller now passes rejectionReason to model.
        Previously this was missing and organizers had
        no way to know WHY their conference was rejected.
    --%>
    <c:if test="${currentStatus.name() == 'REJECTED'}">
        <div style="background:#fef2f2;
                    border:2px solid #fecaca;
                    border-radius:12px;
                    padding:16px 20px;
                    margin-bottom:20px">
            <div style="font-weight:800;
                 color:#991b1b;font-size:1rem;
                 margin-bottom:4px">
                ❌ Conference Rejected
            </div>
            <div style="color:#b91c1c;
                 font-size:0.88rem;
                 line-height:1.6">
                This conference was rejected by the
                admin. Fix the issues noted below and
                resubmit.
                <c:if test="${not empty rejectionReason}">
                    <br/>
                    <strong>Reason:</strong>
                    ${rejectionReason}
                </c:if>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div style="background:#fef2f2;
                    border:1px solid #fecaca;
                    border-radius:10px;
                    padding:12px 16px;
                    color:#991b1b;
                    font-size:0.88rem;
                    display:flex;gap:10px;
                    margin-bottom:20px">
            <span>⚠️</span>
            <span>${error}</span>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/organizer/conference/${confId}/edit"
          method="post"
          id="editForm">
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>

        <%-- ── 1. BASIC INFO ──────────────────────────── --%>
        <div class="form-card">
            <div class="section-label">
                📋 Basic Information
            </div>

            <div class="mb-3">
                <label class="form-label"
                       for="title">
                    Conference Title *
                </label>
                <input type="text"
                       id="title"
                       name="title"
                       class="form-control"
                       value="${dto.title}"
                       placeholder="e.g. National AI Summit 2026"
                       maxlength="300"
                       required/>
            </div>

            <div class="mb-3">
                <label class="form-label"
                       for="description">
                    Description
                </label>
                <textarea id="description"
                          name="description"
                          class="form-control"
                          rows="4">${dto.description}</textarea>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label"
                           for="typeSelect">
                        Conference Type *
                    </label>
                    <%--
                        Using JavaScript to set the
                        selected value below (on page load)
                        instead of JSTL selected="selected"
                        on each option.
                        Reason: ${dto.conferenceType == 'X'}
                        compares an enum object to a String
                        which is unreliable in JSTL EL.
                        JS approach is explicit and guaranteed.
                    --%>
                    <select id="typeSelect"
                            name="conferenceType"
                            class="form-select"
                            required>
                        <option value="">
                            — Select Conference Type —
                        </option>
                        <optgroup label="📚 Academic &amp; Research">
                            <option value="STUDENT">Student Academic Conference</option>
                            <option value="ACADEMIC">Academic Conference</option>
                            <option value="RESEARCH">Research Symposium</option>
                            <option value="EDUCATION">Education Conference</option>
                        </optgroup>
                        <optgroup label="💻 Technical &amp; IT">
                            <option value="TECHNICAL">Technical Conference</option>
                            <option value="AI_ML">AI / Machine Learning</option>
                            <option value="DATA_SCIENCE">Data Science</option>
                            <option value="CYBERSECURITY">Cybersecurity</option>
                            <option value="CLOUD_COMPUTING">Cloud Computing</option>
                        </optgroup>
                        <optgroup label="💼 Business &amp; Management">
                            <option value="CORPORATE">Corporate Conference</option>
                            <option value="BUSINESS">Business Conference</option>
                            <option value="STARTUP">Startup / Entrepreneurship</option>
                            <option value="FINANCE">Finance &amp; Investment</option>
                            <option value="MARKETING">Marketing Conference</option>
                            <option value="LEADERSHIP">Leadership Summit</option>
                        </optgroup>
                        <optgroup label="🏥 Industry Specific">
                            <option value="HEALTHCARE">Healthcare / Medical</option>
                            <option value="ENGINEERING">Engineering Conference</option>
                            <option value="LEGAL">Legal Conference</option>
                            <option value="ENVIRONMENTAL">Environmental / Sustainability</option>
                        </optgroup>
                        <optgroup label="🌐 Civic &amp; Social">
                            <option value="NGO">NGO / Social Sector</option>
                            <option value="GOVERNMENT">Government / Public Sector</option>
                        </optgroup>
                        <optgroup label="🎤 Event Formats">
                            <option value="WORKSHOP">Workshop</option>
                            <option value="SEMINAR">Seminar</option>
                            <option value="WEBINAR">Webinar</option>
                            <option value="PANEL">Panel Discussion</option>
                            <option value="BOOTCAMP">Bootcamp</option>
                            <option value="TRAINING">Training Program</option>
                        </optgroup>
                        <optgroup label="🌟 General">
                            <option value="INNOVATION">Innovation Conference</option>
                            <option value="GENERAL">General / Multi-domain</option>
                        </optgroup>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label"
                           for="modeSelect">
                        Conference Mode *
                    </label>
                    <select id="modeSelect"
                            name="mode"
                            class="form-select"
                            required
                            onchange="updateModeFields()">
                        <option value="">
                            — Select Mode —
                        </option>
                        <option value="OFFLINE">
                            🏛 Offline — In-person venue
                        </option>
                        <option value="ONLINE">
                            💻 Online — Virtual only
                        </option>
                        <option value="HYBRID">
                            🔀 Hybrid — Both venue + online
                        </option>
                    </select>
                </div>
            </div>

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label"
                           for="targetAudience">
                        Target Audience
                    </label>
                    <input type="text"
                           id="targetAudience"
                           name="targetAudience"
                           class="form-control"
                           value="${dto.targetAudience}"
                           maxlength="500"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label"
                           for="targetDomains">
                        Target Domains
                    </label>
                    <input type="text"
                           id="targetDomains"
                           name="targetDomains"
                           class="form-control"
                           value="${dto.targetDomains}"
                           maxlength="500"/>
                </div>
            </div>
        </div>

        <%-- ── 2. DATES ────────────────────────────────── --%>
        <div class="form-card">
            <div class="section-label">
                📅 Dates &amp; Timeline
            </div>

            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label"
                           for="startDate">
                        Start Date &amp; Time *
                    </label>
                    <%--
                        LocalDateTime.toString() renders as
                        "2026-06-10T09:30" or "2026-06-10T09:30:00"
                        — both are valid datetime-local values.
                    --%>
                    <input type="datetime-local"
                           id="startDate"
                           name="startDate"
                           class="form-control"
                           value="${dto.startDate}"
                           required/>
                </div>
                <div class="col-md-4">
                    <label class="form-label"
                           for="endDate">
                        End Date &amp; Time *
                    </label>
                    <input type="datetime-local"
                           id="endDate"
                           name="endDate"
                           class="form-control"
                           value="${dto.endDate}"
                           required/>
                </div>
                <div class="col-md-4">
                    <label class="form-label"
                           for="regDeadline">
                        Registration Deadline *
                    </label>
                    <input type="datetime-local"
                           id="regDeadline"
                           name="registrationDeadline"
                           class="form-control"
                           value="${dto.registrationDeadline}"
                           required/>
                </div>
            </div>
        </div>

        <%-- ── 3. VENUE ────────────────────────────────── --%>
        <div class="form-card"
             id="venueSection"
             style="display:none">
            <div class="section-label">
                🏛 Venue Details
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label"
                           for="venueName">
                        Venue Name
                    </label>
                    <input type="text"
                           id="venueName"
                           name="venueName"
                           class="form-control"
                           value="${dto.venueName}"
                           maxlength="300"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label"
                           for="venueAddress">
                        Venue Address
                    </label>
                    <input type="text"
                           id="venueAddress"
                           name="venueAddress"
                           class="form-control"
                           value="${dto.venueAddress}"
                           maxlength="500"/>
                </div>
            </div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label"
                           for="city">
                        City
                    </label>
                    <input type="text"
                           id="city"
                           name="city"
                           class="form-control"
                           value="${dto.city}"
                           maxlength="100"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label"
                           for="state">
                        State
                    </label>
                    <input type="text"
                           id="state"
                           name="state"
                           class="form-control"
                           value="${dto.state}"
                           maxlength="100"/>
                </div>
            </div>
        </div>

        <%-- ── 3B. STREAMING ──────────────────────────── --%>
        <div class="form-card"
             id="streamSection"
             style="display:none">
            <div class="section-label">
                💻 Online / Streaming
            </div>

            <div class="row g-3">
                <div class="col-md-8">
                    <label class="form-label"
                           for="streamingLink">
                        Streaming / Meeting Link
                    </label>
                    <input type="url"
                           id="streamingLink"
                           name="streamingLink"
                           class="form-control"
                           value="${dto.streamingLink}"
                           maxlength="500"/>
                    <div class="form-text">
                        Shared privately with registered
                        delegates only.
                    </div>
                </div>
                <div class="col-md-4">
                    <label class="form-label"
                           for="streamingPassword">
                        Meeting Password
                        <span class="text-muted fw-normal">
                            (optional)
                        </span>
                    </label>
                    <input type="text"
                           id="streamingPassword"
                           name="streamingPassword"
                           class="form-control"
                           value="${dto.streamingPassword}"
                           maxlength="100"/>
                </div>
            </div>
        </div>

        <%-- ── 4. CAPACITY & PRICING ───────────────────── --%>
        <div class="form-card">
            <div class="section-label">
                👥 Capacity &amp; Pricing
            </div>

            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label"
                           for="maxDelegates">
                        Max Delegates *
                    </label>
                    <input type="number"
                           id="maxDelegates"
                           name="maxDelegates"
                           class="form-control"
                           value="${dto.maxDelegates}"
                           min="1"
                           required/>
                </div>
                <div class="col-md-4">
                    <label class="form-label"
                           for="freeSelect">
                        Registration Type
                    </label>
                    <select id="freeSelect"
                            name="free"
                            class="form-select"
                            onchange="updateFeeField()">
                        <option value="true">
                            🆓 Free — No charge
                        </option>
                        <option value="false">
                            💳 Paid — Charge delegates
                        </option>
                    </select>
                </div>
                <div class="col-md-4"
                     id="feeField"
                     style="display:none">
                    <label class="form-label"
                           for="delegateFee">
                        Delegate Fee (₹) *
                    </label>
                    <input type="number"
                           id="delegateFee"
                           name="delegateFee"
                           class="form-control"
                           value="${dto.delegateFee}"
                           min="0"
                           step="0.01"/>
                </div>
            </div>
        </div>

        <%-- ── 5. FEATURES ────────────────────────────── --%>
        <div class="form-card">
            <div class="section-label">
                ⚙️ Conference Features
            </div>

            <div class="row g-3">
                <div class="col-md-4">
                    <label class="feature-card"
                           for="cert">
                        <input type="checkbox"
                               id="cert"
                               name="certificateEnabled"
                               value="true"
                               ${dto.certificateEnabled
                                   ? 'checked' : ''}/>
                        <div>
                            <div class="feature-title">
                                🎓 Certificates
                            </div>
                            <div class="feature-desc">
                                Auto-generate PDF attendance
                                certificates for delegates
                                who checked in.
                            </div>
                        </div>
                    </label>
                </div>
                <div class="col-md-4">
                    <label class="feature-card"
                           for="qr">
                        <input type="checkbox"
                               id="qr"
                               name="qrCheckinEnabled"
                               value="true"
                               ${dto.qrCheckinEnabled
                                   ? 'checked' : ''}/>
                        <div>
                            <div class="feature-title">
                                📱 QR Check-in
                            </div>
                            <div class="feature-desc">
                                Enable camera-based QR
                                scanning for fast delegate
                                check-in at the venue.
                            </div>
                        </div>
                    </label>
                </div>
                <div class="col-md-4">
                    <label class="feature-card"
                           for="bulk">
                        <input type="checkbox"
                               id="bulk"
                               name="bulkUploadAllowed"
                               value="true"
                               ${dto.bulkUploadAllowed
                                   ? 'checked' : ''}/>
                        <div>
                            <div class="feature-title">
                                📋 Bulk Upload
                            </div>
                            <div class="feature-desc">
                                Allow institutional admins
                                to register students via
                                CSV file upload.
                            </div>
                        </div>
                    </label>
                </div>
            </div>
        </div>

        <%-- ── SUBMIT BUTTONS ─────────────────────────── --%>

        <div style="display:flex;gap:12px;
                    align-items:center;
                    flex-wrap:wrap">
            <button type="submit"
                    name="action"
                    value="SUBMIT"
                    class="btn-submit-conf">
                <c:choose>
                    <c:when test="${currentStatusStr == 'REJECTED'}">
                        ✅ Resubmit for Approval
                    </c:when>
                    <c:otherwise>
                        ✅ Submit for Approval
                    </c:otherwise>
                </c:choose>
            </button>
            <button type="submit"
                    name="action"
                    value="DRAFT"
                    class="btn-draft">
                📝 Save as Draft
            </button>
            <a href="${pageContext.request.contextPath}/organizer/conferences"
               style="color:#94a3b8;font-size:0.88rem;
                      text-decoration:none;
                      margin-left:8px">
                Cancel
            </a>
        </div>
        <div class="form-text mt-2">
            <strong>Draft:</strong> saved privately,
            not visible to delegates.
            <strong>Submit:</strong> sent to admin for review.
        </div>

    </form>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>
function updateModeFields() {
    var mode = document.getElementById('modeSelect').value;
    var venue  = document.getElementById('venueSection');
    var stream = document.getElementById('streamSection');

    if (mode === 'OFFLINE') {
        venue.style.display  = 'block';
        stream.style.display = 'none';
    } else if (mode === 'ONLINE') {
        venue.style.display  = 'none';
        stream.style.display = 'block';
    } else if (mode === 'HYBRID') {
        venue.style.display  = 'block';
        stream.style.display = 'block';
    } else {
        venue.style.display  = 'none';
        stream.style.display = 'none';
    }
}

function updateFeeField() {
    var isFree =
        document.getElementById('freeSelect').value
            === 'true';
    document.getElementById('feeField').style.display
        = isFree ? 'none' : 'block';
}

/*
 * FIX: Use plain String model attributes instead of
 * ${dto.conferenceType} (enum rendered by JSTL).
 * Enum rendering can add whitespace or context-prefix
 * that prevents exact match against option values.
 * ${selectedType}, ${selectedMode}, ${selectedFree}
 * are plain java.lang.String — always exact.
 */
document.getElementById('typeSelect').value
    = '${selectedType}';

document.getElementById('modeSelect').value
    = '${selectedMode}';

document.getElementById('freeSelect').value
    = '${selectedFree}';

/*
 * Trigger show/hide AFTER values are set.
 * Order matters — set value first, then call
 * updateModeFields() which reads the value.
 */
updateModeFields();
updateFeeField();
</script>
</body>
</html>