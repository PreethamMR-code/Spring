<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Cloth Registration Status</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
}
.card{
    border-radius:15px;
}
</style>

</head>

<body>

<div class="container d-flex justify-content-center align-items-center min-vh-100">

    <div class="card shadow p-4 text-center" style="width:400px">

        <%
            String msg = (String) request.getAttribute("message");
            Boolean status = (Boolean) request.getAttribute("status");
        %>

        <% if(status != null && status) { %>
            <h3 class="text-success">✅ Success</h3>
            <p><%= msg %></p>
        <% } else { %>
            <h3 class="text-danger">❌ Failed</h3>
            <p><%= msg %></p>
        <% } %>

        <a href="registration.jsp" class="btn btn-primary mt-3">Register Another Cloth</a>

    </div>

</div>

</body>
</html>
