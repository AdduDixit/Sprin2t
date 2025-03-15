<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FBFFE4;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #3D8D7A;
            padding: 15px;
            text-align: center;
            color: white;
            font-size: 20px;
        }
        .container {
            width: 50%;
            margin: auto;
            background: #B3D8A8;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            display: block;
            margin: auto;
        }
        .info {
            text-align: center;
            font-size: 18px;
        }
        .edit-btn {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
        .edit-btn a {
            background: #A3D1C6;
            padding: 10px 20px;
            text-decoration: none;
            color: black;
            border-radius: 5px;
        }
        .footer {
            background: #3D8D7A;
            padding: 10px;
            color: white;
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="navbar">User	 | Profile</div>
    
    <div class="container">
        <img src="profile-pic.jpg" alt="Profile Picture" class="profile-img">
        <div class="info">
            <p><strong>Full Name:</strong> <%= session.getAttribute("userFullName") %></p>
            <p><strong>Email:</strong> <%= session.getAttribute("username") %></p>
            <p><strong>Phone:</strong> <%= session.getAttribute("userPhone") %></p>
            <p><strong>Address:</strong> <%= session.getAttribute("userAddress") %></p>
            <p><strong>Pin Code:</strong> <%= session.getAttribute("userPinCode") %></p>
        </div>
        <div class="edit-btn">
            <a href="editProfile.jsp">Edit Profile</a>
        </div>
    </div>
    
    <form action="OrderHistoryServlet" method ="get">
    	<input type ="submit" value = "Show Order History" >
    </form>
    
    <div class="footer">&copy; 2025 Shopping Center | About Us | Contact | Privacy Policy</div>
</body>
</html>