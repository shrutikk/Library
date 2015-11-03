package library;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ReserveCamera
 */

public class ReserveCamera extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReserveCamera() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String date = request.getParameter("reserveDate");
		date=date+" 09:00:00";
		HttpSession sess = request.getSession(false); //use false to use the existing session
		int resource_id=(int)sess.getAttribute("resourceId");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		
		//SimpleDateFormat dbformat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		//System.out.println(date);
	    String result=null;
	    Date pdate = null;
		try {
			format.setLenient(false);
			pdate = format.parse(date);
			pdate.setHours(9);
		
			System.out.println((pdate));
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
			
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
				stmt = conn.prepareCall("{call reserveCamera(?,?,?,?,?)}");
	            stmt.setString(1,Integer.toString(resource_id));
	            System.out.println(new java.sql.Timestamp(pdate.getTime() ));
	            stmt.setTimestamp(2,new java.sql.Timestamp(pdate.getTime()) );
	            stmt.setString(3, (String)sess.getAttribute("patronid"));
	            stmt.registerOutParameter(4, java.sql.Types.VARCHAR);
	            stmt.registerOutParameter(5, java.sql.Types.VARCHAR); 
	            stmt.executeUpdate();
	             
	            String quepos = stmt.getString(4);
	            String retttype = stmt.getString(5);
	            request.setAttribute("camera", sess.getAttribute("camera"));
	            request.setAttribute("rettype", retttype);
	            request.setAttribute("reservationstatus", quepos);
	            RequestDispatcher rd=request.getRequestDispatcher("/CameraDetails.jsp");            
	            rd.include(request, response);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//System.out.println("mm"+request.getParameter("camreservedate"));
	}

}
