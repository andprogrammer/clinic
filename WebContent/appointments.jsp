<style> td { border: 1px solid black; } </style>

<h2>Wizyty</h2>


<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>

<%@ page import="com.clinic.DatabaseService"%>

<br>
<%
if(!DatabaseService.isDatabaseConnected())
	DatabaseService.connectToDataBase();
if(DatabaseService.isDatabaseConnected()) {
	
	String action_delete=request.getParameter("action_delete");
	if(action_delete!=null && action_delete.compareTo("delete")==0) {
		String appointment_id=request.getParameter("appointment_id");
		
		try {
			String query = "DELETE FROM appointment WHERE id="+appointment_id;
			
			DatabaseService.statementDataBase().executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
	
    String query = "SELECT appointment.id, service.name, service.doctor, service.date, service.price FROM service INNER JOIN appointment ON service.id=appointment.service_id WHERE appointment.user_id=" + session.getAttribute("user_id");

%>
<table style="width: 100%">
	<tr>
		Zarejestrowane:
	</tr>
	<tr>
		<th>Usluga</th>
		<th>Lekarz</th>
		<th>Data</th>
		<th>Cena</th>
		<th>Usun</th>
	</tr>

<%
    try {
        ResultSet rs = DatabaseService.statementDataBase().executeQuery(query);
        while (rs.next()) {
%>
	<tr>
		<td><center><%=rs.getString("name") %></center></td>
		<td><center><%=rs.getString("doctor") %></center></td>
		<td><center><%=rs.getString("date") %></center></td>
		<td><center><%=rs.getString("price") %></center></td>
		<td><center><a href="index.jsp?subpage=2&action_delete=delete&appointment_id=<%=rs.getString("id") %>">Usun</a></center></td>
	</tr>
<%
        }
    } catch (SQLException e ) {
    	e.printStackTrace();
    } finally {
        //if (stmt != null) { stmt.close(); }
    }
}
%>

</table>

<br><br>
<button onclick="location.href = 'http://localhost:12456/Clinic/index.jsp?subpage=4';" id="reservation" class="float-left submit-button" >Chce umowic wizyte lub badanie</button>
