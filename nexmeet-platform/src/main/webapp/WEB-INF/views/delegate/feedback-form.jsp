<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Feedback - NexMeet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; }
        .feedback-card {
            max-width: 620px;
            margin: 30px auto;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.10);
        }
        .star-group { display: flex; flex-direction: row-reverse;
                      justify-content: flex-end; gap: 4px; }
        .star-group input[type=radio] { display: none; }
        .star-group label {
            font-size: 1.8rem;
            color: #dee2e6;
            cursor: pointer;
            transition: color 0.15s;
        }
        .star-group input:checked ~ label,
        .star-group label:hover,
        .star-group label:hover ~ label { color: #ffc107; }
        .rating-row { margin-bottom: 1rem; }
        .rating-label { font-weight: 600; min-width: 180px;
                        display: inline-block; }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container">
    <div class="card feedback-card">
        <div class="card-body p-4">

            <div class="text-center mb-4">
                <div style="font-size:2.5rem">⭐</div>
                <h4 class="fw-bold mt-2">Submit Your Feedback</h4>
                <p class="text-muted">
                    Your feedback helps improve future conferences
                    and helps other delegates choose wisely.
                </p>
            </div>

            <c:if test="${alreadySubmitted}">
                <div class="alert alert-info text-center">
                    You have already submitted feedback for
                    this conference. Thank you!
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <c:if test="${not alreadySubmitted}">
                <form action="${pageContext.request.contextPath}/delegate/conference/${conferenceId}/feedback"
                      method="post">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>

                    <!-- Overall Rating -->
                    <div class="mb-4">
                        <label class="form-label fw-bold fs-6">
                            Overall Experience *
                        </label>
                        <div class="star-group" id="overall-stars">
                            <input type="radio" id="overall5"
                                   name="overallRating" value="5"/>
                            <label for="overall5"
                                   title="Excellent">★</label>
                            <input type="radio" id="overall4"
                                   name="overallRating" value="4"/>
                            <label for="overall4"
                                   title="Good">★</label>
                            <input type="radio" id="overall3"
                                   name="overallRating" value="3"/>
                            <label for="overall3"
                                   title="Average">★</label>
                            <input type="radio" id="overall2"
                                   name="overallRating" value="2"/>
                            <label for="overall2"
                                   title="Poor">★</label>
                            <input type="radio" id="overall1"
                                   name="overallRating" value="1"/>
                            <label for="overall1"
                                   title="Terrible">★</label>
                        </div>
                        <small class="text-muted">
                            Required — select 1 to 5 stars
                        </small>
                    </div>

                    <!-- Detailed Ratings -->
                    <div class="mb-4">
                        <label class="form-label fw-bold fs-6">
                            Detailed Ratings
                            <span class="text-muted fw-normal">(optional)</span>
                        </label>

                        <!-- Organization -->
                        <div class="rating-row">
                            <span class="rating-label text-muted">
                                Organization &amp; Logistics
                            </span>
                            <div class="star-group d-inline-flex">
                                <input type="radio" id="org5"
                                       name="organizationRating" value="5"/>
                                <label for="org5">★</label>
                                <input type="radio" id="org4"
                                       name="organizationRating" value="4"/>
                                <label for="org4">★</label>
                                <input type="radio" id="org3"
                                       name="organizationRating" value="3"/>
                                <label for="org3">★</label>
                                <input type="radio" id="org2"
                                       name="organizationRating" value="2"/>
                                <label for="org2">★</label>
                                <input type="radio" id="org1"
                                       name="organizationRating" value="1"/>
                                <label for="org1">★</label>
                            </div>
                        </div>

                        <!-- Content -->
                        <div class="rating-row">
                            <span class="rating-label text-muted">
                                Content Quality
                            </span>
                            <div class="star-group d-inline-flex">
                                <input type="radio" id="con5"
                                       name="contentRating" value="5"/>
                                <label for="con5">★</label>
                                <input type="radio" id="con4"
                                       name="contentRating" value="4"/>
                                <label for="con4">★</label>
                                <input type="radio" id="con3"
                                       name="contentRating" value="3"/>
                                <label for="con3">★</label>
                                <input type="radio" id="con2"
                                       name="contentRating" value="2"/>
                                <label for="con2">★</label>
                                <input type="radio" id="con1"
                                       name="contentRating" value="1"/>
                                <label for="con1">★</label>
                            </div>
                        </div>

                        <!-- Speakers -->
                        <div class="rating-row">
                            <span class="rating-label text-muted">
                                Speakers
                            </span>
                            <div class="star-group d-inline-flex">
                                <input type="radio" id="spk5"
                                       name="speakerRating" value="5"/>
                                <label for="spk5">★</label>
                                <input type="radio" id="spk4"
                                       name="speakerRating" value="4"/>
                                <label for="spk4">★</label>
                                <input type="radio" id="spk3"
                                       name="speakerRating" value="3"/>
                                <label for="spk3">★</label>
                                <input type="radio" id="spk2"
                                       name="speakerRating" value="2"/>
                                <label for="spk2">★</label>
                                <input type="radio" id="spk1"
                                       name="speakerRating" value="1"/>
                                <label for="spk1">★</label>
                            </div>
                        </div>
                    </div>

                    <!-- Comments -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">
                            Comments
                            <span class="text-muted fw-normal">(optional)</span>
                        </label>
                        <textarea name="comments"
                                  class="form-control"
                                  rows="4"
                                  placeholder="Share your experience — what went well, what could be improved..."></textarea>
                    </div>

                    <!-- Public Toggle -->
                    <div class="mb-4 form-check">
                        <input type="checkbox" class="form-check-input"
                               id="isPublic" name="public"
                               value="true" checked/>
                        <label class="form-check-label" for="isPublic">
                            Show my feedback publicly on the
                            conference page
                        </label>
                    </div>

                    <div class="d-flex gap-3">
                        <button type="submit"
                                class="btn btn-primary px-5 fw-semibold">
                            Submit Feedback
                        </button>
                        <a href="${pageContext.request.contextPath}/delegate/dashboard"
                           class="btn btn-outline-secondary">
                            Cancel
                        </a>
                    </div>
                </form>
            </c:if>

            <c:if test="${alreadySubmitted}">
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/delegate/dashboard"
                       class="btn btn-primary">
                        Back to Dashboard
                    </a>
                </div>
            </c:if>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>