<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Here</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>

<% 	if (session.getAttribute("user") == null) {
		response.sendRedirect("loginPage.jsp");
	}
%>

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

<h2>Question Board</h2>

<!-- Search Bar code -->
<div align = left>
	<h3>Search for Questions</h3>
	<form method = post action = "questionQuery.jsp">
		Search returns item auctions with greatest relevance to search terms.
		<br>
		Enter search terms
		<select name = "questionType">
			<option value = "questionTitle">Question Title</option>
			<option value = "questionDetail">Question Details</option>
		</select>
		<input type = "text" name = "questionBar">
		<br>
		<input type = "submit" value = Search>
	</form>
</div>


<div class="container">
		<div class="row">
		<div>
		  	<div >
				<div >
				  <h3>Add a Question</h3>
				</div>
				<div>
		  		<form action="processQuestion.jsp" method="POST">
		  			<input required="required" maxlength="100" type="text" size="100" placeholder = "Question Title" name="question_title"/>
		  			<br>
		  			<br>
		  			<textarea required="required" maxlength="255"rows="9" cols="80" placeholder = "Enter Question Details Here..." name="question_details"></textarea>
		  			<input type = "hidden" name ="post_type" value="question">
		  			<input type="submit" value="Post">
		  		</form>
		  		</div>
	  		</div>
	   </div>
	   </div>
</div>
<br>
<a href = "messageBoardUserAnswer.jsp">Show Only Answered Questions</a>
</br>
	
	
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
		
		ResultSet rs = stmt.executeQuery("SELECT Question_Board.QuestionID, Question_Board.QuestionTitle, Question_Board.Question, Question_Board.Answer FROM Question_Board;");
		
		out.println("<br />" + "<br />");
		
		while(rs.next()!=false){
			String id = rs.getString(1);
			String title = rs.getString(2);
			String question = rs.getString(3);
			String answer = rs.getString(4);

			
			out.println("QuestionID: " + id + "<br />" + "Question Title: " + title + "<br />"+ "Question Details: "+ question + "<br />" + "Answer: " + answer + "<br />" + "<br />" + "<br />");
		}
				
		
	} catch (Exception ex) {
		out.print(ex);
	}finally {
        con.close();
    }
%>
	

</body>
</html>