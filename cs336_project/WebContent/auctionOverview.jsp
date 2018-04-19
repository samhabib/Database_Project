<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css" media="screen" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Overview</title>

</head>
<body>
<!-- Welcome Banner code -->
<div align = center class = "banner">
<h1>Candle Feet - Shoe Auction House</h1>
</div>
<!-- Navigation Bar code -->
<div align= center class = "navigation">
<a href = "logOut.jsp">Log Out</a>
<a href = "repPage.jsp">Customer Representative Page</a>
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

<!-- Auction browser -->
<div align=left>
	<h3>Filter Auctions</h3>
		<!-- Re-instantiate the table with the filters selected in new page -->
		<form method = post action = "filterQuery.jsp">
			<h5>Filter method</h5>
			<input type = "radio" name="method" value = "AND" checked>Combine choices (AND)
			<input type = "radio" name="method" value = "OR">Group choices (OR)
		
			<input type = "submit" name="filter" value="Begin Filter">
		</form>

</div>

	
<div align = left>
	<!-- Insert a table of all auctions currently in the auctions table -->
	<h2>Ongoing Auctions</h2>
	<%
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT SQL statement
			String str = "SELECT DISTINCT * FROM Auctions a, Item i, Bid b WHERE a.auctionItemID = i.itemID AND (a.winningBidID = b.bidID OR a.winningBidID IS NULL) GROUP BY a.auctionID HAVING max(b.bidAmount)";
			
			//Executing SQL query
			ResultSet result = stmt.executeQuery(str);
			
			//Print out result table.
			//Create table headers
			out.print("<table>");
			
			out.print("<tr>");
			//auctionID
			out.print("<th>");
			out.print("Auction ID");
			out.print("</th>");
			
			//winning Bid Value
			out.print("<th>");
			out.print("Winning Bid");
			out.print("</th>");
			
			//TimeLeft
			out.print("<th>");
			out.print("Finish Time");
			out.print("</th>");
			
			//itemID
			out.print("<th>");
			out.print("Shoe #");
			out.print("</th>");
			
			//itemDescription
			out.print("<th>");
			out.print("Description");
			out.print("</th>");
			
			//Color
			out.print("<th>");
			out.print("Color");
			out.print("</th>");
			
			//size
			out.print("<th>");
			out.print("Size");
			out.print("</th>");
			
			//style
			out.print("<th>");
			out.print("Style");
			out.print("</th>");
			
			out.print("</tr>");
			
			//Fill Table with the above attributes
			
			while(result.next()){
				
				//Make row
				out.print("<tr>");

				//Make column and fill with correct attribute
				//auctionID
				out.print("<td>");
				%><form method = post action = "viewAuctionRep.jsp"> <button type = "submit" name = "auctionID" value = <%out.print(result.getString("auctionID"));%> ><% out.print(result.getString("auctionID")); %> </button></form> <%
				
				out.print("</td>");
				
				//Winning Bid
				out.print("<td>");
				if(result.getString("winningBidID")!=null){
					out.print("$" + result.getInt("bidAmount"));	
				}
				else{
					out.print("No bids");
				}
				out.print("</td>");
				
				//TimeLeft
				out.print("<td>");
				out.print(result.getString("finishDateTime"));
				out.print("</td>");
				
				//itemID
				out.print("<td>");
				out.print(result.getInt("itemID"));
				out.print("</td>");
				
				//Item Details
				out.print("<td>");
				if(result.getString("details")!=null){
					out.print(result.getString("details"));
				}
				else{
					out.print("User has not provided description");
				}
				out.print("</td>");
				
				//Color
				out.print("<td>");
				if(result.getString("color")!=null){
					out.print(result.getString("color"));
				}
				else{
					out.print("-");
				}
				out.print("</td>");

				//size
				out.print("<td>");
				if(result.getString("size")!=null){
					out.print(result.getString("size"));
				}
				else{
					out.print("-");
				}
				out.print("</td>");
				
				//Style
				out.print("<td>");
				if(result.getString("style")!=null){
					out.print(result.getString("style"));
				}
				else{
					out.print("-");
				}
				out.print("</td>");
				
				out.print("</tr>");
				
			}
			
			out.print("</table>");
					
			con.close();
			
		}catch(Exception e){
			out.print(e);	
		}
	%>
</div>
</body>
</html>