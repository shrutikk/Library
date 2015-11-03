package library;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//import com.mysql.jdbc.CallableStatement;

/**
 * Servlet implementation class RoomReserver
 */
@WebServlet("/RoomReserver")
public class RoomReserver extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoomReserver() {
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
		String patronId = request.getParameter("patid");
		String resourceId = request.getParameter("resid");
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
			stmt = (CallableStatement) conn.prepareCall("{call reserveRoom(?,?,?,?,?)}");
            stmt.setString(1,patronId);
            stmt.setString(2,resourceId);
            stmt.setTimestamp(3,sqlStartDate);
            stmt.setTimestamp(4,sqlEndDate);
            stmt.registerOutParameter(5,java.sql.Types.VARCHAR);
            stmt.executeQuery();
            String status=stmt.getString(5);
            System.out.println(status);
            if(status.equalsIgnoreCase("booked"))
            {
            request.setAttribute("pid",patronId);
            request.setAttribute("rid",resourceId);
            request.setAttribute("st",stime);
            request.setAttribute("et",etime);
            request.getRequestDispatcher("RoomReservationDetails.jsp").forward(request, response);
            }
            else
            {
             request.getRequestDispatcher("RejectRoomReservation.jsp").forward(request, response);
            }
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}

}
