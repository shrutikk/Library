<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String patronId=(String)request.getAttribute("pid");
String resourceId=(String)request.getAttribute("rid");
String startTime=(String)request.getAttribute("st");
String endTime=(String)request.getAttribute("et");
%>
<h1>The Following Reservation has been made:</h1>
<h2>Patron Id : <%=patronId%></h2>
<h2>ResourceId : <%=resourceId%></h2>
<h2>Start Time : <%=startTime%></h2>
<h2>Ending Time : <%=endTime%></h2>
</body>
</html>