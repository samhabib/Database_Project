<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Insert title here</title>
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
	String insertedAuction = null;
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
		
		String auctioneerUsername = (String)session.getAttribute("user");
		String title  = request.getParameter("title");
		String reserve = request.getParameter("reserve");
		if (reserve.isEmpty()) {
			reserve = "0.00";
		}
		
		//date setup
		String mm = request.getParameter("month");
		String dd = request.getParameter("day");
		String yyyy = request.getParameter("year");
		String hh = request.getParameter("hour");
		String min = request.getParameter("minute");
		String ss = request.getParameter("second");
		String AMPM = request.getParameter("half");
		String dateandtime = String.format("%s%s%s %s:%s:%s %s", mm, dd, yyyy, hh, min, ss, AMPM);
		
		
		String details = request.getParameter("itemDetails");
		String color = request.getParameter("color");
		String size = request.getParameter("size");
		String style = request.getParameter("style");
		
		stmt.executeUpdate("INSERT INTO Item(color, size, style, details) VALUES ('" + color + "', '" + size + "', '" + style + "', '" + details +  "');");
		ResultSet rs = stmt.executeQuery("SELECT last_insert_id() as itemID;");
		rs.next();
		String itemID = rs.getString(1);
		stmt.executeUpdate("INSERT INTO Auctions(title, auctionItemID, auctioneerUsername, reserve, finishDateTime) VALUES ('" + title + "', '" + itemID + "', '" + auctioneerUsername + "', " + reserve + ", (STR_TO_DATE('" + dateandtime + "', '%c%e%Y %r')));");
		
		ResultSet sess = stmt.executeQuery("SELECT last_insert_id() as last_id;");
		sess.next();
		String thisAuctionID = sess.getString(1);
		
		session.setAttribute("auctionID", thisAuctionID);
		
		response.sendRedirect("viewAuction.jsp");
	} catch (Exception ex) {
		out.print(ex);
	} finally {
		con.close();
	}
%>
</body>
</html>