<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Update Cloth</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

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

    <div class="card shadow p-4" style="width:550px">

        <h3 class="text-center mb-3">✏ Update Cloth</h3>

        <!-- Success Message -->
        <c:if test="${not empty success}">
            <div class="alert alert-success text-center">${success}</div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>

        <form action="updateCloth" method="post">

            <!-- ID (Read Only) -->
            <div class="mb-2">
                <label>Cloth ID</label>
                <input type="number" name="id" class="form-control" value="${cloth.id}" readonly>
            </div>

            <div class="mb-2">
                <label>Cloth Name</label>
                <input type="text" name="clothName" class="form-control" value="${cloth.clothName}">
            </div>

            <div class="mb-2">
                <label>Brand</label>
                <input type="text" name="brand" class="form-control" value="${cloth.brand}">
            </div>

            <div class="mb-2">
                <label>Type</label>
                <select name="type" class="form-control">
                    <option ${cloth.type=='T-Shirt'?'selected':''}>T-Shirt</option>
                    <option ${cloth.type=='Shirt'?'selected':''}>Shirt</option>
                    <option ${cloth.type=='Jeans'?'selected':''}>Jeans</option>
                    <option ${cloth.type=='Kurta'?'selected':''}>Kurta</option>
                    <option ${cloth.type=='Jacket'?'selected':''}>Jacket</option>
                </select>
            </div>

            <div class="mb-2">
                <label>Size</label>
                <select name="size" class="form-control">
                    <option ${cloth.size=='S'?'selected':''}>S</option>
                    <option ${cloth.size=='M'?'selected':''}>M</option>
                    <option ${cloth.size=='L'?'selected':''}>L</option>
                    <option ${cloth.size=='XL'?'selected':''}>XL</option>
                    <option ${cloth.size=='XXL'?'selected':''}>XXL</option>
                </select>
            </div>

            <div class="mb-2">
                <label>Color</label>
                <input type="text" name="color" class="form-control" value="${cloth.color}">
            </div>

            <div class="mb-2">
                <label>Price</label>
                <input type="number" name="price" class="form-control" step="0.01" value="${cloth.price}">
            </div>

            <div class="mb-2">
                <label>Material</label>
                <input type="text" name="material" class="form-control" value="${cloth.material}">
            </div>

            <div class="mb-3">
                <label>Available</label>
                <select name="available" class="form-control">
                    <option value="true" ${cloth.available?'selected':''}>Yes</option>
                    <option value="false" ${!cloth.available?'selected':''}>No</option>
                </select>
            </div>

            <button class="btn btn-primary w-100">Update Cloth</button>

        </form>

        <div class="text-center mt-3">
            <a href="search.jsp" class="btn btn-outline-light">Back to Search</a>
        </div>

    </div>

</div>

</body>
</html>
