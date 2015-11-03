<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript">
function reserveRoomRedirect(rid){
	window.location="ReserveRoom.jsp?resourceId="+rid;
}
</script>

<title>Available rooms</title>
</head>
<body>
<%HttpSession sess = request.getSession(false); %>
<ol class="breadcrumb">
   <li><%if(sess.getAttribute("patrontype").equals("faculty")){%> <a href="Faculty.jsp">Home</a><%}else if(sess.getAttribute("patrontype").equals("student")){%><a href="Student.jsp">Home</a><%} %></li>
  	<li><a href="Rooms.jsp">All Rooms</a></li>
  <li class="active">Room Details</li>
</ol>
<%
String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";

String USER = "root";
String PASS = "";
Connection conn = null;
String FacultyId,facultyFisrtName,facultyLastName,category,nationality,dName;
float balance;
Date dob;
	Class.forName(JDBC_DRIVER);
	conn = DriverManager.getConnection(DB_URL, USER,null);
	ResultSet rooms = (ResultSet)request.getAttribute("roomInfo");
%>
<table class="table table-striped" id="roomsTable">
<tr>
<th>Resource ID</th>
<th>Room Number</th>
<th>Room Type</th>
<th>Floor Number</th>
<th>Capacity</th>
</tr>
<%	
	while(rooms.next())
	{
%>
<tr>
<td><%=rooms.getInt(1)%></td>
<td><%=rooms.getString(2)%></td>
<td><%=rooms.getString(3)%></td>
<td><%=rooms.getString(4)%></td>
<td><%=rooms.getInt(5)%></td>
<td><button type="submit" class="btn btn-default" value="<%=rooms.getInt(1)%>" onclick="reserveRoomRedirect(<%=rooms.getInt(1)%>)">Reserve</button></td>
</tr>
<%	   
	}	
%>
</table>
</body>
</html>