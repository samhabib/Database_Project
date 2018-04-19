<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create An Auction</title>
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
<% 
	if (session.getAttribute("user") == null) {
		response.sendRedirect("loginPage.jsp");
	} else {
		out.println("Please create your auction, <b>" + session.getAttribute("user") + "</b><br>");
	}
%>
<form method="post" action="submitAuction.jsp">
<table>
	<tbody>
		<tr>
			<td>Auction Title</td>
			<td><input type="text" name="title"></td>
		<tr>
			<td>Reserve Amount (in Dollars)</td>
			<td>$<input type="text" name="reserve"></td>
		</tr>
		<tr>
			<td>Auction End Date and Time</td>
			<td>
				<select name = "month">
					<option value = "01">January</option>
					<option value = "02">February</option>
					<option value = "03">March</option>
					<option value = "04">April</option>
					<option value = "05">May</option>
					<option value = "06">June</option>
					<option value = "07">July</option>
					<option value = "08">August</option>
					<option value = "09">September</option>
					<option value = "10">October</option>
					<option value = "11">November</option>
					<option value = "12">December</option>
				</select>
				<select name = "day">
					<option value = "01">1</option>
					<option value = "02">2</option>
					<option value = "03">3</option>
					<option value = "04">4</option>
					<option value = "05">5</option>
					<option value = "06">6</option>
					<option value = "07">7</option>
					<option value = "08">8</option>
					<option value = "09">9</option>
					<option value = "10">10</option>
					<option value = "11">11</option>
					<option value = "12">12</option>
					<option value = "13">13</option>
					<option value = "14">14</option>
					<option value = "15">15</option>
					<option value = "16">16</option>
					<option value = "17">17</option>
					<option value = "18">18</option>
					<option value = "19">19</option>
					<option value = "20">20</option>
					<option value = "21">21</option>
					<option value = "22">22</option>
					<option value = "23">23</option>
					<option value = "24">24</option>
					<option value = "25">25</option>
					<option value = "26">26</option>
					<option value = "27">27</option>
					<option value = "28">28</option>
					<option value = "29">29</option>
					<option value = "30">30</option>
					<option value = "31">31</option>
				</select>
				<select name = "year">
					<option value = "2018">2018</option>
					<option value = "2019">2019</option>
					<option value = "2020">2020</option>
					<option value = "2021">2021</option>
					<option value = "2022">2022</option>
					<option value = "2023">2023</option>
				</select>
				<select name = "hour">
					<option value = "01">01</option>
					<option value = "02">02</option>
					<option value = "03">03</option>
					<option value = "04">04</option>
					<option value = "05">05</option>
					<option value = "06">06</option>
					<option value = "07">07</option>
					<option value = "08">08</option>
					<option value = "09">09</option>
					<option value = "10">10</option>
					<option value = "11">11</option>
					<option value = "12">12</option>
				</select>
				<select name = "minute">
					<option value = "00">00</option>
					<option value = "10">10</option>
					<option value = "20">20</option>
					<option value = "30">30</option>
					<option value = "40">40</option>
					<option value = "50">50</option>
				</select>
				<input type = "hidden" name = "second" value = "00">
				<select name = "half">
					<option value = "AM">AM</option>
					<option value = "PM">PM</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Item Details</td>
			<td><input type="text" name="itemDetails"></td>
		</tr>
		<tr>
			<td>Item Color</td>
			<td>
				<select name = "color">
					<option value = "Red">Red</option>
					<option value = "Orange">Orange</option>
					<option value = "Yellow">Yellow</option>
					<option value = "Green">Green</option>
					<option value = "Blue">Blue</option>
					<option value = "Indigo">Indigo</option>
					<option value = "Violet">Violet</option>
					<option value = "Black">Black</option>
					<option value = "White">White</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Item Size</td>
			<td>
				<select name = "size">
					<option value = "5">5</option>
					<option value = "5.5">5.5</option>
					<option value = "6">6</option>
					<option value = "6.5">6.5</option>
					<option value = "7">7</option>
					<option value = "7.5">7.5</option>
					<option value = "8">8</option>
					<option value = "8.5">8.5</option>
					<option value = "9">9</option>
					<option value = "9.5">9.5</option>
					<option value = "10">10</option>
					<option value = "10.5">10.5</option>
					<option value = "11">11</option>
					<option value = "11.5">11.5</option>
					<option value = "12">12</option>
					<option value = "12.5">12.5</option>
					<option value = "13">13</option>
					<option value = "13.5">13.5</option>
					<option value = "14">14</option>
					<option value = "14.5">14.5</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Item Style</td>
			<td>
				<select name = "style">
					<option value = "Sneaker">Sneaker</option>
					<option value = "Boot">Boot</option>
					<option value = "Dress Shoe">Dress Shoe</option>
					<option value = "Loafer">Loafer</option>
					<option value = "Sandals">Sandals</option>
					<option value = "Flats">Flats</option>
					<option value = "High Heels">High Heels</option>
					<option value = "Casual Shoe">Casual Shoe</option>
				</select>
			</td>
		</tr>
	</tbody>
</table>
	<br>
	<input type="submit" value="Create">
</form>
</body>
</html>