<%@ page import="java.util.List, com.xp.bean.CartItem" %>
<html>
<head>
<%@ include file="navbar.jsp" %>

    <title>Order Confirmation</title>
</head>
<body>
    <h2>Your Shopping Cart</h2>
    <%
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
    %>
        <p>Your cart is empty.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr><th>Name</th><th>Price</th><th>Quantity</th><th>Total</th><th>Action</th></tr>
            <% double totalPrice = 0; %>
            <%
                for (CartItem item : cart) {
                    double total = item.getPrice() * item.getQuantity();
                    totalPrice += total;
            %>
            <tr>
                <td><%= item.getName() %></td>
                <td>$<%= item.getPrice() %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= total %></td>
                <td><a href="RemoveFromCartServlet?id=<%= item.getId() %>">Remove</a></td>
            </tr>
            <% } %>
        </table>
        <h3>Total: $<%= totalPrice %></h3>
        <a href="checkout.jsp">Proceed to Checkout</a>
    <% } %>
</body>
</html>