package library;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CheckFacultyLogin
 */

public class CheckFacultyLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckFacultyLogin() {
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
		String username = request.getParameter("unityid_fac");
		String password = request.getParameter("password_fac");
		
		HttpSession sess = request.getSession();
		sess.setAttribute("patronid",username);
		sess.setAttribute("patrontype", "faculty");
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		String DB_URL = "jdbc:mysql://54.218.118.111:3306/db_project";

		   //  Database credentials
		String USER = "root";
		String PASS = "";
		Connection conn = null;
		CallableStatement stmt = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = (Connection) DriverManager.getConnection(DB_URL, USER,null);
			stmt = (CallableStatement) conn.prepareCall("{call checkLogin(?,MD5(?),?,?)}");
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setInt(3, 1);
            stmt.registerOutParameter(4, java.sql.Types.BOOLEAN); 
            stmt.executeUpdate();
             
            //read the OUT parameter now
            Boolean allow = stmt.getBoolean(4);
            
            if(!allow){
            	request.setAttribute("error","Invalid Username or Password");
            	RequestDispatcher rd=request.getRequestDispatcher("/Library.jsp");            
            	rd.include(request, response);
            }
            else{
            	request.setAttribute("Facultyid",username);
                request.getRequestDispatcher("Faculty.jsp").forward(request, response);
            	//response.sendRedirect("Faculty.jsp");
            }
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}


	}

}
