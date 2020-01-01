package com.clinic;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logInServlet")
public class LogInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		
		HttpSession session = request.getSession();
		session.setAttribute("logged", "offline");
		session.setAttribute("account_type", "offline");
		session.setAttribute("email", "offline");
		
		if(GlobalFunctions.isValidEmailAddress(email) && !pass.contains(" ")) {
			
			if(!DatabaseService.isDatabaseConnected())
				DatabaseService.connectToDataBase();
			if(DatabaseService.isDatabaseConnected()) {
				ResultSet res;
				try {
					res = DatabaseService.statementDataBase().executeQuery("select * from user where email='"+email+"'");
					res.next();
		    	    
					email=res.getString("email");
					String first_name=res.getString("first_name");
					
					if(!email.equals("")) {
						String account_type=res.getString("type");
						session.setAttribute("logged", "online");
						session.setAttribute("account_type", account_type);
						session.setAttribute("email", email);
						session.setAttribute("first_name", first_name);
						session.setAttribute("user_id", res.getInt("id"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} else {
			session.setAttribute("logged", "ErrorEmailPass");
			session.setAttribute("account_type", "ErrorEmailPass");
			session.setAttribute("email", "ErrorEmailPass");
		}
		response.sendRedirect("index.jsp");
	}
}
