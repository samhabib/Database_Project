<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Create Autobidder</title>
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
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		float currentHighest = 0;
		float bidAmount = 0;
		String bidAmountString = request.getParameter("bidAmount");
		if (bidAmountString.equals("")) {
			bidAmount = 0;
		} else {
			bidAmount = Float.parseFloat(bidAmountString);
		}
		String auctionID = request.getParameter("auctionID");
		String userID = (String)session.getAttribute("user");		
		String passedUser = request.getParameter("userID");
		String upperCapString = request.getParameter("upperCap");
		float upperCap = Float.parseFloat(upperCapString);
		
		ResultSet rs1 = stmt.executeQuery("SELECT winningBidID FROM Auctions WHERE (auctionID = '" + auctionID + "');");
		rs1.next();
		String currentWinner = rs1.getString("winningBidID");
		
		if (currentWinner != null) {
			ResultSet rt1 = stmt.executeQuery(String.format("SELECT bidAmount FROM Bid WHERE bidID = '%s'", currentWinner));
			rt1.next();
			currentHighest = rt1.getFloat("bidAmount");
		}
		if (bidAmount == 0) {
			stmt.executeUpdate(String.format("INSERT INTO Autobidder(abAuctionID, abUserID, upperCap) VALUES ('%s', '%s', %.2f)", auctionID, userID, upperCap));
		} else if (currentWinner == null || bidAmount > currentHighest) {
			stmt.executeUpdate(String.format("INSERT INTO Bid(bidAmount, bidderName, bidAuction) VALUES (%.2f, '%s', '%s')", bidAmount, (String)session.getAttribute("user"), auctionID));
			ResultSet rs2 = stmt.executeQuery(String.format("SELECT bidID FROM Bid WHERE (bidAmount = %.2f) AND (bidderName = '%s') AND (bidAuction = '%s')", bidAmount, (String)session.getAttribute("user"), auctionID));
			rs2.next();
			currentWinner = rs2.getString("bidID");
			stmt.executeUpdate(String.format("UPDATE Auctions SET winningBidID = '%s' WHERE auctionID = '%s'", currentWinner, auctionID));
			stmt.executeUpdate(String.format("INSERT INTO Autobidder(abAuctionID, abUserID, upperCap) VALUES ('%s', '%s', %.2f)", auctionID, userID, upperCap));
		} else if (bidAmount <= currentHighest) {
			out.println("The amount you entered is lower than or equal to the highest bid. <br>");
			out.println("<a href=\"viewAuction.jsp\">Back</a>");
		}
	} catch (Exception ex) {
		out.print(ex);
	} finally {
		con.close();
		session.setAttribute("auctionID", request.getParameter("auctionID"));
		response.sendRedirect("viewAuction.jsp");
	}
%>
</body>
</html>