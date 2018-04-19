<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question search results</title>
<link rel="stylesheet" type="text/css" href="style.css" />
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

<br>

<div>

<!-- Search Engine Query Code -->
	<%
	
		try{
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get commands from searchBrowse.jsp search bar
			String searchType = request.getParameter("questionType");
			String searchInput = request.getParameter("questionBar");
			
			
			String query = "SELECT Question_Board.QuestionID, Question_Board.QuestionTitle, Question_Board.Question, Question_Board.Answer FROM Question_Board WHERE ";
			
			//Switch statement to query properly
			if (searchType.equals("questionTitle")){
				query+= "Question_Board.QuestionTitle LIKE" + "\"" + "%" + searchInput + "%" + "\"";
			}
			else if (searchType.equals("questionDetail")){
				query+= "Question_Board.Question LIKE" + "\"" + "%" + searchInput + "%" + "\"";
			}
			else{
				response.sendRedirect("main_index.jsp");
			}
			
			ResultSet result = stmt.executeQuery(query);
			
			out.print("<h3>Search Results</h3>");
			
			while(result.next()!=false){
				String id = result.getString(1);
				String title = result.getString(2);
				String question = result.getString(3);
				String answer = result.getString(4);
				
				out.println("QuestionID: " + id + "<br />" + "Question Title: " + title + "<br />"+ "Question Details: "+ question + "<br />" + "Answer: " + answer + "<br />" + "<br />" + "<br />");
			}
			
		}catch(Exception e){
			out.print("e");
		}
	
	
	%>

</div>


</body>

</html>