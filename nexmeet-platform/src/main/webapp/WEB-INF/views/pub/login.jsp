<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head><title>NexMeet - Login</title></head>
<body>
    <h1>NexMeet Login</h1>

    <%-- Show error message if login failed --%>
    <% if(request.getParameter("error") != null) { %>
        <p style="color:red">Invalid email or password.</p>
    <% } %>

    <%-- Show logout message --%>
    <% if(request.getParameter("logout") != null) { %>
        <p style="color:green">You have been logged out.</p>
    <% } %>

    <!--
        action="/nexmeet/login/process" matches the
        login-processing-url in spring-security.xml.
        Spring Security intercepts this URL and handles
        authentication automatically — we don't need a
        controller method for this URL.
    -->
    <form action="/nexmeet/login/process" method="post">
        <div>
            <label>Email:</label>
            <!-- name="email" must match username-parameter in security config -->
            <input type="text" name="username" required />
        </div>
        <div>
            <label>Password:</label>
            <!-- name="password" must match password-parameter in security config -->
            <input type="password" name="password" required />
        </div>
        <button type="submit">Login</button>
    </form>
</body>
</html>