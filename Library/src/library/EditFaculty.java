package library;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditFaculty
 */
@WebServlet("/EditFaculty")
public class EditFaculty extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditFaculty() {
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
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";

		   //  Database credentials
		String USER = "root";
		String PASS = "";
		Connection conn = null;
		CallableStatement stmt = null;
		
		String facId = request.getParameter("facId");
		String fname=request.getParameter("facfname");
		String lname=request.getParameter("faclname");
		String nationality = request.getParameter("facnation");
		
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER,null);
			stmt = conn.prepareCall("{call editFaculty(?,?,?,?)}");
            stmt.setString(1, facId);
            stmt.setString(2, fname);
            stmt.setString(3, lname);
            stmt.setString(4, nationality);
            
            
            System.out.println(stmt); 
            stmt.executeUpdate();
             
            	System.out.println(facId);
            	//request.setAttribute("",facId);
            	request.getRequestDispatcher("Faculty.jsp").forward(request, response);
            
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
