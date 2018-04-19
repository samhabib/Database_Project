<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging in</title>

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
</div>
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
		
		String userID = request.getParameter("username");
		String userPass = request.getParameter("password");
		
		ResultSet rs = stmt.executeQuery("SELECT username, password, account_type FROM User WHERE ((username = '" + userID + "') AND (password = '" + userPass + "'));");
	
		
		if(rs.next()){
			String rsAccountType = rs.getString(3);	
						if(rsAccountType.equals("admin")){	
								
							response.sendRedirect("adminPage.jsp");	
						
						} else if(rsAccountType.equals("cus_rep")){	
								
							response.sendRedirect("repPage.jsp");	
				
						} else{	
							
			session.setAttribute("user", userID); //Username is stored in session	
			out.println("Login successful. Welcome " + userID);
			//Logout button	
			out.println("<a href = 'logOut.jsp'>Log Out</a>");
			//Redirect to homepage
			response.sendRedirect("main_index.jsp");
			}
			
		}
		else{
			//Invalid Login credentials
			out.println("Invalid username or password. <a href = loginPage.jsp>Try again.</a>");
		}
		
	} catch (Exception ex) {
		out.print(ex);
	} finally{
		con.close();
	}
%>
</body>
</html>