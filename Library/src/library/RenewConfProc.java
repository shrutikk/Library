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
 * Servlet implementation class RenewConfProc
 */

public class RenewConfProc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RenewConfProc() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String pubId = (String) request.getParameter("pubId");
		String renwdate = (String)request.getParameter("renewdt");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		
		String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";

		   //  Database credentials
		String USER = "root";
		String PASS = "";
		Connection conn = null;
		CallableStatement stmt = null;
		Date renDate = null;
		System.out.println(renwdate);
		try {
			format.setLenient(false);
			renDate = format.parse(renwdate);	
			
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
		try {
			stmt = conn.prepareCall("{call renewJournalConferenceResource(?,?,?)}");
			stmt.setString(1, pubId);
			stmt.setTimestamp(2, new java.sql.Timestamp(renDate.getTime()));
	        stmt.registerOutParameter(3, java.sql.Types.VARCHAR);
	        
	        stmt.executeUpdate();
	        
	        request.setAttribute("renewconfststus", stmt.getString(3));
	        String confno = (String) sess.getAttribute("CONFNO");
			System.out.println("CONFNO:"+confno);
			request.setAttribute("CONFNO", confno);
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
