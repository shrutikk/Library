/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.27
 * Generated at: 2015-11-03 18:40:09 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class BookDetails_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("    \r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css\">\r\n");
      out.write("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js\"></script>\r\n");
      out.write("<script src=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css\">\r\n");
      out.write("<script src=\"//code.jquery.com/jquery-1.10.2.js\"></script>\r\n");
      out.write("<script src=\"//code.jquery.com/ui/1.11.4/jquery-ui.js\"></script>\r\n");
      out.write("<script src=\"jquery-ui-timepicker-addon.js\"></script>\r\n");
      out.write("<title>Reserve Book</title>\r\n");
      out.write("<script>\r\n");
      out.write("  $(function() {\r\n");
      out.write("    $( \".date\" ).datetimepicker({\r\n");
      out.write("        dateFormat:\"yy-mm-dd\",\r\n");
      out.write("        timeFormat: 'HH:mm:ss',\r\n");
      out.write("    \tstepHour: 1,\r\n");
      out.write("    \tstepMinute: 10,\r\n");
      out.write("    \tstepSecond: 10\r\n");
      out.write("    });\r\n");
      out.write("  });\r\n");
      out.write("  function reservebook(bookid){\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\tvar reserveServletUrl = \"/Library/ReserveBook?resId=\"+bookid+\"&chkDate=\"+document.getElementById((bookid+\"chkdate\")).value+\"&retDate=\"+document.getElementById((bookid+\"retdate\")).value;\r\n");
      out.write("  \twindow.location.href = reserveServletUrl;\r\n");
      out.write("  }\r\n");
      out.write("  function requestbook(bookid){\r\n");
      out.write("\t  \tvar reserveServletUrl = \"/Library/RequestBook?pubId=\"+bookid;\r\n");
      out.write("\t  \twindow.location.href = reserveServletUrl;\r\n");
      out.write("  }\r\n");
      out.write("  function renewbook(bookid){\r\n");
      out.write("\t  \tvar reserveServletUrl = \"/Library/RenewBook?pubId=\"+bookid+\"&renewdt=\"+document.getElementById((bookid+\"renewdate\")).value;\r\n");
      out.write("\t  \twindow.location.href = reserveServletUrl;\r\n");
      out.write("}\r\n");
      out.write("  </script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
HttpSession sess = request.getSession(false); 
      out.write("\r\n");
      out.write("<ol class=\"breadcrumb\">\r\n");
      out.write("  <li>");
if(sess.getAttribute("patrontype").equals("faculty")){
      out.write(" <a href=\"Faculty.jsp\">Home</a>");
}else if(sess.getAttribute("patrontype").equals("student")){
      out.write("<a href=\"Student.jsp\">Home</a>");
} 
      out.write("</li>\r\n");
      out.write("  <li><a href=\"Publications.jsp\">Publications</a></li>\r\n");
      out.write("  <li class=\"active\">Book</li>\r\n");
      out.write("</ol>\r\n");

if(request.getAttribute("bookresstatus")!=null){
if(request.getAttribute("bookresstatus").equals("success")){
	
      out.write("\r\n");
      out.write("\t<div class=\"alert alert-success fade in\">\r\n");
      out.write("    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n");
      out.write("    <strong>Success!</strong> You have successfully reserved the book.\r\n");
      out.write("  </div>\r\n");
      out.write("\t");
 
}else if(request.getAttribute("bookresstatus").equals("invalid duration")){
	
      out.write("\r\n");
      out.write("\t<div class=\"alert alert-danger fade in\">\r\n");
      out.write("    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n");
      out.write("    <strong>Error!</strong> Invalid duration for book.\r\n");
      out.write("  \t</div>\r\n");
      out.write("\t");

	
}else if(request.getAttribute("bookresstatus").equals("not enrolled")){
	
      out.write("\r\n");
      out.write("\t<div class=\"alert alert-danger fade in\">\r\n");
      out.write("    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n");
      out.write("    <strong>Error!</strong> Not enrolled for this course\r\n");
      out.write("  \t</div>\r\n");
      out.write("\t");

}
}
if(request.getAttribute("queueposition")!=null){
	
      out.write("\r\n");
      out.write("\t<div class=\"alert alert-success fade in\">\r\n");
      out.write("    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n");
      out.write("    <strong>Success!</strong> You have successfully requested the book.Queue Position ");
      out.print(request.getAttribute("queueposition"));
      out.write("\r\n");
      out.write("  </div>\r\n");
      out.write("  ");
} 
if(request.getAttribute("renewbookststus")!=null){
	
      out.write("\r\n");
      out.write("\t<div class=\"alert alert-success fade in\">\r\n");
      out.write("    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n");
      out.write("    <strong>Success!</strong> You have successfully renewed the book.\r\n");
      out.write("  </div>\r\n");
      out.write("  ");
} 


String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";
String isbn,title,edition,year,publisher,authors;
Integer resource_id;
String USER = "root";
String PASS = "";

String patronId=(String)sess.getAttribute("patronid");
Connection conn = null;
Class.forName(JDBC_DRIVER);
conn = DriverManager.getConnection(DB_URL, USER,null);
PreparedStatement pstmt = conn.prepareStatement("{call getBookById(?)}");
pstmt.setString(1, (String)request.getAttribute("ISBN"));
System.out.println((String)request.getAttribute("ISBN"));
sess.setAttribute("ISBN", (String)request.getAttribute("ISBN"));
//request.setAttribute("ISBN", (String)request.getParameter("ISBN"));
ResultSet rs = pstmt.executeQuery();                
rs.next();
isbn=rs.getString(1);
title=rs.getString(2);
year=rs.getString(3);
edition = rs.getString(4);
publisher = rs.getString(5);
authors=rs.getString(6);


CallableStatement checkifResBook = null;
checkifResBook = conn.prepareCall("{call isAReservedBook(?,?,?)}");
checkifResBook.setString(1, (String)request.getAttribute("ISBN"));
checkifResBook.registerOutParameter(2, java.sql.Types.BOOLEAN);
checkifResBook.registerOutParameter(3, java.sql.Types.VARCHAR);
checkifResBook.executeUpdate();

boolean isReserved = checkifResBook.getBoolean(2);
String course_id = checkifResBook.getString(3);
sess.setAttribute("isReserved", isReserved);
sess.setAttribute("courseId", course_id);

CallableStatement checkifAlreadyReserved = null;
checkifAlreadyReserved = conn.prepareCall("{call isPubCurrentlyReservedByPatron(?,?,?,?,?)}");
checkifAlreadyReserved.setString(1, (String)request.getAttribute("ISBN"));
checkifAlreadyReserved.setString(2, (String)sess.getAttribute("patronid"));
checkifAlreadyReserved.registerOutParameter(3, java.sql.Types.BOOLEAN);
checkifAlreadyReserved.registerOutParameter(4, java.sql.Types.INTEGER);
checkifAlreadyReserved.registerOutParameter(5, java.sql.Types.INTEGER);
checkifAlreadyReserved.executeUpdate();

boolean isResbypatron = checkifAlreadyReserved.getBoolean(3);
boolean isEcopy=false,canbeRenewed=false;
int reserv_id=0,reserved_res_id=0;
if(isResbypatron){
	reserv_id = checkifAlreadyReserved.getInt(4);
	reserved_res_id = checkifAlreadyReserved.getInt(5);
	System.out.println("Reserved redsid"+reserved_res_id);
	CallableStatement checkifEcopy = null;
	checkifEcopy = conn.prepareCall("{call isECopy(?,?)}");
	checkifEcopy.setInt(1, reserved_res_id);
	checkifEcopy.registerOutParameter(2, java.sql.Types.INTEGER);
	checkifEcopy.executeUpdate();
	isEcopy = checkifEcopy.getBoolean(2);
	
	CallableStatement canRenew = null;
	canRenew = conn.prepareCall("{call canBeRenewed(?,?)}");
	canRenew.setInt(1, reserv_id);
	canRenew.registerOutParameter(2, java.sql.Types.INTEGER);
	canRenew.executeUpdate();
	canbeRenewed = canRenew.getBoolean(2);
}


      out.write("\r\n");
      out.write("<div class=\"panel panel-default\">\r\n");
      out.write("  <div class=\"panel-heading\">\r\n");
      out.write("    <h3 class=\"panel-title\">Book Details</h3>\r\n");
      out.write("  </div>\r\n");
      out.write("  <div class=\"panel-body\">\r\n");
      out.write("    <p>ISBN Number : ");
      out.print(isbn );
      out.write("</p>\r\n");
      out.write("    <p>Title : ");
      out.print(title );
      out.write("</p>\r\n");
      out.write("    <p>Edition : ");
      out.print(edition );
      out.write("</p>\r\n");
      out.write("    <p>Authors : ");
      out.print(authors );
      out.write("</p>\r\n");
      out.write("    <p>Year of Publication : ");
      out.print(year );
      out.write("</p>\r\n");
      out.write("    <p>Publisher : ");
      out.print(publisher );
      out.write("</p>\r\n");
      out.write("    <table class=\"table table-striped\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<th>ISBN Number</th>\r\n");
      out.write("\t<th>Type</th>\r\n");
      out.write("\t<th>Status</th>\r\n");
      out.write("\t<th>Checkout Date</th>\r\n");
      out.write("\t<th>Return Date</th>\r\n");
      out.write("\t<th></th>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t");

	CallableStatement stmt = null;
	stmt = conn.prepareCall("{call hasHardCopy(?,?)}");
    stmt.setString(1, (String)request.getAttribute("ISBN"));
    stmt.registerOutParameter(2, java.sql.Types.BOOLEAN);
    
    stmt.executeUpdate();
    if(stmt.getBoolean(2)){
    	
	
      out.write("\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td>");
      out.print(isbn );
      out.write("</td>\r\n");
      out.write("\t<td>Hard Copy</td>\r\n");
      out.write("\t");

		if(isResbypatron){
			
      out.write("\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t");
if(isEcopy){ 
      out.write("\r\n");
      out.write("\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t");
}else{
				
      out.write("\r\n");
      out.write("\t\t\t\t<td>Checked Out</td>\r\n");
      out.write("\t\t\t\t");

				if(canbeRenewed){
					String renewId = reserv_id+"renewdate";
				
      out.write("\r\n");
      out.write("\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t<td><input type=\"text\" class=\"date\" id=\"");
      out.print(renewId);
      out.write("\"/></td>\r\n");
      out.write("\t\t\t\t\t<td><button id=\"");
      out.print(reserv_id);
      out.write("\" onclick=\"renewbook(this.id)\">Renew</button></td>\r\n");
      out.write("\t\t\t\t");
}else{
				
      out.write("\t\r\n");
      out.write("\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t<td></td>\r\n");
      out.write("\t\t\t\t\t<td><button disabled=\"disabled\">Renew</button></td>\r\n");
      out.write("\t\t\t\t\t");
 }
			}
			 
      out.write("\t\t\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t");
 }else{
			CallableStatement checkifCheckedOut = null;
			checkifCheckedOut = conn.prepareCall("{call getAvailablePublicationResourceId(?,?,?,?)}");
			checkifCheckedOut.setString(1, (String)request.getAttribute("ISBN"));
			checkifCheckedOut.setString(2, "hardcopy");
			checkifCheckedOut.setString(3, patronId);
			checkifCheckedOut.registerOutParameter(4, java.sql.Types.INTEGER);
			checkifCheckedOut.executeUpdate();
			
			resource_id = checkifCheckedOut.getInt(4);
			
			System.out.println("Hard Copy:"+resource_id);
			if(resource_id!=0){
				String chkid = resource_id+"chkdate";
				String retid = resource_id+"retdate";
				sess.setAttribute("resourceId", resource_id);
				if(isReserved){
	
      out.write("\r\n");
      out.write("\t\t\t\t<td>Available - On Reserve</td>\r\n");
      out.write("\t\t\t");
}else{ 
      out.write("\r\n");
      out.write("\t\t\t\t<td>Available </td>\r\n");
      out.write("\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t<td><input type=\"text\" class=\"date\" id=\"");
      out.print(chkid);
      out.write("\"/></td>\r\n");
      out.write("\t\t<td><input type=\"text\" class=\"date\" id=\"");
      out.print(retid);
      out.write("\"/></td>\r\n");
      out.write("\t\t<td><button id=\"");
      out.print(resource_id);
      out.write("\" onclick=\"reservebook(this.id)\">Reserve</button></td>\r\n");
      out.write("\t");
}else{
		
		
      out.write("\r\n");
      out.write("\t\t<td>Not Available</td>\r\n");
      out.write("\t\t<td></td>\r\n");
      out.write("\t\t<td></td>\r\n");
      out.write("\t\t<td><button id=\"");
      out.print(resource_id);
      out.write("\" onclick=\"requestbook('");
      out.print(isbn);
      out.write("')\">Request</button></td>\r\n");
      out.write("\t\t");

		}
		
      out.write("\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t");
 
	}
	}
      out.write('\r');
      out.write('\n');
      out.write('	');

	
	stmt = conn.prepareCall("{call hasECopy(?,?)}");
    stmt.setString(1, (String)request.getAttribute("ISBN"));
    stmt.registerOutParameter(2, java.sql.Types.BOOLEAN);
    
    stmt.executeUpdate();
    if(stmt.getBoolean(2)){
	
      out.write("\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t<td>");
      out.print(isbn );
      out.write("</td>\r\n");
      out.write("\t<td>E Copy</td>\r\n");
      out.write("\t");

	if(isResbypatron){
		
      out.write("\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t");
 if(isEcopy){
		
      out.write("\r\n");
      out.write("\t\t\t<td>Checked Out</td>\t\r\n");
      out.write("\t\t\t");
 if(canbeRenewed){
				String renewId = reserv_id+"renewdate";
			
      out.write("\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<td><input type=\"text\" class=\"date\" id=\"");
      out.print(renewId);
      out.write("\"/></td>\r\n");
      out.write("\t\t\t\t<td><button id=\"");
      out.print(reserv_id);
      out.write("\" onclick=\"renewbook(this.id)\">Renew</button></td>\r\n");
      out.write("\t\t\t");
}else{
			
      out.write("\t<td><button id=\"");
      out.print(reserv_id);
      out.write("\" onclick=\"renewbook(this.id)\">Renew</button></td>\r\n");
      out.write("\t\t\t\t");
 }
		}else{
		
      out.write("\r\n");
      out.write("\t\t\t<td></td>\r\n");
      out.write("\t\t\t<td></td>\r\n");
      out.write("\t\t\t<td></td>\r\n");
      out.write("\t\t\t<td></td>\r\n");
      out.write("\t");
}
	}else{
	
			CallableStatement checkifCheckedOut = null;
			checkifCheckedOut = conn.prepareCall("{call getAvailablePublicationResourceId(?,?,?,?)}");
			checkifCheckedOut.setString(1, (String)request.getAttribute("ISBN"));
			checkifCheckedOut.setString(2, "ecopy");
			checkifCheckedOut.setString(3, patronId);
			checkifCheckedOut.registerOutParameter(4, java.sql.Types.INTEGER);
			checkifCheckedOut.executeUpdate();
			
			resource_id = checkifCheckedOut.getInt(4);
			System.out.println("Ecopy"+resource_id);
			if(resource_id!=0){
				String chkid = resource_id+"chkdate";
				String retid = resource_id+"retdate";
				sess.setAttribute("resourceId", resource_id);
				if(isReserved){
	
      out.write("\r\n");
      out.write("\t\t\t\t<td>Available - On Reserve</td>\r\n");
      out.write("\t\t\t");
}else{ 
      out.write("\r\n");
      out.write("\t\t\t\t<td>Available </td>\r\n");
      out.write("\t\t\t\t");
} 
      out.write("\r\n");
      out.write("\t\t<td><input type=\"text\" class=\"date\" id=\"");
      out.print(chkid);
      out.write("\"/></td>\r\n");
      out.write("\t\t<td><input type=\"text\" class=\"date\" id=\"");
      out.print(retid);
      out.write("\"/></td>\r\n");
      out.write("\t\t<td><button id=\"");
      out.print(resource_id);
      out.write("\" onclick=\"reservebook(this.id)\">Reserve</button></td>\r\n");
      out.write("\t");
}else{
		
		
      out.write("\r\n");
      out.write("\t\t<td>Not Available</td>\r\n");
      out.write("\t\t<td><input type=\"text\" class=\"date\" readonly/></td>\r\n");
      out.write("\t\t<td><input type=\"text\" class=\"date\" readonly/></td>\r\n");
      out.write("\t\t<td><button id=\"");
      out.print(resource_id);
      out.write("\" onclick=\"requestbook('");
      out.print(isbn);
      out.write("')\">Request</button></td>\r\n");
      out.write("\t\t");

		}
		
      out.write("\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t");
 
	}
	}
      out.write("\r\n");
      out.write("\t</table>    \r\n");
      out.write("  </div>\r\n");
      out.write("</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
