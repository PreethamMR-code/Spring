<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head><title>NexMeet - Dashboard</title></head>
<body>
    <h1>Dashboard</h1>
    <p>Welcome! You are logged in as: <strong>${pageContext.request.userPrincipal.name}</strong></p>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
</body>

</html>