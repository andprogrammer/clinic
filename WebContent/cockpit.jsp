
<%
	String pesel_request=request.getParameter("pesel");
	if(pesel_request==null) %><h2>Moj kokpit:</h2>
<%
	else %><h2>Informacje:</h2>
<%
%>

<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>

<%@ page import="com.clinic.DatabaseService"%>

<%
String first_name=new String("");
String last_name=new String("");
String pesel=new String("");
String email=new String("");
String password=new String("");

if(!DatabaseService.isDatabaseConnected())
	DatabaseService.connectToDataBase();
if(DatabaseService.isDatabaseConnected()) {
	
	String query=new String("");
	
	if(pesel_request==null)
		query = "SELECT first_name, last_name, pesel, email, password FROM user WHERE email='"+ session.getAttribute("email") +"'";
	else
		query = "SELECT first_name, last_name, pesel, email, password FROM user WHERE pesel='"+ pesel_request +"'";

		try {
			ResultSet rs = DatabaseService.statementDataBase()
					.executeQuery(query);
			while (rs.next()) {
				first_name = rs.getString("first_name");
				last_name = rs.getString("last_name");
				pesel = rs.getString("pesel");
				email = rs.getString("email");
				password = rs.getString("password");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//if (stmt != null) { stmt.close(); }
		}
	}
%>

<% if(request.getAttribute("action")!=null) {
		String action=(String) request.getAttribute("action"); 
		if(action.equals("success")) { %>
<br>
Poprawnie dokonano zmian.
</br>
<%	} else { %>
<br>
Blad :
<%=action %></br>
<%	} 
	} else { %>
<form action="updateAccountInfo" method="post">
	<fieldset>
		<br />
		<table style="text-align: right;">
			<tr style="text-align: center;">
				<td colspan=2><h3>Podstawowe informacje:</h3></td>
				<td>
			<tr>
				<td>imie:</td>
				<td><input type="text" style="width: 220px" name="first_name"
					value="<%=first_name%>"></td>
			</tr>
			<tr>
				<td>nazwisko:</td>
				<td><input type="text" style="width: 220px" name="last_name"
					value="<%=last_name%>"></td>
			</tr>
			<tr>
				<td>nr pesel:</td>
				<td><input type="text" style="width: 220px" name="pesel"
					value="<%=pesel%>"></td>
			</tr>

			<tr style="text-align: center;">
				<td colspan=2><h3>Logowanie:</h3></td>
				<td>
			<tr>
				<td>email:</td>
				<td><input type="text" style="width: 220px" name="email"
					value="<%=email %>"></td>
			</tr>
			<tr>
				<td>haslo:</td>
				<td><input type="password" style="width: 220px" name="password"
					value="<%=password %>" /></td>
			</tr>
		</table>
		<center>
			<input type="submit" value="Zapisz" />
		</center>
		
		<br><br>
		<b>Potwierdzam, ze zapoznalem/am sie z Polityka prywatnosci oraz Regulaminem</b>
	</fieldset>
</form>
<% } %>
