<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product Registration</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">

            <div class="card shadow-lg">
                <div class="card-header bg-success text-white text-center">
                    <h4>Product Registration</h4>
                </div>

                <div class="card-body">

                    <!-- MUST match @PostMapping("product") -->
                    <form action="product" method="post">

                        <!-- Product Name -->
                        <div class="mb-3">
                            <label class="form-label">Product Name</label>
                            <input type="text" name="name" class="form-control"
                                   value="${param.name}">
                            <small class="text-danger">${nameError}</small>
                        </div>

                        <!-- Quantity -->
                        <div class="mb-3">
                            <label class="form-label">Quantity</label>
                            <input type="number" name="quantity" class="form-control"
                                   value="${param.quantity}">
                            <small class="text-danger">${quantityError}</small>
                        </div>

                        <!-- Type -->
                        <div class="mb-3">
                            <label class="form-label">Product Type (E/N)</label>
                            <input type="text" name="type" maxlength="1"
                                   class="form-control"
                                   value="${param.type}">
                            <small class="text-danger">${typeError}</small>
                        </div>

                        <!-- Code -->
                        <div class="mb-3">
                            <label class="form-label">Product Code</label>
                            <input type="number" name="code" class="form-control"
                                   value="${param.code}">
                            <small class="text-danger">${codeError}</small>
                        </div>

                        <!-- Rating -->
                        <div class="mb-3">
                            <label class="form-label">Product Rating</label>
                            <input type="number" step="0.1" name="rating"
                                   class="form-control"
                                   value="${param.rating}">
                            <small class="text-danger">${ratingError}</small>
                        </div>

                        <!-- Price -->
                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" step="0.01" name="price"
                                   class="form-control"
                                   value="${param.price}">
                            <small class="text-danger">${priceError}</small>
                        </div>

                        <!-- Available -->
                        <input type="hidden" name="available" value="false">
                        <div class="mb-3 form-check">
                            <input type="checkbox" name="available" value="true"
                                   class="form-check-input"
                                   <c:if test="${param.available eq 'true'}">checked</c:if>>
                            <label class="form-check-label">Available</label>
                        </div>

                        <!-- Warranty -->
                        <div class="mb-3">
                            <label class="form-label">Warranty (Years)</label>
                            <input type="number" name="warranty"
                                   class="form-control"
                                   value="${param.warranty}">
                            <small class="text-danger">${warrantyError}</small>
                        </div>

                        <!-- Level -->
                        <div class="mb-3">
                            <label class="form-label">Quality Level (1–10)</label>
                            <input type="number" name="level" min="1" max="10"
                                   class="form-control"
                                   value="${param.level}">
                            <small class="text-danger">${levelError}</small>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-success">
                                Register Product
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
