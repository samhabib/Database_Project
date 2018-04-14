<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Here</title>
</head>
<body>

<!-- Navigation Bar code -->
<div align= center class = "navigation">

<td>Welcome To Customer Representative Page</td><br />
<a href = "logOut.jsp">Log Out</a>

<form method="post" action="messageBoardRep.jsp">
	<br>
	<br>
	<br>
	<br>
	<br>
	<input type="submit" value="Go To Message Board Page [Customer Representative View]">
</form>
</div>
</body>
</html>