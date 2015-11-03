package library;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BookReserverForFaculty
 */
@WebServlet("/BookReserverForFaculty")
public class BookReserverForFaculty extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookReserverForFaculty() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession sess = request.getSession(false);
		String facid = (String)sess.getAttribute("patronid");
		String cid = request.getParameter("coursedropdown");
		String pubid = request.getParameter("booksdropdown");
		String stime = request.getParameter("stime");
		String etime = request.getParameter("etime");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		 
		java.util.Date SDate=null;
		java.util.Date EDate=null;
		
	try{
	    SDate = sdf.parse(stime);
	    System.out.println(SDate);
	    EDate = sdf.parse(etime);
	    System.out.println(EDate);
	}
	catch(ParseException e2) {
		e2.printStackTrace();
	}
    
	java.sql.Timestamp sqlStartDate = new java.sql.Timestamp(SDate.getTime());
	java.sql.Timestamp sqlEndDate = new java.sql.Timestamp(EDate.getTime());
			
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";
		//  Database credentials
		String USER = "root";
		String PASS = "";
		Connection conn = null;
		CallableStatement stmt = null;
		
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER,null);
			stmt = (CallableStatement) conn.prepareCall("{call reserveBookForCourse(?,?,?,?,?,?)}");
            stmt.setString(1,facid);
            stmt.setString(2,cid);
            stmt.setString(3,pubid);
            stmt.setTimestamp(4,sqlStartDate);
            stmt.setTimestamp(5,sqlEndDate);
            stmt.registerOutParameter(6,java.sql.Types.VARCHAR);
            stmt.executeQuery();
            String status=stmt.getString(6);
            
            request.setAttribute("courseresstatus", status);
		    RequestDispatcher rd=request.getRequestDispatcher("/Faculty.jsp");            
	        rd.include(request, response);
		    
            System.out.println(status);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}

}
