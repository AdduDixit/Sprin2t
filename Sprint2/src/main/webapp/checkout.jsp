<%@ page import="java.util.*, com.xp.bean.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Checkout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid black;
        }
        th {
            background-color: #f2f2f2;
        }
        .checkout-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background-color: green;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-radius: 5px;
        }
        .checkout-btn:hover {
            background-color: darkgreen;
        }
    </style>
</head>
<body>
    <h2 style="text-align: center;">Checkout</h2>

    <%
        // Retrieve the cart from the session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double totalPrice = 0;
    %>

    <% if (cart == null || cart.isEmpty()) { %>
        <h3 style="text-align: center; color: red;">Your cart is empty!</h3>
    <% } else { %>
        <table>
            <tr>
                <th>Product Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>

            <% for (CartItem item : cart) { 
                double subtotal = item.getPrice() * item.getQuantity();
                totalPrice += subtotal;
            %>
            <tr>
                <td><%= item.getName() %></td>
                <td>$<%= item.getPrice() %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= subtotal %></td>
            </tr>
            <% } %>

            <tr>
                <td colspan="3" style="text-align: right; font-weight: bold;">Total Price:</td>
                <td><b>$<%= totalPrice %></b></td>
            </tr>
        </table>

        <form action="OrderServlet" method="post">
            <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
            <input type="submit" value="Confirm Order" class="checkout-btn">
        </form>
    <% } %>
    
    <p style="text-align: center;"><a href="products.jsp">Continue Shopping</a></p>
</body>
</html>