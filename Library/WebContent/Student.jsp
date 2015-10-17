<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>Student</title>
</head>
<body>
<%

String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
String DB_URL = "jdbc:mysql://192.168.0.24:3306/db_project";

String USER = "root";
String PASS = "";
Connection conn = null;
String studentId,studentfName,studentlname,nationality,department,sex,address,category,degree,phno,alt_phno,street,city,pin;
float balance;
Date dob;


	Class.forName(JDBC_DRIVER);
	conn = DriverManager.getConnection(DB_URL, USER,null);
	System.out.println((String)request.getAttribute("studentid"));
	PreparedStatement pstmt = conn.prepareStatement("{call getStudentProfile(?)}");
    pstmt.setString(1, (String)request.getAttribute("studentid"));
    ResultSet rs = pstmt.executeQuery();                
    rs.next();
   	studentId = rs.getString(1);
   	studentfName = rs.getString(2);
   	studentlname=rs.getString(3);
   	nationality = rs.getString(4);
   	department = rs.getString(5);
   	sex=rs.getString(6);
   	phno=rs.getString(7);
   	alt_phno=rs.getString(8);
   	dob=rs.getDate(9);
   	street=rs.getString(10);
   	city=rs.getString(11);
   	pin=rs.getString(12);
   	category=rs.getString(15);
   	degree=rs.getString(16);
    rs.close();
    pstmt.close();
     
    DateFormat df = new SimpleDateFormat("MM/dd/yyyy");        
	String dateofbirth = df.format(dob);

  
    
    

%>
<div class="row">

  <!-- Navigation Buttons -->
  <div class="col-md-2">
    <ul class="nav nav-pills nav-stacked" id="myTabs">
      <li class="active"><a data-toggle="tab" href="#studentprofile">Profile</a></li>
      <li><a data-toggle="tab" href="#studentresources">Resources</a></li>
      <li><a data-toggle="tab" href="#studentchkout">Checked Out Resources</a></li>
      <li><a data-toggle="tab" href="#studentrequests">Resource Requests</a></li>
      <li><a data-toggle="tab" href="#notifications">Notifications</a></li>
      <li><a data-toggle="tab" href="#balance">Due Balance</a></li>
    </ul>
  </div>

  <!-- Content -->
  <div class="col-md-9">
    <div class="tab-content">
      <div class="tab-pane active" id="studentprofile">
      	<form class="form-horizontal" action="EditStudent" method="POST">
  		<div class="form-group">
		    <label  class="col-sm-2 control-label">Student ID</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="studentId" name="studentId" value="<%= studentId%>" readonly>
	    	</div>
  		</div>
		<div class="form-group">
		    <label class="col-sm-2 control-label">First Name</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="studentfname" name="studentfname" value="<%= studentfName %>">
		    </div>
		</div>
		<div class="form-group">
		    <label class="col-sm-2 control-label">Last Name</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="studentlname" name="studentlname" value="<%= studentlname %>">
		    </div>
		</div>
		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Phone Number</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="phonenumber" name="phonenumber" value="<%=phno %>">
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Alternate Phone Number</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="altphonenumber" name="altphonenumber" value="<%=alt_phno %>">
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Street</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="street" name="street" value="<%=street %>">
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">City</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="city" name="city" value="<%=city %>">
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Pin</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="pin" name="pin" value="<%=pin %>">
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Date of Birth</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="dateofbirth" name="dateofbirth" value="<%=dateofbirth %>">
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Sex</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="sex" name="sex" value="<%=sex %>">
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Nationality</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="nationality" name="nationality" value="<%=nationality %>">
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Department</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="department" name="department" value="<%=department %>" readonly>
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Classification</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="classification" name="classification" value="<%=category %>" readonly>
	    	</div>
  		</div>
  		<div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">Degree</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="degree" name="degree" value="<%=degree %>" readonly>
	    	</div>
  		</div>
		 <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button type="submit" class="btn btn-default">Save</button>
		    </div>
		 </div>
	   </form>
      </div>
      <div class="tab-pane" id="studentresources">Res</div>
      <div class="tab-pane" id="studentchkout">Chkout</div>
      <div class="tab-pane" id="studentrequests">requests</div>
      <div class="tab-pane" id="notifications">not</div>
      <div class="tab-pane" id="balance">bal</div>
    </div>
  </div>

</div>
</body>
</html>