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
		//TO IMPLEMENT - SALES REPORT GENERATION
		
		String auctionID = request.getParameter("auctionID");
		stmt.executeUpdate("DELETE FROM Bid WHERE Bid.bidAuction = '" + auctionID + "'");
		stmt.executeUpdate("DELETE FROM Auctions WHERE Auctions.auctionID= '" + auctionID + "'");
		response.sendRedirect("auctionOverview.jsp");
		
	} catch (Exception ex) {
		out.print(ex);
	}finally {
        con.close();
    }
%>
	

</body>
</html>