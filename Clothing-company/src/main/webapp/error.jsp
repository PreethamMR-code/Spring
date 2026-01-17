<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Error</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f8d7da;
}
.card{
    border-radius:15px;
}
</style>
</head>

<body>

<div class="container d-flex justify-content-center align-items-center min-vh-100">

    <div class="card shadow p-4 text-center" style="width:400px">

${message}
        <h3 class="text-danger">❌ Cloth Not Found</h3>

        <p class="mt-3">
            Sorry, we could not find any cloth matching your search.
        </p>

        <a href="search.jsp" class="btn btn-danger mt-3">Try Again</a>

    </div>

</div>

</body>
</html>
