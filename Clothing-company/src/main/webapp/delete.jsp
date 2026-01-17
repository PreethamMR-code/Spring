<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Delete Cloth</title>

<link href="https://cdn.jsdelivr.net/npmbootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background: linear-gradient(to right,#232526,#414345);
}
.card{
    border-radius:15px;
}
</style>
</head>

<body>

<div class="container d-flex justify-content-center align-items-center min-vh-100">

    <div class="card shadow p-4 text-center" style="width:450px">

        <h3 class="mb-3">🗑 Delete Cloth</h3>

        <!-- Success -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <!-- Error -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <a href="search.jsp" class="btn btn-primary mt-3">
            🔍 Back to Search
        </a>

        <a href="index.jsp" class="btn btn-outline-light mt-2">
            🏠 Home
        </a>

    </div>

</div>

</body>
</html>
