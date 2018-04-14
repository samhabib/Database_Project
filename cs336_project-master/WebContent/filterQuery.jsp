<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Apply Filters</title>
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
<a href = "createAuction.jsp">Create an Auction</a>
</div>

<br>



<div>
<h2>Filter Auctions</h2>
<%
	try{

		//Check filtering
		String filterType = request.getParameter("method");
		
		
		//AND statements change the filtering options to radio buttons within each category
		if(filterType.equals("AND")){%>
			
			<!-- Re-instantiate the table with the filters selected in new page -->
			<form method = post action = "filterResults.jsp">
				<h5>Filter method</h5>
				<input type = "radio" name="method" value = "AND" checked>Combine choices (AND)
				<input type = "radio" name="method" value = "OR">Group choices (OR)
				
				<h5>Shoe Color</h5>
				<input type = "radio" name="color" value = "Black">Black
				<input type = "radio" name="color" value = "White">White
				<input type = "radio" name="color" value = "Gray">Gray
				<input type = "radio" name="color" value = "Blue">Blue
				
				<h5>Shoe Size</h5>
				<input type = "text" name="shoesize">
				
				<h5>Shoe Style</h5>
				<input type = "radio" name="style" value = "Sneaker">Sneaker
				<input type = "radio" name="style" value = "Dress">Dress
				<input type = "radio" name="style" value = "Sandal">Sandal
				<input type = "radio" name="style" value = "Boot">Boot
			
				<h5>Price</h5>
				Enter price comparisons separated by spaces. Ex: >1000 is greater than 1000.
				<br>
				<input type = "text" name = "bidprice">
			
				<br>
				<input type = "submit" name="filter" value="Apply Filter">
			</form>
			
			
		<%}
		//OR statements enable checkboxes within each category
		else if (filterType.equals("OR")){ 
		%> 	
			<!-- OR FILTER OPTIONS -->
			<!-- Re-instantiate the table with the filters selected in new page -->
			<form method = post action = "filterResults.jsp">
				<h5>Filter method</h5>
				<input type = "radio" name="method" value = "AND">Combine choices (AND)
				<input type = "radio" name="method" value = "OR" checked>Group choices (OR)
				
				<h5>Shoe Color</h5>
				<input type = "checkbox" name="color" value = "Black">Black
				<input type = "checkbox" name="color" value = "White">White
				<input type = "checkbox" name="color" value = "Gray">Gray
				<input type = "checkbox" name="color" value = "Blue">Blue
				
				<h5>Shoe Size</h5>
				Enter shoe sizes separated by spaces.
				<input type = "text" name="shoesize">
				
				<h5>Shoe Style</h5>
				<input type = "checkbox" name="style" value = "Sneaker">Sneaker
				<input type = "checkbox" name="style" value = "Dress">Dress
				<input type = "checkbox" name="style" value = "Sandal">Sandal
				<input type = "checkbox" name="style" value = "Boot">Boot
				
				<h5>Price</h5>
				Enter price comparisons separated by spaces. Ex: >1000 is greater than 1000.
				<br>
				<input type = "text" name = "bidprice">
				
				<br>
				<input type = "submit" name="filter" value="Apply Filter">
			</form>
			
		<%}
		//Empty queries cause a return to the original page.
		else{
			response.sendRedirect("searchBrowse.jsp");
		}
		
		
	}catch(Exception e){
		out.println(e);
	}




%>

</div>


</body>