<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Filtering Results</title>
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
			String query = "SELECT DISTINCT * FROM Auctions a, Item i, Bid b WHERE a.auctionItemID = i.itemID AND a.winningBidID = b.bidID AND ";
			
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
				
				out.print(query);
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
				out.print(query);
			}
			//Executing query
			ResultSet result = stmt.executeQuery(query);
			
			//Print out result table.
			//Create table headers
			out.print("<table style='width:100%'>");
			
			out.print("<tr>");
			//auctionID
			out.print("<th>");
			out.print("auctionID");
			out.print("</th>");
			
			//TimeLeft
			out.print("<th>");
			out.print("timeLeft");
			out.print("</th>");
			
			//itemID
			out.print("<th>");
			out.print("Item#");
			out.print("</th>");
			
			//itemDescription
			out.print("<th>");
			out.print("details");
			out.print("</th>");
			
			//Color
			out.print("<th>");
			out.print("color");
			out.print("</th>");
			
			//size
			out.print("<th>");
			out.print("size");
			out.print("</th>");
			
			//style
			out.print("<th>");
			out.print("style");
			out.print("</th>");
			
			out.print("</tr>");
			out.print("<br>");
			
			//Fill Table with the above attributes
			//Order is : 
			// auctionID - timeleft - itemID - details - color - size - style
			
			while(result.next()){
				
				//Make row
				out.print("<tr>");

				//Make column and fill with correct attribute
				//auctionID
				out.print("<td>");
				%><form method = post action = "viewAuction.jsp"> <button type = "submit" name = "auctionID" value = <%out.print(result.getString("auctionID"));%> ><% out.print(result.getString("auctionID")); %></button></form> <%
				out.print("</td>");
				
				//TimeLeft
				out.print("<td>");
				out.print(result.getInt("timeLeft"));
				out.print("</td>");
				
				//itemID
				out.print("<td>");
				out.print(result.getInt("itemID"));
				out.print("</td>");
				
				//Item Details
				out.print("<td>");
				out.print(result.getString("details"));
				out.print("</td>");
				
				//Color
				out.print("<td>");
				out.print(result.getString("color"));
				out.print("</td>");

				//size
				out.print("<td>");
				out.print(result.getString("size"));
				out.print("</td>");
				
				//Style
				out.print("<td>");
				out.print(result.getString("style"));
				out.print("</td>");
				
				out.print("</tr>");
				out.print("<br>");
				
			}
			
			out.print("</table>");
			
			//Close connection
			con.close();
			
		
		}catch(Exception e){
			out.print("e");
		
		}




%>

