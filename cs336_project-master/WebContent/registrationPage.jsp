<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register Here</title>
</head>
<body>

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
<a href = "CREATEAUCTION.jsp">Create an Auction</a>
</div>

<br>

<!-- Registration box code -->
<div align = center>
<form method="post" action="submitInfo.jsp">
<table>
	<tr>
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Register">
</form>
</div>

</body>
</html>