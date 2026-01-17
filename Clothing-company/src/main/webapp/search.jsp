<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Search Cloth</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body{background:linear-gradient(to right,#232526,#414345);}
.card{border-radius:15px;}
.btn-search{background:#00c6ff;color:white;}
</style>
</head>

<body>
<div class="container d-flex justify-content-center align-items-center min-vh-100">
<div class="card shadow p-4" style="width:450px">

<h3 class="text-center mb-3">🔍 Search Cloth</h3>

<form action="searchCloth" method="get">

    <div class="mb-3">
        <label>Search By</label>
        <select name="searchType" class="form-control" required>
            <option value="id">Cloth ID</option>
            <option value="name">Cloth Name</option>
            <option value="brand">Brand</option>
            <option value="type">Type</option>
        </select>
    </div>

    <div class="mb-3">
        <label>Enter Value</label>
        <input type="number" name="id" class="form-control" required>
    </div>

    <button class="btn btn-search w-100">Search</button>

</form>
</div>
</div>
</body>
</html>
