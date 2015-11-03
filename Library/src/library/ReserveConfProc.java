package library;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ReserveConfProc
 */
@WebServlet("/ReserveConfProc")
public class ReserveConfProc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReserveConfProc() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String chkdate = (String) request.getParameter("chkDate");
		String retdate = (String) request.getParameter("retDate");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		
		String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";

		   //  Database credentials
		String USER = "root";
		String PASS = "";
		Connection conn = null;
		CallableStatement stmt = null;
		
		Date chkDate = null,retDate = null;
		try {
			format.setLenient(false);
			chkDate = format.parse(chkdate);
			retDate=format.parse(retdate);
		
			
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER,null);
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpSession sess = request.getSession(false);
		String issn = (String) sess.getAttribute("CONFNO");
		System.out.println("CONFNO:"+issn);
		request.setAttribute("CONFNO", issn);
		System.out.println(sess.getAttribute("patronid"));
	
			try {
				
	            	stmt = conn.prepareCall("{call reserveJournalConferenceResource(?,?,?,?,?)}");
					stmt.setInt(1, Integer.parseInt(request.getParameter("resId")));
		            stmt.setString(2, (String)sess.getAttribute("patronid"));
		            stmt.setTimestamp(3, new java.sql.Timestamp(chkDate.getTime()));
		            stmt.setTimestamp(4, new java.sql.Timestamp(retDate.getTime()));
		            stmt.registerOutParameter(5, java.sql.Types.VARCHAR);
		            
		            
		            stmt.executeUpdate();
		            request.setAttribute("confresstatus", stmt.getString(5));
	            
	            
	            RequestDispatcher rd=request.getRequestDispatcher("/ConferenceDetails.jsp");            
	            rd.include(request, response);
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
		doGet(request, response);
	}

}
