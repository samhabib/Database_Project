<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
	if (session.getAttribute("user") == null) {
		response.sendRedirect("loginPage.jsp");
	}
%>
<%
	try {
		//Create a connection string
		String url = "jdbc:mysql://cs336.crihf3wk4z2b.us-east-2.rds.amazonaws.com/BuySellWebsite";
		//Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = DriverManager.getConnection(url, "daveyjones94", "doubleK1LL");
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String auctioneerUsername = (String)session.getAttribute("user");
		String itemID = request.getParameter("itemID");
		String reserve = request.getParameter("reserve");
		String dateandtime = request.getParameter("dateandtime");
		String details = request.getParameter("itemDetails");
		String itemType = request.getParameter("itemType");
		
		stmt.executeUpdate("INSERT INTO Item(itemID, itemType, details) VALUES ('" + itemID + "', '" + itemType + "', '" + details +  "');");
		stmt.executeUpdate("INSERT INTO Auctions(auctionItemID, auctioneerUsername, reserve, finishDateTime) VALUES ('" + itemID + "', '" + auctioneerUsername + "', " + reserve + ", (STR_TO_DATE('" + dateandtime + "', '%c/%e/%Y %r')));");
	} catch (Exception ex) {
		out.print(ex);
	}
%>
</body>
</html>