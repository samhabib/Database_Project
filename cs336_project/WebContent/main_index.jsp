<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css" media="screen" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Candle Feet Home</title>
</head>
<body>
<!-- Welcome Banner code -->
<div align = center class = "banner">
Welcome to Candle Feet
</div>

<br>

<!-- Navigation Bar code -->
<div align= center class = "navigation">
<a href = "main_index.jsp">HOME</a>
<% 
	if(session.getAttribute("user") == null){
%>
<a href = "registerOrLogin.jsp">Sign up or Sign in</a>
<%} else{
%>
<a href = "logOut.jsp">Log Out</a>
<%}%>
<a href = "searchBrowse.jsp">Search & Browse</a>
<a href = "createAuction.jsp">Create an Auction</a>
</div>

<br>

<!-- Welcome page site description code -->
<div align = center class = "body">
Welcome to Candle Feet, <%if (session.getAttribute("user")==null){out.print("New User");}else{out.print(session.getAttribute("user"));}%>, the internet's premier footwear auction house!
<br>
Create a new account to get started or go ahead and browse through ongoing auctions for the foot adornment of your dreams!
</div>



</body>
</html>