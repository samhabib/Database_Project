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
		ResultSet rs = stmt.executeQuery("SELECT DISTINCT Bid.bidAuction, Item.itemID, Item.details, Item.color, Item.size, Item.style FROM Bid, Item, Auctions WHERE (Auctions.auctionID = Bid.bidAuction) AND (Auctions.auctionItemID = Item.itemID) AND (Bid.bidderName = '" + username + "');");
		
		
		out.println(String.format("<br>" + username + "'s Bids:<br> "));
		out.println(String.format("----------------------------------- <br><br>"));
		
		while(rs.next()!=false){
			String BidAuction = rs.getString(1);
			String itemID = rs.getString(2);
			String itemDetails = rs.getString(3);
			String itemColor = rs.getString(4);
			String itemSize = rs.getString(5);
			String itemStyle = rs.getString(6);
			out.println("Has bidded on auction  " + BidAuction + " for Item "+itemID+" <br> Details: " + itemDetails +"<br>Color: " + itemColor +"<br>Size: " + itemSize + "<br>Style: " + itemStyle + "<br />"+ "<br />");
			
			
		}		
		
		out.println(String.format("<br><br> Auctions They are Hosting: <br><br>----------------------------------- <br><br>"));

		ResultSet rs2 = stmt.executeQuery("SELECT Auctions.auctionID, Auctions.auctionItemID, Auctions.finishDateTime FROM Auctions WHERE (Auctions.auctioneerUsername = '" + username + "');");
		while(rs2.next()!=false){
			String ID = rs2.getString(1);
			String itemID = rs2.getString(2);
			String time = rs2.getString(3);
			out.println("Hosts auction: " + ID +" which is putting item "+ itemID + " on sale,  the auction finishes at: " + time + "<br />"+ "<br />");
		}		
		
	} catch (Exception ex) {
		out.print(ex);
	} finally {
		con.close();
	}
%>
</body>
</html>