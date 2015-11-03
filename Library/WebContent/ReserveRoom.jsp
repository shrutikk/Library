<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>Reserve room</title>
</head>
<body>
<%HttpSession sess = request.getSession(false); %>
<ol class="breadcrumb">
  <li><%if(sess.getAttribute("patrontype").equals("faculty")){%> <a href="Faculty.jsp"></a><%}else if(sess.getAttribute("patrontype").equals("student")){%><a href="Student.jsp">Home</a><%} %></li>
  <li class="active">Rooms</li>
</ol>
<h3>Reserve Room</h3>
<hr>

<%


String patronId = (String)sess.getAttribute("patronid");
String resourceId = (String)request.getParameter("resourceId");
System.out.println("Reserve room for PatronId:  " + patronId);
System.out.println("Reserve room for ResourceId: " + resourceId);
%>

<form action="RoomReserver" method="POST">
 <div class="form-group">
  <label for="patid">Patron Id</label>
  <input type="text" class="form-control" id="patid" name="patid" value="<%=patronId%>" readonly="true">
 </div>
 
 <div class="form-group">
  <label for="resid">Resource Id</label>
  <input type="text" class="form-control" id="resid" name="resid" value="<%=resourceId%>" readonly="true">
 </div>
 
 <div class="form-group">
  <label for="stime">Start Time</label>
  <input type="text" class="form-control" id="stime" name="stime">
  </div>
  
<div class="form-group">
  <label for="etime">End Time</label>
  <input type="text" class="form-control" id="etime" name="etime">
 </div>
 
 <div class="form-group">
  <button type="submit" class="btn btn-default">Reserve!</button>  
 </div>
</form>  

</body>
</html>