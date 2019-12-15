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
		Zarejestrowane:
	</tr>
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

<table>
	<tr>
		<td>Zapisz sie:</td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	
	<tr>
		<td>Lekarz:</td>
		<td>Dzien:</td>
		<td>Miesiac:</td>
		<td>Godzina:</td>
	</tr>
	
	<tr>
		<td>
			<select>
				<option value="">Stomatolog</option>
				<option value="">Endokrynolog</option>
				<option value="">Ginekolog</option>
				<option value="">Pediatra</option>
			</select>
		</td>		
			<td>
				<select>
				<%for(int i=1;i<32;++i) {%>
					<option value=""><%=i%></option>
				<%}%>
				</select>
			</td>
		<td>
			<select>
				<option value="">Styczen</option>
				<option value="">Luty</option>
				<option value="">Marzec</option>
				<option value="">Kwiecien</option>
				<option value="">Maj</option>
				<option value="">Czerwiec</option>
				<option value="">Lipiec</option>
				<option value="">Sierpien</option>
				<option value="">Wrzesien</option>
				<option value="">Pazdziernik</option>
				<option value="">Listopad</option>
				<option value="">Grudzien</option>
			</select>
		</td>
		
		<td>
			<select>
				<option value="">9-10</option>
				<option value="">10-11</option>
				<option value="">11-12</option>
				<option value="">12-13</option>
				<option value="">13-14</option>
				<option value="">14-15</option>
				<option value="">15-16</option>
			</select>
		</td>
	</tr>
</table>
