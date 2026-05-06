<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bulk Upload - ${conf.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <style>
        :root {
            --brand: #667eea;
            --brand-gradient: linear-gradient(
                135deg, #667eea 0%, #764ba2 100%);
            --surface: #f8f9fc;
            --border: #e8ecf0;
            --radius: 12px;
        }
        body {
            font-family: 'Inter', sans-serif;
            background: var(--surface);
        }
        .upload-zone {
            border: 2px dashed var(--border);
            border-radius: var(--radius);
            padding: 48px 24px;
            text-align: center;
            background: white;
            transition: all 0.2s;
            cursor: pointer;
        }
        .upload-zone:hover,
        .upload-zone.drag-over {
            border-color: var(--brand);
            background: #f5f7ff;
        }
        .upload-zone-icon {
            font-size: 3rem;
            margin-bottom: 16px;
        }
        .upload-zone-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 8px;
        }
        .upload-zone-desc {
            font-size: 0.88rem;
            color: #64748b;
        }
        .btn-upload {
            background: var(--brand-gradient);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 28px;
            font-weight: 700;
            font-size: 0.95rem;
            transition: opacity 0.15s;
        }
        .btn-upload:hover {
            opacity: 0.9;
            color: white;
        }
        .format-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px 24px;
        }
        .format-table {
            width: 100%;
            border-collapse: collapse;
        }
        .format-table th {
            background: #667eea;
            color: white;
            padding: 10px 14px;
            font-size: 0.85rem;
            font-weight: 600;
            text-align: left;
        }
        .format-table td {
            padding: 10px 14px;
            font-size: 0.85rem;
            border-bottom: 1px solid var(--border);
        }
        .format-table tr:last-child td {
            border-bottom: none;
        }
        .required-badge {
            background: #fee2e2;
            color: #dc2626;
            border-radius: 100px;
            padding: 2px 8px;
            font-size: 0.7rem;
            font-weight: 600;
        }
        .optional-badge {
            background: #f1f5f9;
            color: #64748b;
            border-radius: 100px;
            padding: 2px 8px;
            font-size: 0.7rem;
            font-weight: 600;
        }
        /* Result card */
        .result-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            overflow: hidden;
        }
        .result-header {
            padding: 16px 20px;
            font-weight: 700;
        }
        .result-header.success {
            background: #f0fdf4;
            border-bottom: 1px solid #bbf7d0;
            color: #166534;
        }
        .result-header.warning {
            background: #fffbeb;
            border-bottom: 1px solid #fde68a;
            color: #92400e;
        }
        .result-stat {
            display: flex;
            justify-content: space-between;
            padding: 10px 20px;
            border-bottom: 1px solid var(--border);
            font-size: 0.88rem;
        }
        .result-stat:last-child {
            border-bottom: none;
        }
        /* History table */
        .history-row-success td:first-child {
            border-left: 3px solid #22c55e;
        }
        .history-row-warning td:first-child {
            border-left: 3px solid #f59e0b;
        }
        .history-row-failed td:first-child {
            border-left: 3px solid #ef4444;
        }
        /* Error log */
        .error-log {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 8px;
            padding: 14px 16px;
            font-size: 0.8rem;
            font-family: monospace;
            color: #dc2626;
            max-height: 200px;
            overflow-y: auto;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4">

    <!-- Header -->
    <div class="d-flex justify-content-between
                align-items-center mb-4">
        <div>
            <h2 class="fw-bold mb-0">
                📋 Bulk Delegate Upload
            </h2>
            <p class="text-muted mb-0">
                ${conf.title}
            </p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}/delegates"
               class="btn btn-outline-secondary btn-sm">
                View Delegates
            </a>
            <a href="${pageContext.request.contextPath}/organizer/conference/${conf.id}"
               class="btn btn-outline-secondary btn-sm">
                Back
            </a>
        </div>
    </div>

    <!-- Alerts -->
    <c:if test="${not empty success}">
        <div class="alert alert-success fw-semibold">
            ✅ ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>

    <!-- Seat availability warning -->
    <c:set var="seatsLeft"
           value="${conf.maxDelegates - conf.registeredCount}"/>
    <c:if test="${seatsLeft <= 10}">
        <div class="alert alert-warning">
            ⚠️ Only <strong>${seatsLeft}</strong>
            seat(s) remaining in this conference.
        </div>
    </c:if>

    <div class="row g-4">

        <!-- LEFT: Upload form + result -->
        <div class="col-lg-7">

            <!-- Upload result (shown after upload) -->
            <c:if test="${not empty uploadResult}">
                <div class="result-card mb-4">
                    <div class="result-header
                        ${uploadResult.failedRows > 0 ?
                          'warning' : 'success'}">
                        Upload Result:
                        ${uploadResult.status}
                    </div>
                    <div class="result-stat">
                        <span>Total rows in CSV</span>
                        <strong>
                            ${uploadResult.totalRows}
                        </strong>
                    </div>
                    <div class="result-stat">
                        <span style="color:#059669">
                            ✅ Successfully registered
                        </span>
                        <strong style="color:#059669">
                            ${uploadResult.successfulRows}
                        </strong>
                    </div>
                    <div class="result-stat">
                        <span style="color:#dc2626">
                            ❌ Failed / Skipped
                        </span>
                        <strong style="color:#dc2626">
                            ${uploadResult.failedRows}
                        </strong>
                    </div>
                    <c:if test="${not empty uploadResult.errorLog}">
                        <div style="padding:14px 20px">
                            <div class="fw-semibold small mb-2">
                                Error Details:
                            </div>
                            <div class="error-log">
                                ${uploadResult.errorLog}
                            </div>
                        </div>
                    </c:if>
                </div>
            </c:if>

            <!-- Upload Form -->
            <div class="card"
                 style="border:none;border-radius:var(--radius);
                        box-shadow:0 2px 10px rgba(0,0,0,0.08)">
                <div class="card-header fw-bold bg-white
                             border-bottom py-3">
                    Upload CSV File
                </div>
                <div class="card-body p-4">

                    <!-- Stats -->
                    <div class="row g-3 mb-4">
                        <div class="col-4 text-center">
                            <div style="font-size:1.6rem;
                                 font-weight:800;
                                 color:var(--brand)">
                                ${conf.registeredCount}
                            </div>
                            <div class="small text-muted">
                                Registered
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div style="font-size:1.6rem;
                                 font-weight:800;
                                 color:#f59e0b">
                                ${seatsLeft}
                            </div>
                            <div class="small text-muted">
                                Seats Left
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div style="font-size:1.6rem;
                                 font-weight:800;
                                 color:#64748b">
                                ${conf.maxDelegates}
                            </div>
                            <div class="small text-muted">
                                Total Capacity
                            </div>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/bulk-upload"
                          method="post"
                          enctype="multipart/form-data"
                          id="uploadForm">
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>

                        <!-- Drop zone -->
                        <div class="upload-zone"
                             id="dropZone"
                             onclick="document.getElementById('csvFile').click()">
                            <div class="upload-zone-icon">
                                📄
                            </div>
                            <div class="upload-zone-title"
                                 id="dropTitle">
                                Click to upload or drag
                                &amp; drop
                            </div>
                            <div class="upload-zone-desc">
                                Supports .csv files only
                            </div>
                        </div>

                        <input type="file"
                               name="file"
                               id="csvFile"
                               accept=".csv"
                               style="display:none"
                               onchange="fileSelected(this)"/>

                        <c:if test="${seatsLeft <= 0}">
                            <div class="alert alert-danger mt-3">
                                This conference is full.
                                Cannot upload more delegates.
                            </div>
                        </c:if>

                        <c:if test="${seatsLeft > 0}">
                            <button type="submit"
                                    class="btn btn-upload
                                           w-100 mt-3"
                                    id="uploadBtn"
                                    disabled>
                                Upload &amp; Register Delegates
                            </button>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>

        <!-- RIGHT: CSV format guide -->
        <div class="col-lg-5">

            <!-- Format guide -->
            <div class="format-card mb-4">
                <h6 class="fw-bold mb-3">
                    📋 CSV Format Guide
                </h6>
                <p class="small text-muted mb-3">
                    Your CSV file must have these columns
                    (header row required):
                </p>
                <table class="format-table">
                    <thead>
                        <tr>
                            <th>Column</th>
                            <th>Required?</th>
                            <th>Example</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><code>full_name</code></td>
                            <td>
                                <span class="required-badge">
                                    Required
                                </span>
                            </td>
                            <td>Preetham M R</td>
                        </tr>
                        <tr>
                            <td><code>email</code></td>
                            <td>
                                <span class="required-badge">
                                    Required
                                </span>
                            </td>
                            <td>preetham@gmail.com</td>
                        </tr>
                        <tr>
                            <td><code>phone</code></td>
                            <td>
                                <span class="optional-badge">
                                    Optional
                                </span>
                            </td>
                            <td>9876543210</td>
                        </tr>
                    </tbody>
                </table>

                <!-- Sample CSV download -->
                <div style="background:#f8f9fc;
                     border-radius:8px;padding:14px;
                     margin-top:16px">
                    <div class="fw-semibold small mb-2">
                        Sample CSV:
                    </div>
                    <pre style="font-size:0.75rem;
                         color:#475569;margin:0;
                         background:none">full_name,email,phone
Preetham M R,preetham@gmail.com,9876543210
Raj Kumar,raj@gmail.com,9123456789
Anitha S,anitha@college.edu,</pre>
                </div>

                <div style="margin-top:14px;font-size:0.8rem;
                     color:#64748b;line-height:1.6">
                    <strong>What happens for each row:</strong>
                    <ul style="margin:6px 0 0;
                         padding-left:18px">
                        <li>If email exists → registered directly</li>
                        <li>If email is new → account created
                            with temporary password</li>
                        <li>New accounts get a welcome email
                            with login credentials</li>
                        <li>Already-registered delegates
                            are skipped</li>
                        <li>Full conference → remaining
                            rows skipped</li>
                    </ul>
                </div>
            </div>

            <!-- Rules -->
            <div class="format-card">
                <h6 class="fw-bold mb-3">⚠️ Rules</h6>
                <ul class="small text-muted"
                    style="line-height:1.8;
                           padding-left:18px">
                    <li>Maximum 500 rows per upload</li>
                    <li>Duplicate emails in CSV are
                        automatically skipped</li>
                    <li>File size limit: 2 MB</li>
                    <li>Encoding must be UTF-8</li>
                    <li>New accounts get temporary
                        password "NexMeet" + 4 digits</li>
                    <li>Registration count updates
                        in real-time</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Upload History -->
    <c:if test="${not empty uploadHistory}">
        <div class="card mt-4"
             style="border:none;border-radius:var(--radius);
                    box-shadow:0 2px 10px rgba(0,0,0,0.08)">
            <div class="card-header fw-bold bg-white border-bottom py-3">
                Upload History
            </div>
            <div class="card-body p-0">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>File Name</th>
                            <th>Date</th>
                            <th class="text-center">Total</th>
                            <th class="text-center">
                                Registered
                            </th>
                            <th class="text-center">Failed</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="h"
                                   items="${uploadHistory}">
                            <tr class="history-row-${
                                h.status == 'COMPLETED'
                                ? 'success'
                                : h.status == 'COMPLETED_WITH_ERRORS'
                                ? 'warning' : 'failed'}">
                                <td class="small">
                                    ${h.fileName}
                                </td>
                                <td class="small text-muted">
                                    ${fn:substringBefore(
                                        h.uploadedAt.toString(),
                                        'T')}
                                </td>
                                <td class="text-center">
                                    <strong>
                                        ${h.totalRows}
                                    </strong>
                                </td>
                                <td class="text-center"
                                    style="color:#059669;
                                           font-weight:600">
                                    ${h.successfulRows}
                                </td>
                                <td class="text-center"
                                    style="color:${h.failedRows > 0 ? '#dc2626' : '#94a3b8'};
                                           font-weight:${h.failedRows > 0 ? '600' : '400'}">
                                    ${h.failedRows}
                                </td>
                                <td>
                                    <span class="badge
                                        ${h.status == 'COMPLETED'
                                          ? 'bg-success'
                                          : h.status == 'COMPLETED_WITH_ERRORS'
                                          ? 'bg-warning text-dark'
                                          : 'bg-danger'}
                                        small">
                                        ${h.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>
    function fileSelected(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];
            document.getElementById('dropTitle')
                .textContent = file.name;
            document.getElementById('uploadBtn')
                .disabled = false;
            document.getElementById('dropZone')
                .style.borderColor = '#667eea';
        }
    }

    // Drag and drop
    const zone = document.getElementById('dropZone');
    zone.addEventListener('dragover', (e) => {
        e.preventDefault();
        zone.classList.add('drag-over');
    });
    zone.addEventListener('dragleave', () => {
        zone.classList.remove('drag-over');
    });
    zone.addEventListener('drop', (e) => {
        e.preventDefault();
        zone.classList.remove('drag-over');
        const file = e.dataTransfer.files[0];
        if (file && file.name.endsWith('.csv')) {
            const input =
                document.getElementById('csvFile');
            const dt = new DataTransfer();
            dt.items.add(file);
            input.files = dt.files;
            fileSelected(input);
        } else {
            alert('Please drop a .csv file only.');
        }
    });

    // Show loading on submit
    document.getElementById('uploadForm')
        .addEventListener('submit', () => {
            const btn =
                document.getElementById('uploadBtn');
            btn.disabled = true;
            btn.textContent =
                'Processing... Please wait';
        });
</script>

</body>
</html>