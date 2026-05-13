<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Setup - Institution Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
</head>
<body class="bg-light">
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container py-5"
     style="max-width:600px">
    <div class="card shadow-sm">
        <div class="card-header fw-bold bg-white
                    border-bottom py-3">
            🏫 Set Up Your Institutional Admin Profile
        </div>
        <div class="card-body p-4">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>

            <p class="text-muted mb-4">
                Select your institution and enter your
                role details. An admin will verify your
                account before you can perform bulk
                registrations.
            </p>

            <form action="${pageContext.request.contextPath}/institution/profile/setup"
                  method="post">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Your Institution *
                    </label>
                    <select name="institutionId"
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
                        Don't see your institution? Contact
                        NexMeet admin to add it.
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Your Job Title
                    </label>
                    <input type="text"
                           name="jobTitle"
                           class="form-control"
                           placeholder="e.g. HOD, Placement Officer, HR Manager"/>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Department
                    </label>
                    <input type="text"
                           name="department"
                           class="form-control"
                           placeholder="e.g. CSE, MBA, HR"/>
                </div>

                <button type="submit"
                        class="btn btn-primary w-100">
                    Submit Profile
                </button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>