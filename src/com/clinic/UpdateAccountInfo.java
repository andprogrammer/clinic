package com.clinic;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateAccountInfo")
public class UpdateAccountInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String first_name=request.getParameter("first_name");
		String last_name=request.getParameter("last_name");
		String pesel=request.getParameter("pesel");
		String email=request.getParameter("email");
		String pass1=request.getParameter("password");
		
		String current_email=(String) request.getSession().getAttribute("email");
		
		if(first_name == null || first_name.length()<2) {
			request.setAttribute("action", "niepoprawnie wprowadzone imie");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=9").forward(request, response);
		} else if(last_name == null || last_name.length()<2) {
			request.setAttribute("action", "niepoprawnie wprowadzone nazwisko");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=9").forward(request, response);
		} else if(pesel == null || pesel.length()!=11) {
			request.setAttribute("action", "niepoprawnie wprowadzone numer pesel");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=9").forward(request, response);
		} else if(email == null || !GlobalFunctions.isValidEmailAddress(email)) {
			request.setAttribute("action", "niepoprawny adres email");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=9").forward(request, response);
		} else if(pass1 == null) {
			request.setAttribute("action", "niepoprawne haslo");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=9").forward(request, response);
		} else {
			if(!DatabaseService.isDatabaseConnected())
				DatabaseService.connectToDataBase();
			if(DatabaseService.isDatabaseConnected()) {
				try {
					String query = "SELECT id FROM user WHERE email='"+ current_email +"'";

					ResultSet rs = DatabaseService.statementDataBase().executeQuery(query);
					rs.next();
					int id = rs.getInt("id");
					
					query = "UPDATE user SET first_name = '" + first_name + "', last_name = '" + last_name + "', pesel = '" + pesel + "', email = '" + email + "', password = '" + pass1 + "' WHERE id = '" + id + "';";					
					
					DatabaseService.statementDataBase().executeUpdate(query);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			request.setAttribute("action", "success");
			getServletContext().getRequestDispatcher("/index.jsp?subpage=9").forward(request, response);
		}
	}
}
