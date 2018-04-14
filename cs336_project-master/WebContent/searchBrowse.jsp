<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css" media="screen" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search & Browse</title>
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

<!-- Search Bar code -->
<div align = left>
	<h1>Search for Shoes</h1>
	<form method = post action = "searchQuery.jsp">
		Search returns item auctions with greatest relevance to search terms.
		<br>
		Enter Single search terms
		<select name = "searchType">
			<option value = "details">Item Details</option>
			<option value = "searchColor">Color</option>
			<option value = "searchSize">Shoe Size</option>
			<option value = "searchStyle">Shoe Style</option>
		</select>
		<input type = "text" name = "searchBar">
		<br>
		<input type = "submit" value = Search>
	</form>
</div>

<br>

<!-- Auction browser -->
<div align=left>
	<h2>Ongoing Auctions</h2>
	<h3>Filter Auctions</h3>
		<!-- Re-instantiate the table with the filters selected in new page -->
		<form method = post action = "filterQuery.jsp">
			<h5>Filter method</h5>
			<input type = "radio" name="method" value = "AND" checked>Combine choices (AND)
			<input type = "radio" name="method" value = "OR">Group choices (OR)
		
			<input type = "submit" name="filter" value="Begin Filter">
		</form>

		<!-- link button -->
		
</div>

	
<div align = left>
	<!-- Insert a table of all auctions currently in the auctions table -->
	<%
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT SQL statement
			String str = "SELECT DISTINCT * FROM Auctions a, Item i WHERE a.auctionItemID = i.itemID";
			
			//Executing SQL query
			ResultSet result = stmt.executeQuery(str);
			
			//Create table headers
			out.print("<table style='width:100%'>");
			
			out.print("<tr>");
			//auctionID
			out.print("<th>");
			out.print("Auction #");
			out.print("</th>");
			
			//auctionItemID
			out.print("<th>");
			out.print("ItemID");
			out.print("</th>");
			
			//itemDetails
			out.print("<th>");
			out.print("Item Details");
			out.print("</th>");
			
			//timeleft
			out.print("<th>");
			out.print("Time Remaining");
			out.print("</th>");
			
			//Auctioneer
			out.print("<th>");
			out.print("Auctioneer");
			out.print("</th>");
			
			out.print("</tr>");
			out.print("<br>");
			
			//Fill Table with the above attributes
			//Order is : 
			// auctionID - auctionItemID - Item Details - TimeLeft - Auctioneer
			while(result.next()){
				
				//Make row
				out.print("<tr>");

				//Make column and fill with correct attribute
				//auctionID
				out.print("<td>");
				%><form method = post action = "viewAuction.jsp"> <button type = "submit" name = "auctionID" value = <%out.print(result.getString("auctionID"));%> ><% out.print(result.getString("auctionID")); %></button></form> <%
				out.print("</td>");
				
				//auctionItemID
				out.print("<td>");
				out.print(result.getInt("auctionItemID"));
				out.print("</td>");
				
				//Item Details
				out.print("<td>");
				out.print(result.getString("details"));
				out.print("</td>");
				
				//TimeLeft
				out.print("<td>");
				out.print(result.getInt("timeLeft"));
				out.print("</td>");
				
				//Auctioneer
				out.print("<td>");
				out.print(result.getInt("auctioneerUsername"));
				out.print("</td>");
				
				out.print("</tr>");
				out.print("<br>");
				
			}
			
			out.print("</table>");
					
			con.close();
			
		}catch(Exception e){
			out.print(e);	
		}
	%>
</div>