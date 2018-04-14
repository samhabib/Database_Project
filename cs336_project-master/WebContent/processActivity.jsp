<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction View</title>
</head>

<div align= center class = "navigation">
<td>Welcome To Buyer/Seller Page</td><br />
<a href = "logOut.jsp">Log Out</a>
<a href = "mainIndex.jsp">Back to the Main Page</a>
<a href = "buyerSellerList.jsp">Back to the Buyer Seller List</a>

<br>
<br>
</div>
<body>
<%
	Connection con = null;
	try {
		//Create a connection string
		String url = "jdbc:mysql://cs336.crihf3wk4z2b.us-east-2.rds.amazonaws.com/BuySellWebsite";
		//Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		con = DriverManager.getConnection(url, "daveyjones94", "doubleK1LL");
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String username = request.getParameter("buyer_seller_name");
		ResultSet rs = stmt.executeQuery("SELECT Bid.bidAmount, Bid.bidAuction FROM Bid WHERE (Bid.bidderName = '" + username + "');");

		out.println(String.format("<br>History of Buys and Sells for " + username + ":<br> "));
		out.println(String.format("----------------------------------- <br><br> Bids: <br><br>"));
		
		while(rs.next()!=false){
			String BidAmount = rs.getString(1);
			String BidAuction = rs.getString(2);
			out.println("Bid " + BidAmount +" $ on auction  " + BidAuction + "<br />"+ "<br />");
		}		
		
		out.println(String.format("<br><br>  <br><br> Auctions They are Hosting: <br><br>----------------------------------- <br><br>"));

		ResultSet rs2 = stmt.executeQuery("SELECT Auctions.auctionID, Auctions.auctionItemID, Auctions.finishDateTime FROM Auctions WHERE (Auctions.auctioneerUsername = '" + username + "');");
		while(rs2.next()!=false){
			String ID = rs2.getString(1);
			String itemID = rs2.getString(2);
			String time = rs2.getString(3);
			out.println("Hosts auction: " + ID +" which is putting item on sale:  " + itemID + " the auction finishes at: " + time + "<br />"+ "<br />");
		}		
		
	} catch (Exception ex) {
		out.print(ex);
	} finally {
		con.close();
	}
%>
</body>
</html>