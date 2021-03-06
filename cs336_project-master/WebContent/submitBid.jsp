<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<% 
	if (session.getAttribute("user") == null) {
		response.sendRedirect("loginPage.jsp");
	}
%>
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
		Statement stmt = con.createStatement();
		
		float currentHighest = 0;
		String bidAmountString = request.getParameter("bidAmount");
		float bidAmount = Float.parseFloat(bidAmountString);
		String auctionID = request.getParameter("auctionID");
		
		ResultSet rs1 = stmt.executeQuery("SELECT winningBidID FROM Auctions WHERE (auctionID = '" + auctionID + "');");
		rs1.next();
		String currentWinner = rs1.getString("winningBidID");
		
		if (currentWinner != null) {
			ResultSet rt1 = stmt.executeQuery(String.format("SELECT bidAmount FROM Bid WHERE bidID = '%s'", currentWinner));
			rt1.next();
			currentHighest = rt1.getFloat("bidAmount");
		} 
		if (currentWinner == null || bidAmount > currentHighest) {
			stmt.executeUpdate(String.format("INSERT INTO Bid(bidAmount, bidderName, bidAuction) VALUES (%.2f, '%s', '%s')", bidAmount, (String)session.getAttribute("user"), auctionID));
			ResultSet rs2 = stmt.executeQuery(String.format("SELECT bidID FROM Bid WHERE (bidAmount = %.2f) AND (bidderName = '%s') AND (bidAuction = '%s')", bidAmount, (String)session.getAttribute("user"), auctionID));
			rs2.next();
			currentWinner = rs2.getString("bidID");
		} else if (bidAmount <= currentHighest) {
			out.println("The amount you entered is lower than or equal to the highest bid. <br>");
			out.println("<a href=\"viewAuction.jsp\">Back</a>");
		}
		
		//Check for autobidders
		ResultSet ab = stmt.executeQuery(String.format("SELECT COUNT(autobidderID) FROM Autobidder WHERE abAuctionID = '%s'", auctionID));
		ab.next();
		int numOfAutobidders = ab.getInt("COUNT(autobidderID)");
		if (numOfAutobidders == 0) {
			;
		} else if (numOfAutobidders == 1) {
			ResultSet ab1 = stmt.executeQuery(String.format("SELECT abUserID, upperCap FROM Autobidder WHERE abAuctionID = '%s'", auctionID));
			ab1.next();
			String abUserID = ab1.getString("abUserID").trim();
			float upperCap = ab1.getFloat("upperCap");
			if (bidAmount < upperCap) {
				stmt.executeUpdate(String.format("INSERT INTO Bid(bidAmount, bidderName, bidAuction) VALUES (%.2f, '%s', '%s')", (bidAmount + .01), abUserID, auctionID));
			} else {
				stmt.executeUpdate(String.format("UPDATE Autobidder SET outbid = 1 WHERE abAuctionID = '%s'", auctionID));
			}
		} else if (numOfAutobidders > 1) {
			ResultSet ab2 = stmt.executeQuery(String.format("SELECT abUserID, MAX(upperCap) FROM Autobidder"));
			ab2.next();
			float maxUpperCap = ab2.getFloat("MAX(upperCap)");
			String abUser = ab2.getString("abUserID");
			
			ResultSet ab3 = stmt.executeQuery(String.format("SELECT abUserID, MAX(upperCap) FROM Autobidder WHERE upperCap != %.2f", maxUpperCap));
			ab3.next();
			float secondUpperCap = ab3.getFloat("MAX(upperCap)");
			if (bidAmount > maxUpperCap) {
				stmt.executeUpdate(String.format("UPDATE Autobidder SET outbid = 1"));
			} else if (bidAmount < maxUpperCap && bidAmount > secondUpperCap) {
				stmt.executeUpdate(String.format("INSERT INTO Bid(bidAmount, bidderName, bidAuction) VALUES (%.2f, '%s', '%s')", (bidAmount + .01), abUser, auctionID));
				stmt.executeUpdate(String.format("UPDATE Autobidder SET outbid = 1 WHERE upperCap < %.2f", maxUpperCap));
			} else {
				stmt.executeUpdate(String.format("INSERT INTO Bid(bidAmount, bidderName, bidAuction) VALUES (%.2f, '%s', '%s')", (secondUpperCap + .01), abUser, auctionID));
				stmt.executeUpdate(String.format("UPDATE Autobidder SET outbid = 1 WHERE upperCap < %.2f", maxUpperCap));
			}
		}
		
	} catch (Exception ex) {
		out.println("At submitBid.jsp<br>");
		out.print(ex);
	} finally {
		con.close();
	}
%>
</body>
</html>