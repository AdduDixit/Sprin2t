<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.xp.dbConnection.*" %>

<%
	String productId = request.getParameter("id");
	
	dbConnection dbc= new dbConnection();
	
	Connection conn= dbc.createConnection();
	PreparedStatement pst= conn.prepareStatement("Select * FROM products WHERE id = ?");
	pst.setInt(1, Integer.parseInt(productId));
	ResultSet rs = pst.executeQuery();

	if(rs.next()) {
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> <%= rs.getString("name") %> </title>


</head>
<body>
	<div class="product-details">
		<h2> <%= rs.getString("name") %></h2>
		<p> <strong><%= rs.getString("description") %> </strong>  </p>
		<p> <strong><%= rs.getString("price") %> </strong>  </p>
		<form action="AddToCartServlet" method="post">
			<input type="hidden" name="productId" value="<% rs.getInt("id");%>">
			<button type="submit">Add to Cart</button>
		</form>
		
		
	</div>
</body>
</html>

<%
	} else {
		out.println("<h3> Product Not Found </h3>");
	}
	
	rs.close();
	pst.close();
	conn.close();

%>
