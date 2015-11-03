package library;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.CallableStatement;

//import com.mysql.jdbc.Connection;

/**
 * Servlet implementation class FetchRoomInfo
 */
@WebServlet("/FetchRoomInfo")
public class FetchRoomInfo extends HttpServlet {
	
	
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FetchRoomInfo() {
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
		int occupantNumber=Integer.parseInt(request.getParameter("occucount"));
		String libraryId=request.getParameter("libid");
		String rooomTypeName=request.getParameter("roomdropdown");
		
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
			PreparedStatement pstmt = conn.prepareStatement("{call getAllRooms(?,?,?)}");
            pstmt.setInt(1, occupantNumber);
            pstmt.setString(2, libraryId);
            pstmt.setString(3, rooomTypeName);
            ResultSet rs1 = pstmt.executeQuery();
           
            request.setAttribute("roomInfo",rs1);
            request.getRequestDispatcher("AllRoomsInfo.jsp").forward(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
