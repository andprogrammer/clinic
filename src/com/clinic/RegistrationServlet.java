package com.clinic;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/registrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//PrintWriter out = response.getWriter();
		//out.println("name: "+request.getParameter("name"));
		
		String first_name=request.getParameter("first_name");
		String last_name=request.getParameter("last_name");
		String pesel=request.getParameter("pesel");
		
		String email=request.getParameter("email");
		String password1=request.getParameter("password1");
		String password2=request.getParameter("password2");
		
		if(first_name == null || first_name.length()<2) {
			request.setAttribute("action", "niepoprawnie wprowadzone imie");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=6").forward(request, response);
		} else if(last_name == null || last_name.length()<2) {
			request.setAttribute("action", "niepoprawnie wprowadzone nazwisko");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=6").forward(request, response);
		} else if(pesel == null || pesel.length()!=11) {
			request.setAttribute("action", "niepoprawnie wprowadzone numer pesel");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=6").forward(request, response);
//		} else if(email == null || !GlobalFunctions.isValidEmailAddress(email)) {
//			request.setAttribute("action", "niepoprawny adres email");
//			getServletContext().getRequestDispatcher("/index.jsp?subpage=6").forward(request, response);
		} else if( (password1 == null || password2 == null) || (!password1.equals(password2)) ) {
			request.setAttribute("action", "niepoprawne hasla");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=6").forward(request, response);
		} else {

			try
		    {
		      // create a mysql database connection
		      String myDriver = "com.mysql.jdbc.Driver";
		      String myUrl = "jdbc:mysql://localhost/clinic?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		      Class.forName(myDriver);
		      Connection conn = DriverManager.getConnection(myUrl, "root", "#Krakow2019");
		      
		      // the mysql insert statement
		      String query = " insert into user (first_name, last_name, pesel, email, password)" + " values (?, ?, ?, ?, ?)";

		      // create the mysql insert preparedstatement
		      PreparedStatement preparedStmt = conn.prepareStatement(query);
		      preparedStmt.setString (1, first_name);
		      preparedStmt.setString (2, last_name);
		      preparedStmt.setString(3, pesel);
		      preparedStmt.setString(4, password1);
		      preparedStmt.setString(5, password2);

		      // execute the preparedstatement
		      preparedStmt.execute();
		      
		      conn.close();
		    }
		    catch (Exception e)
		    {
		      System.err.println("Got an exception!");
		      System.err.println(e.getMessage());
		    }
			request.setAttribute("action", "success");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=6").forward(request, response);
		}
	}
}
