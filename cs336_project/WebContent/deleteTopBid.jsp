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
		String bidID = request.getParameter("bidID");
		ResultSet rs3 = stmt.executeQuery("SELECT * FROM Bid WHERE Bid.bidAuction = '"+ auctionID +"'");

		int count = 0;

		while (rs3.next()) {
		    ++count;
		    // Get data from the current row and use it
		}
		if(count == 1){
			stmt.executeUpdate("UPDATE `Auctions` SET `winningBidID`= NULL WHERE `winningBidID`='" + bidID + "'");			
			stmt.executeUpdate("DELETE FROM Bid WHERE Bid.bidID = '"+ bidID +"'");
			response.sendRedirect("auctionOverview.jsp");
			}
		
		ResultSet rs4 = stmt.executeQuery("SELECT MAX( Bid.bidID ) FROM Bid WHERE Bid.bidID = '"+ bidID +"'");
		rs4.next();
		String testBidID = rs4.getString(1);
		if(testBidID.equals(bidID)){
			ResultSet rs = stmt.executeQuery("SELECT MAX( Bid.bidID ) FROM Bid WHERE Bid.bidID < ( SELECT MAX( Bid.bidID ) FROM Bid WHERE Bid.bidID = '"+ bidID +"')");
			rs.next();
			String newBidID = rs.getString(1);
			stmt.executeUpdate("UPDATE `Auctions` SET `winningBidID`='" + newBidID + "' WHERE `winningBidID`='" + bidID + "'");			
			stmt.executeUpdate("DELETE FROM Bid WHERE Bid.bidID = '"+ bidID +"'");
			response.sendRedirect("viewAuctionRep.jsp");
						
		} else{
			stmt.executeUpdate("DELETE FROM Bid WHERE Bid.bidID = '"+ bidID +"'");
		}
		
		
		
		
		response.sendRedirect("viewAuctionRep.jsp");
		
	} catch (Exception ex) {
		out.print(ex);
	}finally {
        con.close();
    }
%>
	

</body>
</html>