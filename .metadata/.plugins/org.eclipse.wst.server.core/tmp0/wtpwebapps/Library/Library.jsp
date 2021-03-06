<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>Library</title>
</head>
<body>
<%
String login_errormsg=(String)request.getAttribute("error");
%>
<div class="container">
  <h3>Library</h3>
  	<ul class="nav nav-tabs">
    	<li class="active"><a data-toggle="tab" href="#student-login-form">Student</a></li>
    	<li><a data-toggle="tab" href="#faculty-login-form">Faculty</a></li>
  	</ul>
  	<div class="tab-content">
	  <div id="student-login-form" class="tab-pane fade in active">
	    <form action="CheckStudentLogin" method="POST">
			  <div class="form-group">
			    <label for="unityid">Unity ID</label>
			    <input type="text" class="form-control" id="unityid_stud" name="unityid_stud">
			  </div>
			  <div class="form-group">
			    <label for="fprpasswd">Password</label>
			    <input type="password" class="form-control" id="passwd_stud" name="password_stud">
			  </div>
			  <%if(login_errormsg!=null){%>
			  <p><%= login_errormsg%></p>
			  <%} %>
			  <button type="submit" id="studentLogin" class="btn btn-default">Login</button>
		</form>
	  </div>
	  <div id="faculty-login-form" class="tab-pane fade">
	    <form action="CheckFacultyLogin" method="POST">
			  <div class="form-group">
			    <label for="unityid">Unity ID</label>
			    <input type="text" class="form-control" id="unityid_fac" name="unityid_fac">
			  </div>
			  <div class="form-group">
			    <label for="fprpasswd">Password</label>
			    <input type="password" class="form-control" id="passwd_fac" name="password_fac">
			  </div>
			  <button type="submit" id="facultyLogin" class="btn btn-default">Login</button>
		</form>
	  </div>
	</div>
</div>
</body>
</html>