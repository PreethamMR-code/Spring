<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Result</title>
</head>

<body>

<h2 style="color:green;">Form Submitted Successfully</h2>

<hr>

<h3>Submitted Details</h3>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>Field</th>
        <th>Value</th>
    </tr>

    <!-- Name -->
    <c:if test="${not empty dto.name}">
        <tr>
            <td>Name</td>
            <td>${dto.name}</td>
        </tr>
    </c:if>

    <!-- Age / Duration / Quantity -->
    <c:if test="${not empty dto.age}">
        <tr>
            <td>Age</td>
            <td>${dto.age}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.duration}">
        <tr>
            <td>Duration</td>
            <td>${dto.duration}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.quantity}">
        <tr>
            <td>Quantity</td>
            <td>${dto.quantity}</td>
        </tr>
    </c:if>

    <!-- Gender / Type / Mode -->
    <c:if test="${not empty dto.gender}">
        <tr>
            <td>Gender</td>
            <td>${dto.gender}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.type}">
        <tr>
            <td>Type</td>
            <td>${dto.type}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.mode}">
        <tr>
            <td>Mode</td>
            <td>${dto.mode}</td>
        </tr>
    </c:if>

    <!-- Phone / Code -->
    <c:if test="${not empty dto.phone}">
        <tr>
            <td>Phone</td>
            <td>${dto.phone}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.code}">
        <tr>
            <td>Code</td>
            <td>${dto.code}</td>
        </tr>
    </c:if>

    <!-- Rating / Performance -->
    <c:if test="${not empty dto.rating}">
        <tr>
            <td>Rating</td>
            <td>${dto.rating}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.performance}">
        <tr>
            <td>Performance</td>
            <td>${dto.performance}</td>
        </tr>
    </c:if>

    <!-- Amounts -->
    <c:if test="${not empty dto.fees}">
        <tr>
            <td>Fees</td>
            <td>${dto.fees}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.salary}">
        <tr>
            <td>Salary</td>
            <td>${dto.salary}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.price}">
        <tr>
            <td>Price</td>
            <td>${dto.price}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.charge}">
        <tr>
            <td>Charge</td>
            <td>${dto.charge}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.budget}">
        <tr>
            <td>Budget</td>
            <td>${dto.budget}</td>
        </tr>
    </c:if>

    <!-- Boolean -->
    <c:if test="${dto.active == true || dto.available == true}">
        <tr>
            <td>Status</td>
            <td>Active</td>
        </tr>
    </c:if>

    <!-- short fields -->
    <c:if test="${not empty dto.experience}">
        <tr>
            <td>Experience</td>
            <td>${dto.experience}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.semester}">
        <tr>
            <td>Semester</td>
            <td>${dto.semester}</td>
        </tr>
    </c:if>

    <c:if test="${not empty dto.supportPeriod}">
        <tr>
            <td>Support Period</td>
            <td>${dto.supportPeriod}</td>
        </tr>
    </c:if>

    <!-- byte -->
    <c:if test="${not empty dto.level}">
        <tr>
            <td>Level</td>
            <td>${dto.level}</td>
        </tr>
    </c:if>

</table>

<br>

<a href="index.jsp">⬅ Back to Dashboard</a>

</body>
</html>
