<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>Camera</title>
</head>
<body>
<%HttpSession sess = request.getSession(false); %>
<ol class="breadcrumb">
   <li><%if(sess.getAttribute("patrontype").equals("faculty")){%> <a href="Faculty.jsp">Home</a><%}else if(sess.getAttribute("patrontype").equals("student")){%><a href="Student.jsp">Home</a><%} %></li>
  <li class="active">Camera</li>
</ol>
<%

String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";

String USER = "root";
String PASS = "";
Connection conn = null;
Class.forName(JDBC_DRIVER);
conn = DriverManager.getConnection(DB_URL, USER,null);
PreparedStatement pstmt = conn.prepareStatement("{call getAllCameras}");
ResultSet rs = pstmt.executeQuery();
%>
<div class="panel-heading">
    <h3 class="panel-title">Available Cameras</h3>
  </div>
  <div class="panel-body">
<div class="list-group">
<%
while(rs.next()){
	String camName = rs.getString(1);
	
%>
 <a href="<%=request.getContextPath()%>/GetCameraDetails?camName=<%=camName %>" class="list-group-item"><%=camName %></a>
 
  <%
  }
  %>
</div>
</div>
</body>
</html>