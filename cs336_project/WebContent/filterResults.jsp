<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Filtering Results</title>
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

<br>

<div>
<%

		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Check filtering
			String filterType = request.getParameter("method");
			
			//Parse the start of a SQL Query
			String query = "SELECT DISTINCT * FROM Auctions a, Item i, Bid b WHERE a.auctionItemID = i.itemID AND (a.winningBidID = b.bidID OR a.winningBidID IS NULL) AND ";
			
			if(filterType.equals("AND")){
				
				//Parsing table display based on selected options. Full auction query if nothing selected.
				String shoeColor = request.getParameter("color");
				String shoeSize = request.getParameter("shoesize");
				String shoeStyle = request.getParameter("style");
				
				String tempPrice = request.getParameter("bidprice");
				String[] bidPrice = tempPrice.split(" ");
				
				//Checking shoeColor
				if(shoeColor!=null){
					query+= "i.color =\"" + shoeColor + "\" AND "; 
				}
				//Checking shoeSize
				if(shoeSize!=null && shoeSize!=""){
					query+= "i.size =" + shoeSize + " AND ";
				}
				//checking shoeStyle
				if(shoeStyle!=null){
					query+= "i.style =\"" + shoeStyle + "\" AND ";
				}
				//checking bidPrice
				if(bidPrice != null && !bidPrice[0].equals("")){
					query+="(";
					for (int x = 0; x < bidPrice.length; x++){
						query+= "b.bidAmount" + bidPrice[x] + " AND ";
					}
					if (query.substring(query.length() - 5).equals(" AND "))
						query = query.substring(0, query.length() - 5);
					query+=")";
				}
				
				//Query Cleanup
				if (query.substring(query.length() - 5).equals(" AND "))
					query = query.substring(0, query.length() - 5);
				if (query.substring(query.length() - 7).equals(" WHERE "))
					query = query.substring(0, query.length() - 7);
				
				query+=" GROUP BY a.auctionID HAVING max(b.bidAmount)";
			}
			//OR QUERY
			else if (filterType.equals("OR")){
				
				//Parsing table display based on selected options. Full auction query if nothing selected.
				String[] shoeColor = request.getParameterValues("color");
				String temp = request.getParameter("shoesize");
				String[] shoeSize = temp.split(" ");
				String[] shoeStyle = request.getParameterValues("style");
				
				String tempPrice = request.getParameter("bidprice");
				String[] bidPrice = tempPrice.split(" ");
				
				//Checking shoeColor
				if(shoeColor!=null){
					query+="(";
					for(int x = 0; x<shoeColor.length; x++){
						query+= "i.color =\"" + shoeColor[x] + "\" OR ";	
					}
					if (query.substring(query.length() - 4).equals(" OR "))
						query = query.substring(0, query.length() - 4);
					query+=")";
					query+=" AND ";
				}
				//Checking shoeSize
				if(shoeSize!=null && !shoeSize[0].equals("")){
					query+="(";
					for(int x = 0; x<shoeSize.length; x++){
						query+= "i.size =" + shoeSize[x] + " OR ";	
					}
					if (query.substring(query.length() - 4).equals(" OR "))
						query = query.substring(0, query.length() - 4);
					query+=")";
					query+=" AND ";
				}
				//checking shoeStyle
				if(shoeStyle!=null){
					query+="(";
					for(int x = 0; x<shoeStyle.length; x++){
						query+= "i.style =\"" + shoeStyle[x] + "\" OR ";	
					}
					if (query.substring(query.length() - 4).equals(" OR "))
						query = query.substring(0, query.length() - 4);
					query+=")";
				}
				
				//checking bidPrice
				if(bidPrice != null && !bidPrice[0].equals("")){
					query+="(";
					for (int x = 0; x < bidPrice.length; x++){
						query+= "b.bidAmount" + bidPrice[x] + " AND ";
					}
					if (query.substring(query.length() - 5).equals(" AND "))
						query = query.substring(0, query.length() - 5);
					query+=")";
				}
				
				//Query Cleanup
				if (query.substring(query.length() - 5).equals(" AND "))
					query = query.substring(0, query.length() - 5);
				if (query.substring(query.length() - 7).equals(" WHERE "))
					query = query.substring(0, query.length() - 7);
				if (query.substring(query.length() - 4).equals(" OR "))
					query = query.substring(0, query.length() - 4);
				
				query+=" GROUP BY a.auctionID HAVING max(b.bidAmount)";
				
			}
			//Executing query
			ResultSet result = stmt.executeQuery(query);
			
			out.print("<h3>Filter Results</h3>");
			
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
				//If price constraint has been applied - Ignore nulls.
				String foo = request.getParameter("bidprice");
				if ((foo !=null && !foo.equals("")) && result.getString("winningBidID")==null){
					continue;
				}
				else{
					//Make row
					out.print("<tr>");

					//Make column and fill with correct attribute
					//auctionID
					out.print("<td>");
					%><form method = post action = "viewAuction.jsp"> <button type = "submit" name = "auctionID" value = <%out.print(result.getString("auctionID"));%> ><% out.print(result.getString("auctionID")); %> </button></form> <%
					
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
				
			}
			
			out.print("</table>");
			
			//Close connection
			con.close();
			
		
		}catch(Exception e){
			out.print("e");
		
		}




%>
</div>

</body>
</html>


