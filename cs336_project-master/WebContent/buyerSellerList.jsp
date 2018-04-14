<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Buyer And Seller List</title>
</head>

<div align= center class = "navigation">
<td>Welcome To Buyer/Seller Page</td><br />
<a href = "logOut.jsp">Log Out</a>
<a href = "mainIndex.jsp">Back to the Main Page</a>
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
		
				
		ResultSet rs = stmt.executeQuery("SELECT DISTINCT User.username FROM User WHERE (User.account_type = 'buyer');");
		while(rs.next()!=false){
			String username = rs.getString(1);
			out.println("Username: " + username + "<br />"+ "<br />");
		}
		
	} catch (Exception ex) {
		out.print(ex);
	} finally {
		con.close();
	}
%>


<div>
		  <form action="processActivity.jsp" method="POST">
		  		<input required="required" maxlength="20" type="text" size="60" placeholder = " Enter Username of the User you want to see History of" name="buyer_seller_name"/>
		  		<br>
		  		<br>
		  		<input type="submit" value="Post">
		  </form>
</div>


</body>
</html>