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
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<title>Reserve Camera</title>
<script>
  $(function() {
    $( "#datepicker" ).datepicker({
    	beforeShowDay: function(date) {
            return [date.getDay() == 5];
        },
        dateFormat:"yy-mm-dd"
    });
  });
  function reservercamera()
  {
	  var reserveServletUrl = "/Library/ReserveCamera?reserveDate="+document.getElementById("datepicker").value;
  	  window.location.href = reserveServletUrl;
  }
</script>
</head>
<body>
<%HttpSession sess = request.getSession(false); %>
<ol class="breadcrumb">
  <li><%if(sess.getAttribute("patrontype").equals("faculty")){%> <a href="Faculty.jsp">Home</a><%}else if(sess.getAttribute("patrontype").equals("student")){%><a href="Student.jsp">Home</a><%} %></li>
  <li><a href="Camera.jsp">Camera</a></li>
  <li class="active"><%=(String)request.getAttribute("camera")%></li>
</ol>
<%
String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";
String lens_conf,memory,make,model;
int resource_id;
String USER = "root";
String PASS = "";

String patronId=(String)sess.getAttribute("patronid");
Connection conn = null;
Class.forName(JDBC_DRIVER);
conn = DriverManager.getConnection(DB_URL, USER,null);
PreparedStatement pstmt = conn.prepareStatement("{call getCameraById(?)}");
pstmt.setString(1, (String)request.getAttribute("camera"));
ResultSet rs = pstmt.executeQuery();                
rs.next();
lens_conf=rs.getString(2);
memory=rs.getString(3);
make=rs.getString(4);
model=rs.getString(5);
resource_id=rs.getInt(6);
sess.setAttribute("resourceId", resource_id);
sess.setAttribute("camera", (String)request.getAttribute("camera"));

%>
<% if(request.getAttribute("rettype")!=null){
if(request.getAttribute("rettype").equals("end time")){
	%>
	<div class="alert alert-success fade in">
    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    <strong>Success!</strong> You have successfully reserved the Camera. Due on <%=(String)request.getAttribute("reservationstatus") %>
  </div>
	<% 
}else if(request.getAttribute("rettype").equals("position")){
	%>
	<div class="alert alert-danger fade in">
    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    <strong>Camera Already Booked. You are in queue.</strong> Queue position <%=(String)request.getAttribute("reservationstatus") %>
  	</div>
	<%
	
}
}
%> 
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">Camera Details</h3>
  </div>
  <div class="panel-body">
    <p>Lens Configuration : <%=lens_conf %></p>
    <p>Memory : <%=memory %></p>
    <p>Make : <%=make %></p>
    <p>Model : <%=model %></p>
    
    <p>Date: <input type="text" id="datepicker" name="camreservedate"></p> 
    <button type="button" class="btn btn-default" onclick="reservercamera()">Reserve</button>
   
  </div>
</div>
</body>
</html>