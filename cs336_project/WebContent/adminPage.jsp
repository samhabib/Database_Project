<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>

</head>
<body>
<!-- Welcome Banner code -->
<div align = center class = "banner">
<h1>Candle Feet - Admin Page</h1>
</div>
<!-- Navigation Bar code -->
<div align= center class = "navigation">
<a href = "logOut.jsp">Log Out</a>
</div>

<br>

<!-- Create a New Customer Representative -->
<form method="post" action="submitInfo.jsp">
<table>
	<tr>
	<td>Create a New Customer Representative:</td>
	</tr>
	<tr>
	<td>Username <input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password <input type="password" name="password"></td>
	</tr>
	<tr><input type = "hidden" name ="account_type" value="cus_rep">
	</tr>
	</table>
	<br>
	<input type="submit" value="Login">
</form>

<br>
<br>

	<table>
	<tr>
	<td>Select how you want to Generate a Report For:</td>
	</tr>
	</table>


<!-- Generate Sales Report -->
<form method="post" action="generateReport.jsp">
	<table>
	<tr>
	<td><select name="report_style">
  			<option value="earnings_total">Total Earnings</option>
  			<option value="earnings_per_item">Earnings Per Item</option>
  			<option value="earnings_per_type">Earnings Per Type</option>
  			<option value="earnings_per_user">Earnings Per End-User</option>
  			<option value="best_selling_items">Best Selling Items</option>
  			<option value="best_buyers">Best Buyers</option>
	</select></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Generate Sales Report">
</form>


</body>
</html>