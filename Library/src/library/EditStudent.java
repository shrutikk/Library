package library;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditStudent
 */

public class EditStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditStudent() {
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
		
		String studentId = request.getParameter("studentId");
		String fname=request.getParameter("studentfname");
		String lnames=request.getParameter("studentlname");
		System.out.println("Last"+lnames);
		String nationality = request.getParameter("nationality");
		String sex = request.getParameter("sex");
		String phno = request.getParameter("phonenumber");
		String alt_phno=request.getParameter("altphonenumber");
		Date dob = new Date();
		String street = request.getParameter("street");
		String city = request.getParameter("city");
		String pin = request.getParameter("pin");
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(DB_URL, USER,null);
			stmt = conn.prepareCall("{call editStudent(?,?,?,?,?,?,?,?,?,?,?)}");
            stmt.setString(1, studentId);
            stmt.setString(2, fname);
            stmt.setString(3, lnames);
            stmt.setString(4, nationality);
            stmt.setString(5, sex);
            stmt.setString(6, phno);
            stmt.setString(7, alt_phno);
            stmt.setDate(8, new java.sql.Date(0));
            stmt.setString(9, street);
            stmt.setString(10, city);
            stmt.setString(11, pin);
            
            
            System.out.println(stmt); 
            stmt.executeUpdate();
             
            	System.out.println(studentId);
            	request.setAttribute("studentid",studentId);
            	request.getRequestDispatcher("Student.jsp").forward(request, response);
            
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
