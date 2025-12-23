<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page isELIgnored = "false" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>search</title>
</head>
<body>

<form action ="search">

<div class="mb-3">
    <label class="form-label">Restaurant Name</label>
    <input type="text" id="restaurantName" name="restaurantName" class="form-control" placeholder="Enter restaurant name" required>
</div>

<input type="submit" class="btn btn-primary w-100"></button>
</form>

${zomatoDTO.getOwnerName()}
${zomatoDTO.getEmail()}
${zomatoDTO.getRestaurantName()}
${zomatoDTO.getFoodStyles()}
${zomatoDTO.getCity()}
${zomatoDTO.getNumber()}
${zomatoDTO.getStars()}

<h4> <a href = "getRestaurant?restaurantName=${zomatoDTO.getOwnerName()}" > edit </a> </h4>


</body>
</html>