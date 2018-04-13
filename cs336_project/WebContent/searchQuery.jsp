<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
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

<div align = center>

<!-- Search Engine Query Code -->
	<%
	
		try{
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get commands from searchBrowse.jsp search bar
			String entity = request.getParameter("searchBar");
			
			//Parsing commands into an array list
			String[] searchTerms = entity.split(" ");
			
			//Execute SQL query for search commands, Identifying 
			//Creating a sql statement for each desired filter
			for (int x = 0; x<searchTerms.length; x++){
				
			}
			
			
			//Creating a table for search results with some default values and their desired attributes.
			
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
			
			
		}catch(Exception e){
			out.print("e");
		}
	
	
	%>

</div>


</body>
