<h2>Zarezerwuj wizyte lub badanie</h2>


<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>

<%@ page import="com.clinic.DatabaseService"%>

<form action="index.jsp?subpage=4" method="post">
	<fieldset>
		<table>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td>Usluga:</td>
				<td>Zakres termin�w:</td>
			</tr>
			
			<tr>
				<td>
					<select name="service">
						<option value="endokrynolog">endokrynolog</option>
						<option value="laryngolog">laryngolog</option>
						<option value="okulista">okulista</option>
						<option value="ortopeda">ortopeda</option>
					</select>
				</td>
				<td>
					<select name="date">
						<option value="3">3 dni</option>
						<option value="14">14 dni</option>
						<option value="30">30 dni</option>
					</select>
				</td>
			</tr>
		</table>
		<br />
		<input type="submit" value="Szukaj" />
	</fieldset>
</form>

<%
String service_request = request.getParameter("service");

if(service_request != null) {
%>
	<table border="1">
	<tr>
		<th>Usluga</th>
		<th>Lekarz</th>
		<th>Termin</th>
		<th>Cena</th>
		<th>Rezerwuj</th>
	</tr>
<%
if(!DatabaseService.isDatabaseConnected())
	DatabaseService.connectToDataBase();
if(DatabaseService.isDatabaseConnected()) {
	
	String query_date_offset = "SELECT DATE_ADD(CURDATE(), INTERVAL " + request.getParameter("date") + " DAY) AS date_offset";
	String result_query_offset = null;
    try {
        ResultSet rs = DatabaseService.statementDataBase().executeQuery(query_date_offset);
        while (rs.next()) {
        	result_query_offset=rs.getString("date_offset");
        }
    } catch (SQLException e ) {
    	e.printStackTrace();
    } finally {
        //if (stmt != null) { stmt.close(); }
    }
	
    String query = "SELECT id, name, doctor, date, price FROM clinic.service WHERE date >= CURDATE() AND date <= '" + result_query_offset + "' AND name='" + request.getParameter("service") + "'";

    try {
        ResultSet rs = DatabaseService.statementDataBase().executeQuery(query);
        while (rs.next()) {
            %>
			<tr>
				<form action="ReserveServiceServlet" method="post">
					<input type="hidden" name="service_id" value="<%=rs.getString("id")%>">
					<td><%=rs.getString("name") %></td>
					<td><%=rs.getString("doctor") %></td>
					<td><%=rs.getString("date") %></td>
					<td><%=rs.getString("price") %></td>
					<td><input type="submit" value="Rezerwuj" /></td>
				</form>
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

<%
}
%>
