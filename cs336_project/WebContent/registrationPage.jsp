<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Page</title>

</head>
<body>
<!-- Welcome Banner code -->
<div align = center class = "banner">
<h1>Candle Feet - Shoe Auction House</h1>
</div>
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
<a href = "messageBoardUser.jsp">Go to Question Board</a>
</div>
<br>

<!-- Registration box code -->
<div align = left>
<form method="post" action="submitInfo.jsp">
<table>
	<tr>
	<td>Username:<input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password:<input type="password" name="password"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Register">
</form>
</div>

</body>
</html>