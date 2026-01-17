<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<title>Cloth Result</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow p-4">
        <h3 class="mb-3">Cloth Details</h3>


        <table class="table table-bordered table-striped">
            <tr class="table-dark">
                <th>ID</th>
                <th>Cloth Name</th>
                <th>Brand</th>
                <th>Type</th>
                <th>Size</th>
                <th>Color</th>
                <th>Price</th>
                <th>Material</th>
                <th>Available</th>
            </tr>

            <tr>
                <td>${cloth.id}</td>
                <td>${cloth.clothName}</td>
                <td>${cloth.brand}</td>
                <td>${cloth.type}</td>
                <td>${cloth.size}</td>
                <td>${cloth.color}</td>
                <td>₹ ${cloth.price}</td>
                <td>${cloth.material}</td>


                <td>
                    <c:choose>
                        <c:when test="${cloth.available}">
                            <span class="text-success">Yes</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger">No</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>



        <form action="update" method="get" class="mt-3">

            <input type="hidden" name="id" value="${cloth.id}">
            <input type="hidden" name="clothName" value="${cloth.clothName}">
            <input type="hidden" name="brand" value="${cloth.brand}">
            <input type="hidden" name="type" value="${cloth.type}">
            <input type="hidden" name="size" value="${cloth.size}">
            <input type="hidden" name="color" value="${cloth.color}">
            <input type="hidden" name="price" value="${cloth.price}">
            <input type="hidden" name="material" value="${cloth.material}">
            <input type="hidden" name="available" value="${cloth.available}">

            <button class="btn btn-warning w-100">
                ✏ Update This Cloth
            </button>

        </form>


        <a href="deleteCloth?id=${cloth.id}"
           class="btn btn-danger w-100 mt-3"
           onclick="return confirm('Are you sure you want to delete this cloth?');">
            🗑 Delete This Cloth
        </a>




        <a href="search.jsp" class="btn btn-primary">Search Another</a>
    </div>
</div>

</body>
</html>
