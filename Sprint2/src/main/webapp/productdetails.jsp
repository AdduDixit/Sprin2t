<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details - EazyDeals</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #3D8D7A, #A3D1C6, #FBFFE4);
            font-family: 'Poppins', sans-serif;
            color: black;
        }
        .container {
            margin-top: 30px;
            background: #FBFFE4;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .product-image {
            width: 300px;
            height: 300px;
            object-fit: cover;
            border-radius: 10px;
        }
        .btn-buy {
            background-color: #3D8D7A;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
        }
        /* Ensuring all text remains black */
        h3, h4, p, strong, span, a {
            color: black !important;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<%@ include file="navbar.jsp" %>

<%
    // Mock product data
    String productId = request.getParameter("id");
    String productName = "Unknown Product";
    String productImage = "img/default.jpg";
    String productPrice = "N/A";

    if (productId != null) {
        if (productId.equals("1")) {
            productName = "Men Printed Casual Jacket";
            productImage = "img/product1.jpg";
            productPrice = "₹860";
        } else if (productId.equals("2")) {
            productName = "Samsung Galaxy S23 5G";
            productImage = "img/product2.jpg";
            productPrice = "₹66,400";
        }
    }
%>

<!-- Product Details -->
<div class="container">
    <h3 class="text-center"><%= productName %></h3>
    <div class="row">
        <div class="col-md-6 text-center">
            <img src="<%= productImage %>" alt="<%= productName %>" class="product-image">
        </div>
        <div class="col-md-6">
            <h4>Price: <%= productPrice %></h4>
            <p><strong>Description:</strong> This is a high-quality product available on EazyDeals.</p>
            <button class="btn-buy">Buy Now</button>
            <button class="btn-buy">Add to Cart</button>
        </div>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>