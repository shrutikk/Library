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
<script>
function redirectPublicationsPage(){
	window.location="Publications.jsp";
}
function redirectCameraPage(){
	window.location="Camera.jsp";
}
function redirectRoomsPage(){
	window.location="Rooms.jsp";
}
function checkOutRoomRedirect(reservationId){
	window.location="/Library/CheckoutRoom?resId="+reservationId;
}
function checkOutCameraRedirect(reservationId){
	window.location="/Library/CheckoutCamera?resId="+reservationId;
}
function checkInRoomRedirect(reservationId){
	window.location="/Library/CheckInRoom?resId="+reservationId;
}
function checkInCameraRedirect(reservationId){
	window.location="/Library/CheckInCamera?resId="+reservationId;
}
function checkInDocumentRedirect(reservationId){
	window.location="/Library/CheckInDocument?resId="+reservationId;
}
function payBalance(amount){	
	window.location="/Library/MakePayment?amount="+amount;
}
</script>
<title>Student</title>
</head>
<body>
<%
boolean ischeckedout =false,ischeckedin=false;
if(request.getAttribute("checkoutstatus")!=null){
	ischeckedout=true;
	
}
if(request.getAttribute("checkinstatus")!=null){
	ischeckedin=true;
	
}
String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";

String USER = "root";
String PASS = "";
Connection conn = null;
String studentId,studentfName,studentlname,nationality,department,sex,address,category,degree,phno,alt_phno,street,city,pin;
float balance=0;
Date dob;


	Class.forName(JDBC_DRIVER);
	conn = DriverManager.getConnection(DB_URL, USER,null);
	HttpSession sess = request.getSession(false); //use false to use the existing session
	String patronId=(String)sess.getAttribute("patronid");
	
	System.out.println(patronId);
	PreparedStatement pstmt = conn.prepareStatement("{call getStudentProfile(?)}");
    pstmt.setString(1, patronId);
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
   	balance = rs.getFloat(13);
    rs.close();
    pstmt.close();
     
    DateFormat df = new SimpleDateFormat("MM/dd/yyyy");        
	String dateofbirth = df.format(dob);

	pstmt = conn.prepareStatement("{call getAllNotifications(?)}");
    pstmt.setString(1, patronId);
    ResultSet not = pstmt.executeQuery();    
    
    ResultSet rsCheckedOutRooms=null;
	try {
	PreparedStatement pstmtCheckedOutRooms = conn.prepareStatement("{call getAllCheckedoutRooms(?)}");
    pstmtCheckedOutRooms.setString(1,patronId);
    rsCheckedOutRooms = pstmtCheckedOutRooms.executeQuery();        
	} catch (SQLException e) 
    {
		e.printStackTrace();
	}    
	
	//Get list of checkedout Cameras
	ResultSet rsCheckedOutCameras=null;
	try {
	PreparedStatement pstmtCheckedOutCameras = conn.prepareStatement("{call getAllCheckedoutCamera(?)}");
	pstmtCheckedOutCameras.setString(1,patronId);
    rsCheckedOutCameras = pstmtCheckedOutCameras.executeQuery();        
	} catch (SQLException e) 
    {
		e.printStackTrace();
	}
       
	//Get list of checkedout publications
	ResultSet rsCheckedOutPublications=null;
	try {
	PreparedStatement pstmtCheckedOutPublications = conn.prepareStatement("{call getAllCheckedoutPublications(?)}");
    pstmtCheckedOutPublications.setString(1,patronId);
    rsCheckedOutPublications = pstmtCheckedOutPublications.executeQuery();        
	} catch (SQLException e) 
    {
		e.printStackTrace();
	}  
	
	//Get All Requested Rooms
    ResultSet rsReservedRooms=null;
	try {
	PreparedStatement pstmtReservedRooms = conn.prepareStatement("{call getAllRequestedRooms(?)}");
    pstmtReservedRooms.setString(1,patronId);
    rsReservedRooms = pstmtReservedRooms.executeQuery();        
	} catch (SQLException e) 
    {
		e.printStackTrace();
	}
	
    //Get All Requested Cameras
    ResultSet rsReservedCameras=null;
	try {
	PreparedStatement pstmtReservedCameras = conn.prepareStatement("{call getAllReservedCamera(?)}");
    pstmtReservedCameras.setString(1,patronId);
    rsReservedCameras = pstmtReservedCameras.executeQuery();        
	} catch (SQLException e) 
    {
		e.printStackTrace();
	}
	
	ResultSet isPatrononHold=null;
	boolean isOnHold=false;
	try {
		CallableStatement onhold = conn.prepareCall("{call isPatronOnHold(?,?)}");
		onhold.setString(1,patronId);
		onhold.registerOutParameter(2, java.sql.Types.BOOLEAN);
		onhold.executeUpdate();
		isOnHold=onhold.getBoolean(2);
		
	} catch (SQLException e) 
    {
		e.printStackTrace();
	}
	


%>
<div class="row">

  <!-- Navigation Buttons -->
  <div class="col-md-2">
    <ul class="nav nav-pills nav-stacked" id="myTabs">
       <li <%if((!ischeckedout) && (!ischeckedin)){ %>class="active" <%} %>><a data-toggle="tab" href="#studentprofile">Profile</a></li>
      <li><a data-toggle="tab" href="#studentresources">Resources</a></li>
      <li <%if(ischeckedin){ %> class="active" <%} %>><a data-toggle="tab" href="#studentchkout">Checked Out Resources</a></li>
      <li <%if(ischeckedout){ %> class="active" <%} %>><a data-toggle="tab" href="#studentrequests">Resource Requests</a></li>
      <li><a data-toggle="tab" href="#notifications">Notifications</a></li>
      <li><a data-toggle="tab" href="#balance">Due Balance</a></li>
    </ul>
  </div>

  <!-- Content -->
  <div class="col-md-9">
    <div class="tab-content">
      <div class="tab-pane <%if((!ischeckedout) && (!ischeckedin)){ %>active <%} %>"  id="studentprofile">
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
      
      <div class="tab-pane" id="studentresources">
      <%
      	if(!isOnHold){
      %>
      	<button type="submit" class="btn btn-default" onclick="redirectPublicationsPage()">Publications</button>
      <button type="submit" class="btn btn-default" onclick="redirectCameraPage()">Camera</button>
      <button type="submit" class="btn btn-default" onclick="redirectRoomsPage()">Rooms</button>
      	<%}else{ %>
      	<div class="alert alert-danger fade in">
	    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	    <strong>Error!</strong> You are on Hold.
	  	</div>
  	<%} %>
      </div>
      <div class="tab-pane <%if(ischeckedin){ %>active <%} %>"  id="studentchkout">
      	<% 	
    		if(ischeckedin && request.getAttribute("checkinstatus").equals("success")){
		%>
		<div class="alert alert-success fade in">
	    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	    <strong>Success!</strong> Checkin successful.
	  </div>
	  
		<% }%>	
		<h3>Checked Out Rooms</h3>
      	<table class="table table-striped" id="checkedRoomsTable">
<tr>
<th>Reservation Id</th>
<th>Room Number</th>
<th></th>
</tr>
<%	
	while(rsCheckedOutRooms.next())
	{
%>
<tr>
<td><%=rsCheckedOutRooms.getString(2)%></td>
<td><%=rsCheckedOutRooms.getString(1)%></td>
<td><button type="submit" class="btn btn-default" value="<%=rsCheckedOutRooms.getString(2)%>" onclick="checkInRoomRedirect(<%=rsCheckedOutRooms.getString(2)%>)">CheckIn</button></td>
</tr>
<%	   
	}	
%>
</table>
      
<h3>Checked out Cameras</h3>     
<table class="table table-striped" id="checkedCamerasTable">
<tr>
<th>Reservation Id</th>
<th>Camera Id</th>
<th></th>
</tr>
<%	
	while(rsCheckedOutCameras.next())
	{
%>
<tr>
<td><%=rsCheckedOutCameras.getString(2)%></td>
<td><%=rsCheckedOutCameras.getString(1)%></td>
<td><button type="submit" class="btn btn-default" value="<%=rsCheckedOutCameras.getString(2)%>" onclick="checkInCameraRedirect(<%=rsCheckedOutCameras.getString(2)%>)">CheckIn</button></td>
</tr>
<%	   
	}	
%>
</table>
      
<h3>Checked Out Publications</h3>     
<table class="table table-striped" id="checkedPublicationsTable">
<tr>
<th>Reservation Id</th>
<th>Publication Id</th>
<th></th>
</tr>
<%	
	while(rsCheckedOutPublications.next())
	{
%>
<tr>
<td><%=rsCheckedOutPublications.getString(2)%></td>
<td><%=rsCheckedOutPublications.getString(3)%></td>
<td><button type="submit" class="btn btn-default" value="<%=rsCheckedOutPublications.getString(2)%>" onclick="checkInDocumentRedirect(<%=rsCheckedOutPublications.getString(2)%>)">CheckIn</button></td>
</tr>
<%	   
	}	
%>
</table>   
      	
      </div>
      <div class="tab-pane <%if(ischeckedout){ %>active <%} %>"" id="studentrequests">
      <% 	
    		if(ischeckedout && request.getAttribute("checkoutstatus").equals("success")){
		%>
		<div class="alert alert-success fade in">
	    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
	    <strong>Success!</strong> Checkout successful.
	  </div>
	  
		<% }%>	
		<h3>Reserved Rooms</h3>
      	<table class="table table-striped" id="roomsTable">
<tr>
<th>Reservation Id</th>
<th>Room Number</th>
</tr>
<%	
	while(rsReservedRooms.next())
	{
%>
<tr>
<td><%=rsReservedRooms.getString(2)%></td>
<td><%=rsReservedRooms.getString(1)%></td>
<td><button type="submit" class="btn btn-default" value="<%=rsReservedRooms.getString(2)%>" onclick="checkOutRoomRedirect(<%=rsReservedRooms.getString(2)%>)">Checkout</button></td>
</tr>
<%	   
	}	
%>
</table>
         
<h3>Reserved Camera</h3>     
<table class="table table-striped" id="camerasTable">
<tr>
<th>Reservation Id</th>
<th>Camera Id</th>
<th></th>
</tr>
<%	
	while(rsReservedCameras.next())
	{
%>
<tr>
<td><%=rsReservedCameras.getString(2)%></td>
<td><%=rsReservedCameras.getString(1)%></td>
<td><button type="submit" class="btn btn-default" value="<%=rsReservedCameras.getString(2)%>" onclick="checkOutCameraRedirect(<%=rsReservedCameras.getString(2)%>)">Checkout</button></td>
</tr>
<%	   
	}	
%>
</table>
      </div>
      <div class="tab-pane" id="notifications">
      	<%
      	if (!not.next()) {
      	  %>
      	  <p> No Notifications </p>
      	  <%
      	} else {
      	  //display results%>
      	  <table class="table table-striped" id="notificationTable">
      	  <tr>
      	  <th>Notification Time </th>
      	  <th>Notification </th>
      	  </tr>
      <%	  do {
      	    %>
      	    <tr>
      	    <td><%=not.getString(5) %></td>
      	    <td><%=not.getString(4) %></td>
      	    </tr>
      	    <% 
      	  } while (not.next());
      	}
      	%>
      	</table>
      </div>
      <div class="tab-pane" id="balance">
			<div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">Balance</label>
			    <div class="col-sm-10">
			     <input type="text" class="form-control" id="inputbalance" placeholder="Balance" value="<%=balance %>" readonly="true">
			    </div>
			 </div>
			 <div class="form-group">
		    <div class="col-sm-10">
		      <button type="submit" class="btn btn-default" onclick="payBalance(<%=String.valueOf(balance)%>)">Pay Balance</button>
		    </div>
	  	</div> 
	   </div>
    </div>
  </div>

</div>
</body>
</html>