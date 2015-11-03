package library;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CheckInRoom
 */
@WebServlet("/CheckInRoom")
public class CheckInRoom extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckInRoom() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String reservationId = (String)request.getParameter("resId");
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";
		//  Database credentials
		String USER = "root";
		String PASS = "";
		Connection conn = null;
		CallableStatement stmt = null;
		String status=null;
		HttpSession sess = request.getSession(false);
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER,null);
			stmt = (CallableStatement) conn.prepareCall("{call checkInRoom(?,?)}");
		    stmt.setInt(1,Integer.parseInt(reservationId));
		    stmt.registerOutParameter(2,java.sql.Types.VARCHAR);
		    stmt.executeQuery();
		    status=stmt.getString(2);
		    
		    request.setAttribute("checkinstatus", status);
		    if(sess.getAttribute("patrontype").equals("faculty")){
		    	RequestDispatcher rd=request.getRequestDispatcher("/Faculty.jsp");            
	            rd.include(request, response);
		    }else if(sess.getAttribute("patrontype").equals("student")){
		    	RequestDispatcher rd=request.getRequestDispatcher("/Student.jsp");            
	            rd.include(request, response);
		    }
		    System.out.println("CheckedIn Status:"+status);
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
