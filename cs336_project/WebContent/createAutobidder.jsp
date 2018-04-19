<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create An Auction</title>
<link rel="stylesheet" type="text/css" href="style.css" />
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

<% 
	if (session.getAttribute("user") == null) {
		response.sendRedirect("loginPage.jsp");
	} else {
		out.println("Please create your autobidder, <b>" + session.getAttribute("user") + "</b><br>");
	}
%>
<form method="post" action="submitAutobidder.jsp">
<table>
	<tbody>
		<tr>
			<td>Upper cap of bidding</td>
			<td><input type="text" name="upperCap"></td>
		</tr>
		<tr>
			<td>Initial bid</td>
			<td><input type="text" name="bidAmount"></td>
		</tr>
	</tbody>
</table>
	<i>An initial bid is not required, but bids will not take effect until someone else bids.</i>
	<input type="hidden" name="auctionID" value="<%out.println(request.getParameter("auctionID"));%>">
	<input type="hidden" name="userID" value="<%out.println(session.getAttribute("user"));%>">
	<br>
	<input type="submit" value="Create">
</form>
</body>
</html>