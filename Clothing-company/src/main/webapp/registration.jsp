<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Clothing App | Register Cloth</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background: linear-gradient(to right,#141E30,#243B55);
}

.card{
    border-radius:15px;
}

.btn-save{
    background:#ff7a18;
    color:white;
}

/* Top bar */
.top-bar{
    position:absolute;
    top:20px;
    right:30px;
}
</style>
</head>

<body>

<!-- Top Right Buttons -->
<div class="top-bar">
    <a href="index.jsp" class="btn btn-light me-2">🏠 Home</a>
    <a href="search.jsp" class="btn btn-primary">🔍 Search</a>
</div>

<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="card shadow-lg p-4" style="width:500px">

        <h3 class="text-center mb-3">👕 Cloth Registration</h3>

        <form action="cloth" method="post">

            <div class="mb-2">
                <label>Cloth ID</label>
                <input type="number" name="id" class="form-control" required>
            </div>

            <div class="mb-2">
                <label>Cloth Name</label>
                <input type="text" name="clothName" class="form-control" required>
            </div>

            <div class="mb-2">
                <label>Brand</label>
                <input type="text" name="brand" class="form-control" required>
            </div>

            <div class="mb-2">
                <label>Type</label>
                <select name="type" class="form-control">
                    <option>T-Shirt</option>
                    <option>Shirt</option>
                    <option>Jeans</option>
                    <option>Kurta</option>
                    <option>Jacket</option>
                </select>
            </div>

            <div class="mb-2">
                <label>Size</label>
                <select name="size" class="form-control">
                    <option>S</option>
                    <option>M</option>
                    <option>L</option>
                    <option>XL</option>
                    <option>XXL</option>
                </select>
            </div>

            <div class="mb-2">
                <label>Color</label>
                <input type="text" name="color" class="form-control">
            </div>

            <div class="mb-2">
                <label>Price (₹)</label>
                <input type="number" name="price" class="form-control" step="0.01">
            </div>

            <div class="mb-2">
                <label>Material</label>
                <input type="text" name="material" class="form-control">
            </div>

            <div class="mb-3">
                <label>Available</label>
                <select name="available" class="form-control">
                    <option value="true">Yes</option>
                    <option value="false">No</option>
                </select>
            </div>

            <button class="btn btn-save w-100">Save Cloth</button>

        </form>

    </div>
</div>

</body>
</html>
