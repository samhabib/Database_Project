<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import= "java.util.Date"%>
<%@ page import= "java.text.SimpleDateFormat"%>
<%@ page import= "java.util.Calendar"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
		Statement stmt2 = con.createStatement();
		Statement stmt3 = con.createStatement();
		String report_style = request.getParameter("report_style");
		//TO IMPLEMENT - SALES REPORT GENERATION
		
		//TOTAL EARNINGS
		if(report_style.equals("earnings_total")){
			ResultSet rs = stmt.executeQuery("SELECT Bid.bidAmount FROM Bid, Auctions WHERE Bid.BidID=Auctions.winningBidID;");
			float totalEarnings=0;
			while(rs.next()!=false){
				String numberAsString = rs.getString(1);
				float winBid = Float.parseFloat(numberAsString);
				totalEarnings=totalEarnings+winBid;
			}
			out.println("The Total Earnings of all the auctions is $ " + totalEarnings + "<br />" + "<br />");
			
			
			out.println("<a href = 'adminPage.jsp'>Back To Admin Page</a>");
			
			//EARNINGS PER ITEM
		} else if(report_style.equals("earnings_per_item")){
			ResultSet rsItems = stmt.executeQuery("SELECT Item.itemID FROM Item;");
			
			while(rsItems.next()!=false){
				
				String rsItemsID = rsItems.getString(1);
				ResultSet rs = stmt2.executeQuery("SELECT Bid.bidAmount FROM Bid, Auctions WHERE Bid.BidID=Auctions.winningBidID AND Auctions.auctionItemID="+rsItemsID + ";");
				float itemEarnings=0;
				
				while(rs.next()!=false){
					String numberAsString = rs.getString(1);
					float winBid = Float.parseFloat(numberAsString);
					itemEarnings=itemEarnings+winBid;
				}
				out.println("The Earnings of all the auctions for Item with ItemID [" + rsItemsID+"] is $ " + itemEarnings + "<br />" + "<br />");
				
			}		

			out.println("<a href = 'adminPage.jsp'>Back To Admin Page</a>");
			
			//EARNINGS PER TYPE
		} else if(report_style.equals("earnings_per_type")){
			ResultSet rsStyle = stmt.executeQuery("SELECT DISTINCT Item.style FROM Item;");
			
			while(rsStyle.next()!=false){
				float itemEarnings=0;
				
				String style = rsStyle.getString(1);
				ResultSet rsItems = null;
				if(style==null){
					rsItems = stmt2.executeQuery("SELECT Item.itemID FROM Item WHERE Item.style is null;");

				}else{
					rsItems = stmt2.executeQuery("SELECT Item.itemID FROM Item WHERE Item.style='" + style + "';");
				}
				while(rsItems.next()!=false){
					String rsItemsID = rsItems.getString(1);
					ResultSet rs =stmt3.executeQuery("SELECT Bid.bidAmount FROM Bid, Auctions WHERE Bid.BidID=Auctions.winningBidID AND Auctions.auctionItemID="+rsItemsID +";");
					
					while(rs.next()!=false){
						String numberAsString = rs.getString(1);
						float winBid = Float.parseFloat(numberAsString);
						itemEarnings=itemEarnings+winBid;
					}
				}

				out.println("The Earnings of all the auctions for Item with Style [" + style + "] is $ " + itemEarnings + "<br />" + "<br />");
				
			}			
			
			out.println("<a href = 'adminPage.jsp'>Back To Admin Page</a>");
						
			//EARNINGS PER USER
		} else if(report_style.equals("earnings_per_user")){
			ResultSet rsUser = stmt.executeQuery("SELECT User.username FROM User WHERE User.account_type='buyer';");
			
			while(rsUser.next()!=false){
				float userEarnings = 0;
				String rsUsername = rsUser.getString(1);
				ResultSet rs =stmt2.executeQuery("SELECT Bid.bidAmount FROM Bid, Auctions WHERE Bid.BidID=Auctions.winningBidID AND Bid.bidderName='"+rsUsername +"';");
				
				while(rs.next()!=false){
					String numberAsString = rs.getString(1);
					float winBid = Float.parseFloat(numberAsString);
					userEarnings=userEarnings+winBid;
				}
				out.println("The Earnings of all the auctions from [" + rsUsername + "] is $ " + userEarnings + "<br />" + "<br />");
			}
			
			out.println("<a href = 'adminPage.jsp'>Back To Admin Page</a>");

			//BEST SELLING ITEMS
		} else if(report_style.equals("best_selling_items")){
			ResultSet rs = stmt.executeQuery("SELECT Item.unitsSold, Item.itemID FROM Item;");
			while(rs.next()!=false){
				String unitsSold = rs.getString(1);
				String itemID = rs.getString(2);
				out.println("Item ["+ itemID +"] sold a total of " + unitsSold + " units"+ "<br />" + "<br />");

			}
			
			out.println("<a href = 'adminPage.jsp'>Back To Admin Page</a>");
			
			//BEST BUYERS
		} else{
			ResultSet rsUser = stmt.executeQuery("SELECT User.username FROM User WHERE User.account_type='buyer';");
			
			while(rsUser.next()!=false){
				int userPurchases = 0;
				String rsUsername = rsUser.getString(1);
				ResultSet rs =stmt2.executeQuery("SELECT Bid.bidAmount FROM Bid, Auctions WHERE Bid.BidID=Auctions.winningBidID AND Bid.bidderName='"+rsUsername +"';");
				
				while(rs.next()!=false){
					userPurchases++;
				}
				out.println("User ["+ rsUsername +"] has won " + userPurchases + " auctions"+ "<br />" + "<br />");
			}
			
			out.println("<a href = 'adminPage.jsp'>Back To Admin Page</a>");

		}
	} catch (Exception ex) {
		out.print(ex);
	}finally {
        con.close();
    }
%>
</body>
</html>