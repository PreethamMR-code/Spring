<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Registration</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-7">

            <div class="card shadow-lg">
                <div class="card-header bg-warning text-dark text-center">
                    <h4>Customer Registration</h4>
                </div>

                <div class="card-body">

                    <!-- MUST match @PostMapping("customer") -->
                    <form action="customer" method="post">

                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label">Customer Name</label>
                            <input type="text" name="name" class="form-control"
                                   value="${param.name}">
                            <small class="text-danger">${nameError}</small>
                        </div>

                        <!-- Age -->
                        <div class="mb-3">
                            <label class="form-label">Age</label>
                            <input type="number" name="age" class="form-control"
                                   value="${param.age}">
                            <small class="text-danger">${ageError}</small>
                        </div>

                        <!-- Gender -->
                        <div class="mb-3">
                            <label class="form-label">Gender (M/F)</label>
                            <input type="text" name="gender" maxlength="1"
                                   class="form-control"
                                   value="${param.gender}">
                            <small class="text-danger">${genderError}</small>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label class="form-label">Mobile Number</label>
                            <input type="number" name="phone" class="form-control"
                                   value="${param.phone}">
                            <small class="text-danger">${phoneError}</small>
                        </div>

                        <!-- Rating -->
                        <div class="mb-3">
                            <label class="form-label">Customer Rating</label>
                            <input type="number" step="0.1" name="rating"
                                   class="form-control"
                                   value="${param.rating}">
                            <small class="text-danger">${ratingError}</small>
                        </div>

                        <!-- Total Purchase -->
                        <div class="mb-3">
                            <label class="form-label">Total Purchase Amount</label>
                            <input type="number" step="0.01" name="totalPurchase"
                                   class="form-control"
                                   value="${param.totalPurchase}">
                            <small class="text-danger">${totalPurchaseError}</small>
                        </div>

                        <!-- Active -->
                        <input type="hidden" name="active" value="false">
                        <div class="mb-3 form-check">
                            <input type="checkbox" name="active" value="true"
                                   class="form-check-input"
                                   <c:if test="${param.active eq 'true'}">checked</c:if>>
                            <label class="form-check-label">Active Customer</label>
                        </div>

                        <!-- Loyalty Years -->
                        <div class="mb-3">
                            <label class="form-label">Loyalty Years</label>
                            <input type="number" name="loyaltyYears"
                                   class="form-control"
                                   value="${param.loyaltyYears}">
                            <small class="text-danger">${loyaltyYearsError}</small>
                        </div>

                        <!-- Level -->
                        <div class="mb-3">
                            <label class="form-label">Customer Level (1–10)</label>
                            <input type="number" name="level" min="1" max="10"
                                   class="form-control"
                                   value="${param.level}">
                            <small class="text-danger">${levelError}</small>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-warning">
                                Register Customer
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
