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
    String query = "SELECT service.name, service.doctor, service.date FROM service INNER JOIN appointment ON service.id=appointment.service_id WHERE appointment.user_id=" + session.getAttribute("user_id");

%>
<table style="width: 100%">
	<tr>
		Zarejestrowane:
	</tr>
	<tr>
		<th>Usluga</th>
		<th>Lekarz</th>
		<th>Data</th>
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
