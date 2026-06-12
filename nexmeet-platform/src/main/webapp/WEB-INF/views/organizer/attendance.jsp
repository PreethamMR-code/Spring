<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance – ${conf.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; font-family: 'Inter', sans-serif; }

        /* ── Scanner wrapper ─────────────────────────── */
        #scanner-wrapper {
            display: none;           /* hidden until started */
            position: relative;
            width: 100%;
            max-width: 480px;
            margin: 0 auto;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 24px rgba(0,0,0,0.18);
            background: #000;
        }
        #camera-video {
            width: 100%;
            display: block;
        }
        /* Overlay canvas — sits on top of video for visual feedback */
        #scanner-canvas {
            position: absolute;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;    /* clicks pass through to video */
        }
        /* The animated scan-line */
        #scan-line {
            display: none;
            position: absolute;
            left: 10%; right: 10%;
            height: 3px;
            background: linear-gradient(90deg,
                transparent, #22c55e, transparent);
            border-radius: 2px;
            animation: scanMove 2s linear infinite;
            box-shadow: 0 0 8px #22c55e;
        }
        @keyframes scanMove {
            0%   { top: 15%; }
            100% { top: 85%; }
        }
        /* Corner brackets — targeting frame */
        #scan-frame {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 60%;
            aspect-ratio: 1;
            pointer-events: none;
        }
        #scan-frame::before,
        #scan-frame::after,
        #scan-frame > span::before,
        #scan-frame > span::after {
            content: '';
            position: absolute;
            width: 24px; height: 24px;
            border-color: #22c55e;
            border-style: solid;
        }
        #scan-frame::before       { top:0;    left:0;  border-width: 3px 0 0 3px; }
        #scan-frame::after        { top:0;    right:0; border-width: 3px 3px 0 0; }
        #scan-frame > span::before{ bottom:0; left:0;  border-width: 0 0 3px 3px; }
        #scan-frame > span::after { bottom:0; right:0; border-width: 0 3px 3px 0; }

        /* Flash animation when QR is detected */
        .qr-flash {
            animation: flashGreen 0.4s ease-out;
        }
        @keyframes flashGreen {
            0%   { box-shadow: 0 0 0 0   rgba(34,197,94,0.8); }
            50%  { box-shadow: 0 0 0 16px rgba(34,197,94,0.4); }
            100% { box-shadow: 0 0 0 0   rgba(34,197,94,0); }
        }

        /* Status pill shown during scanning */
        #scan-status {
            position: absolute;
            bottom: 12px; left: 50%;
            transform: translateX(-50%);
            background: rgba(0,0,0,0.65);
            color: #fff;
            padding: 5px 16px;
            border-radius: 20px;
            font-size: 0.78rem;
            white-space: nowrap;
            backdrop-filter: blur(4px);
        }

        /* ── Stats cards ─────────────────────────────── */
        .stat-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
        }
        .stat-card .stat-num {
            font-size: 2.4rem;
            font-weight: 800;
            line-height: 1;
        }

        /* ── Checked-in table ────────────────────────── */
        .checkin-badge {
            background: #dcfce7;
            color: #166534;
            border-radius: 6px;
            padding: 2px 8px;
            font-size: 0.78rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-4" style="max-width:960px">

    <!-- Page header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-0" style="color:#166534;font-weight:800">
                📋 Attendance Check-in
            </h2>
            <p class="text-muted mb-0">${conf.title}</p>
        </div>
        <a href="${pageContext.request.contextPath}/organizer/conferences"
           class="btn btn-outline-secondary btn-sm">← Back</a>
    </div>

    <!-- Flash messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ✅ ${success}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ❌ ${error}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- ── CHECK-IN PANEL ──────────────────────────────── -->
    <div class="card mb-4" style="border:none;border-radius:14px;
         box-shadow:0 2px 12px rgba(0,0,0,0.09)">
        <div class="card-header fw-bold text-white"
             style="background:linear-gradient(135deg,#166534,#16a34a);
                    border-radius:14px 14px 0 0">
            🔍 Scan QR Code or Enter Registration Number
        </div>
        <div class="card-body p-4">

            <!--
                SECTION 1: Manual entry form
                This form is ALWAYS visible and is the fallback.
                The QR scanner auto-fills this input and submits.
            -->
            <form id="checkin-form"
                  action="${pageContext.request.contextPath}/organizer/conference/${conf.id}/attendance/mark"
                  method="post">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <div class="d-flex gap-2 mb-2">
                    <input type="text"
                           id="reg-number-input"
                           name="registrationNumber"
                           class="form-control form-control-lg"
                           placeholder="e.g. NM-AF752AE3"
                           autocomplete="off"
                           spellcheck="false"
                           style="font-family:monospace;font-size:1.1rem;
                                  letter-spacing:0.04em;font-weight:600"
                           required/>
                    <button type="submit"
                            class="btn btn-success btn-lg px-4 fw-bold"
                            style="white-space:nowrap">
                        ✓ Check In
                    </button>
                </div>
                <small class="text-muted">
                    Type or scan the registration number from the delegate's ticket.
                </small>
            </form>

            <hr class="my-3"/>

            <!--
                SECTION 2: QR Camera Scanner
                Camera opens inline — no popup, no redirect.
                Works on any modern browser (Chrome, Firefox, Safari iOS).
                Requires HTTPS in production (localhost works fine).
            -->
            <div class="d-flex align-items-center gap-3 flex-wrap">

                <!-- START button -->
                <button id="btn-start-scan"
                        type="button"
                        class="btn btn-outline-success fw-bold"
                        onclick="startScanner()">
                    📷 Start Camera Scanner
                </button>

                <!-- STOP button (hidden initially) -->
                <button id="btn-stop-scan"
                        type="button"
                        class="btn btn-outline-danger fw-bold d-none"
                        onclick="stopScanner()">
                    ⏹ Stop Camera
                </button>

                <!-- Torch toggle (mobile only) -->
                <button id="btn-torch"
                        type="button"
                        class="btn btn-outline-warning fw-bold d-none"
                        onclick="toggleTorch()">
                    🔦 Torch
                </button>

                <span id="camera-hint"
                      class="text-muted small">
                    Point the camera at a delegate's QR code.
                    Registration number auto-fills and checks in instantly.
                </span>
            </div>

            <!-- Camera viewport (hidden until started) -->
            <div id="scanner-wrapper" class="mt-3">
                <video id="camera-video"
                       autoplay
                       muted
                       playsinline></video>
                <!-- Hidden canvas used by jsQR for frame analysis -->
                <canvas id="scanner-canvas"></canvas>
                <!-- Targeting overlay elements -->
                <div id="scan-line"></div>
                <div id="scan-frame"><span></span></div>
                <div id="scan-status">🔍 Scanning…</div>
            </div>

            <!-- Last scanned result display -->
            <div id="scan-result" class="d-none mt-3">
                <div class="alert alert-success d-flex
                            align-items-center gap-2 mb-0">
                    <span style="font-size:1.5rem">✅</span>
                    <div>
                        <div class="fw-bold">QR Detected!</div>
                        <div class="small" id="scan-result-text"></div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- ── STATS ───────────────────────────────────────── -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card stat-card p-4 text-center"
                 style="border-left:5px solid #22c55e !important">
                <div class="text-muted small mb-1 text-uppercase fw-semibold"
                     style="letter-spacing:0.05em">
                    Checked In
                </div>
                <div class="stat-num text-success">${attendedCount}</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stat-card p-4 text-center"
                 style="border-left:5px solid #3b82f6 !important">
                <div class="text-muted small mb-1 text-uppercase fw-semibold"
                     style="letter-spacing:0.05em">
                    Total Registered
                </div>
                <div class="stat-num text-primary">${conf.registeredCount}</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stat-card p-4 text-center"
                 style="border-left:5px solid #f59e0b !important">
                <div class="text-muted small mb-1 text-uppercase fw-semibold"
                     style="letter-spacing:0.05em">
                    Not Yet Arrived
                </div>
                <div class="stat-num text-warning">
                    ${conf.registeredCount - attendedCount}
                </div>
            </div>
        </div>
    </div>

    <!-- ── CHECKED-IN DELEGATES TABLE ─────────────────── -->
    <div class="card" style="border:none;border-radius:14px;
         box-shadow:0 2px 12px rgba(0,0,0,0.09)">
        <div class="card-header fw-bold"
             style="border-radius:14px 14px 0 0;
                    background:#f8fffe;
                    border-bottom:1px solid #e2f5eb">
            ✅ Checked-in Delegates
            <span class="badge bg-success ms-2">${attendedCount}</span>
        </div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty attended}">
                    <div class="text-center py-5 text-muted">
                        <div style="font-size:3rem">📭</div>
                        <div class="mt-2">No delegates checked in yet.</div>
                        <div class="small">Use the scanner or enter a
                            registration number above.</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead style="background:#f0fdf4">
                                <tr>
                                    <th class="ps-3">#</th>
                                    <th>Reg. Number</th>
                                    <th>Delegate Name</th>
                                    <th>Checked In At</th>
                                    <th>Checked In By</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="a"
                                           items="${attended}"
                                           varStatus="s">
                                    <tr>
                                        <td class="ps-3 text-muted
                                             small">${s.count}</td>
                                        <td>
                                            <code class="checkin-badge">
                                                ${a.registration.registrationNumber}
                                            </code>
                                        </td>
                                        <td class="fw-semibold">
                                            ${a.user.fullName}
                                        </td>
                                        <td class="small text-muted">
                                            ${fn:replace(
                                                fn:substringBefore(
                                                    a.checkedInAt.toString(),'.'),
                                                'T',' ')}
                                        </td>
                                        <td class="small text-muted">
                                            ${a.checkedInBy.fullName}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div><!-- /container -->

<!-- jsQR — reads QR codes from video frames in the browser -->
<script src="https://cdn.jsdelivr.net/npm/jsqr@1.4.0/dist/jsQR.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
/*
 * QR CAMERA SCANNER
 * ─────────────────────────────────────────────────────────────
 * How it works:
 *   1. getUserMedia() asks browser for camera permission
 *   2. Camera feed is piped into a <video> element
 *   3. requestAnimationFrame() calls tick() ~60 times/second
 *   4. Each tick: draw video frame onto hidden <canvas>
 *   5. jsQR analyses the canvas pixel data for QR patterns
 *   6. When QR found: extract the token → fill input → submit form
 *   7. 1-second cooldown prevents double-submission
 *
 * No backend changes needed — the form submits exactly as before.
 * The camera just auto-fills the registration number field.
 * ─────────────────────────────────────────────────────────────
 */

let videoStream    = null;   // MediaStream from getUserMedia
let animFrame      = null;   // requestAnimationFrame handle
let scanning       = false;  // true while camera is active
let lastScanTime   = 0;      // epoch ms of last successful scan
const COOLDOWN_MS  = 1500;   // wait 1.5s before accepting next scan
let torchTrack     = null;   // camera track (for torch control)

// DOM references — cached once
const video        = document.getElementById('camera-video');
const canvas       = document.getElementById('scanner-canvas');
const ctx          = canvas.getContext('2d', { willReadFrequently: true });
const wrapper      = document.getElementById('scanner-wrapper');
const scanLine     = document.getElementById('scan-line');
const scanFrame    = document.getElementById('scan-frame');
const scanStatus   = document.getElementById('scan-status');
const scanResult   = document.getElementById('scan-result');
const scanText     = document.getElementById('scan-result-text');
const regInput     = document.getElementById('reg-number-input');
const checkinForm  = document.getElementById('checkin-form');
const btnStart     = document.getElementById('btn-start-scan');
const btnStop      = document.getElementById('btn-stop-scan');
const btnTorch     = document.getElementById('btn-torch');

async function startScanner() {
    /*
     * Request rear camera first (environment = phone back camera).
     * Falls back to any available camera if rear not available.
     * On desktop: uses webcam.
     */
    const constraints = {
        video: {
            facingMode: { ideal: 'environment' },
            width:  { ideal: 1280 },
            height: { ideal: 720 }
        }
    };

    try {
        videoStream = await navigator.mediaDevices
                          .getUserMedia(constraints);
    } catch (err) {
        if (err.name === 'NotAllowedError') {
            alert('Camera permission denied.\n\n' +
                  'Please allow camera access in your ' +
                  'browser settings and reload the page.');
        } else if (err.name === 'NotFoundError') {
            alert('No camera found on this device.\n\n' +
                  'Please use the manual entry field instead.');
        } else {
            alert('Camera error: ' + err.message);
        }
        return;
    }

    video.srcObject = videoStream;

    // Store track reference for torch control
    torchTrack = videoStream.getVideoTracks()[0];

    // Show torch button only on mobile (MediaTrackCapabilities check)
    if (torchTrack && torchTrack.getCapabilities &&
        torchTrack.getCapabilities().torch) {
        btnTorch.classList.remove('d-none');
    }

    // Show scanner UI, hide start button
    wrapper.style.display = 'block';
    scanLine.style.display  = 'block';
    scanFrame.style.display = 'block';
    btnStart.classList.add('d-none');
    btnStop.classList.remove('d-none');
    scanning = true;

    // Wait for video to load metadata before starting analysis
    video.addEventListener('loadedmetadata', function onMeta() {
        video.removeEventListener('loadedmetadata', onMeta);
        canvas.width  = video.videoWidth;
        canvas.height = video.videoHeight;
        tick();  // start the frame analysis loop
    });

    video.play().catch(function() {});
}

function tick() {
    /*
     * Called ~60fps via requestAnimationFrame.
     * Each call:
     *   1. Draw current video frame to canvas
     *   2. Read pixel data
     *   3. Pass to jsQR for QR pattern detection
     *   4. If QR found and cooldown elapsed → process it
     */
    if (!scanning) return;

    if (video.readyState === video.HAVE_ENOUGH_DATA) {
        ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

        const imageData = ctx.getImageData(
            0, 0, canvas.width, canvas.height);

        const code = jsQR(
            imageData.data,
            imageData.width,
            imageData.height,
            { inversionAttempts: 'dontInvert' }
        );

        if (code) {
            const now = Date.now();
            if (now - lastScanTime > COOLDOWN_MS) {
                lastScanTime = now;
                handleQrDetected(code.data);
            }
        }
    }

    animFrame = requestAnimationFrame(tick);
}

function handleQrDetected(rawData) {
    /*
     * rawData is whatever text was encoded in the QR.
     * Your QR tokens are stored as the registration number itself
     * (e.g. "NM-AF752AE3") via qrCodeService.generateQrCodeBase64().
     * So rawData IS the registration number — no parsing needed.
     */
    const token = rawData.trim();

    if (!token.startsWith("NM-")) {
        scanStatus.textContent =
            "❌ Invalid NexMeet QR Code";
        return;
    }

    // Visual feedback
    scanStatus.textContent = '✅ QR Detected: ' + token;
    wrapper.classList.add('qr-flash');
    setTimeout(function() {
        wrapper.classList.remove('qr-flash');
    }, 400);

    // Show result banner
    scanText.textContent = 'Registration: ' + token +
                           ' — submitting check-in…';
    scanResult.classList.remove('d-none');

    // Fill the form input
    regInput.value = token;

    // Stop scanning while we process (prevents double-submit)
    scanning = false;
    cancelAnimationFrame(animFrame);
    scanLine.style.display  = 'none';
    scanFrame.style.display = 'none';
    scanStatus.textContent  = '⏸ Paused — processing…';

    // Submit the form automatically after 300ms visual delay
    // so the organizer can see what was scanned
    setTimeout(function() {
        checkinForm.submit();
    }, 300);
}

function stopScanner() {
    scanning = false;
    cancelAnimationFrame(animFrame);

    if (videoStream) {
        videoStream.getTracks().forEach(function(t) {
            t.stop();
        });
        videoStream = null;
    }

    video.srcObject   = null;
    wrapper.style.display = 'none';
    scanLine.style.display  = 'none';
    scanFrame.style.display = 'none';
    scanResult.classList.add('d-none');
    btnStart.classList.remove('d-none');
    btnStop.classList.add('d-none');
    btnTorch.classList.add('d-none');

    // Clear the input so organizer can enter manually if needed
    regInput.value = '';
    regInput.focus();
}

function toggleTorch() {
    if (!torchTrack) return;
    const current = torchTrack.getSettings().torch || false;
    torchTrack.applyConstraints({
        advanced: [{ torch: !current }]
    }).catch(function(e) {
        console.warn('Torch toggle failed:', e);
    });
    btnTorch.textContent = !current ? '🔦 Torch (ON)' : '🔦 Torch';
}

// Auto-focus input when page loads (for manual entry without camera)
document.addEventListener('DOMContentLoaded', function() {
    regInput.focus();
});

// Clean up camera if organizer navigates away
window.addEventListener('beforeunload', function() {
    if (videoStream) {
        videoStream.getTracks().forEach(function(t) { t.stop(); });
    }
});
</script>
</body>
</html>