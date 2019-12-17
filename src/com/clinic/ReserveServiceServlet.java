package com.clinic;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clinic.DatabaseService;

import java.sql.*;

@WebServlet("/ReserveServiceServlet")
public class ReserveServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String service_id=request.getParameter("service_id");
		
		if(!DatabaseService.isDatabaseConnected())
			DatabaseService.connectToDataBase();
		if(DatabaseService.isDatabaseConnected()) {
			PreparedStatement preparedStmt;
			try {
				String query = "insert into appointment(user_id, service_id) values (?, ?)";
				
				preparedStmt = DatabaseService.connectionDataBase().prepareStatement(query);
				preparedStmt.setInt(1, (int) request.getSession().getAttribute("user_id"));
				preparedStmt.setInt(2, Integer.parseInt(service_id));
				
				preparedStmt.execute();
				preparedStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("action", "success");
		getServletContext().getRequestDispatcher("/index.jsp?subpage=2").forward(request, response);
	}
}
