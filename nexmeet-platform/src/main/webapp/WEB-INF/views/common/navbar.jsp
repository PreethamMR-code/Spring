<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<nav class="navbar navbar-expand-lg navbar-dark mb-4"
     style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container">

        <!-- Brand -->
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
            NexMeet
        </a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">

            <!-- Left Links -->
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/conferences">
                        Browse Conferences
                    </a>
                </li>

                <!-- Admin Links -->
                <sec:authorize access="hasRole('ROLE_SUPER_ADMIN')">
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/admin/dashboard">
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/admin/conferences">
                            All Conferences
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/admin/users">
                            All Users
                        </a>
                    </li>
                </sec:authorize>

                <!-- Organizer Links -->
                <sec:authorize access="hasRole('ROLE_ORGANIZER')">
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/organizer/dashboard">
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/organizer/conferences">
                            My Conferences
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/organizer/conference/create">
                            + Create
                        </a>
                    </li>
                </sec:authorize>

                <!-- Delegate Links -->
                <sec:authorize access="hasRole('ROLE_DELEGATE')">
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/delegate/dashboard">
                            My Dashboard
                        </a>
                    </li>
                </sec:authorize>

                <!-- Institution Links -->
                <sec:authorize access="hasRole('ROLE_INSTITUTIONAL_ADMIN')">
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/institution/dashboard">
                            Dashboard
                        </a>
                    </li>
                </sec:authorize>
            </ul>

            <!-- Right Side — User Info + Logout -->
            <ul class="navbar-nav ms-auto align-items-center">
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item me-3">
                        <span class="navbar-text text-white-50 small">
                            <sec:authentication property="name"/>
                        </span>
                    </li>

                    <sec:authorize access="isAuthenticated()">
                        <li class="nav-item me-1">
                            <%--
                                We need unread count here. Since navbar is included
                                via <%@ include %> it shares the same request scope.
                                We use a simple JSTL-friendly approach — link to
                                notifications page. The count is loaded per-page
                                via a request attribute set in a common place.
                                For now we show the bell and rely on the page visit
                                to show the count. See Step 9 for the count approach.
                            --%>
                            <a href="${pageContext.request.contextPath}/notifications"
                               class="nav-link text-white position-relative"
                               title="Notifications">
                                🔔
                                <c:if test="${unreadCount > 0}">
                                    <span class="position-absolute top-0 start-100
                                                 translate-middle badge rounded-pill
                                                 bg-danger"
                                          style="font-size:0.6rem; padding: 3px 5px;">
                                        ${unreadCount}
                                    </span>
                                </c:if>
                            </a>
                        </li>
                    </sec:authorize>

                    <sec:authorize access="isAuthenticated()">
                        <li class="nav-item me-2">
                            <a href="${pageContext.request.contextPath}/profile"
                               class="nav-link text-white-50">
                                My Profile
                            </a>
                        </li>
                    </sec:authorize>


                    <li class="nav-item">
                        <form action="${pageContext.request.contextPath}/logout"
                              method="post" class="d-inline">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>
                            <button type="submit"
                                    class="btn btn-outline-light btn-sm">
                                Logout
                            </button>
                        </form>
                    </li>
                </sec:authorize>

                <sec:authorize access="isAnonymous()">
                    <li class="nav-item me-2">
                        <a href="${pageContext.request.contextPath}/login"
                           class="btn btn-outline-light btn-sm">Login</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/register"
                           class="btn btn-light btn-sm">Register</a>
                    </li>
                </sec:authorize>
            </ul>

        </div>
    </div>
</nav>