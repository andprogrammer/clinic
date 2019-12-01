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
    String query = "SELECT name, date FROM appointment WHERE user_id=1";	// TODO user_id hardcoded temporary-only for test purposes 

%>
	<table style="width: 100%">
	<tr>
		<th>Nazwa</th>
		<th>Data</th>
	</tr>

<%
    try {
        ResultSet rs = DatabaseService.statementDataBase().executeQuery(query);
        while (rs.next()) {
%>
	<tr>
		<td><center><%=rs.getString("name") %></center></td>
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
