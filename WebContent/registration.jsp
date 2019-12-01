
<% if(request.getAttribute("action")!=null) {
		String action=(String) request.getAttribute("action");
		if(action.equals("success")) { %>
<br>
Dodano nowego uzytkownika poprawnie.
</br>
<%	} else { %>
<br>
Blad :
<%=action %></br>
<%	}
	} else { %>
<u>Rejestracja:</u>
<form action="registrationServlet" method="post">
	<fieldset>
		<br />
		<table style="text-align: right;">
			<tr style="text-align: center;">
				<td colspan=2><h3>Informacje podstawowe:</h3></td>
				<td>
			<tr>
				<td>imie:</td>
				<td><input type="text" style="width: 220px" required="required"
					name="first_name" value=""></td>
			</tr>
			<tr>
				<td>nazwisko:</td>
				<td><input type="text" style="width: 220px" required="required"
					name="last_name" value=""></td>
			</tr>
			<tr>
				<td>nr pesel:</td>
				<td><input type="text" style="width: 220px" required="required"
					maxlength=11 pattern="[0-9]{11}" name="pesel" value=""></td>
			</tr>

			<tr style="text-align: center;">
				<td colspan=2><h3>Konto:</h3></td>
				<td>
			<tr>
				<td>email:</td>
				<td><input type="text" required="required" style="width: 220px"
					name="email" value=""></td>
			</tr>
			<tr>
				<td>haslo:</td>
				<td><input type="password" required="required"
					style="width: 220px" name="password1" value="" /></td>
			</tr>
			<tr>
				<td>potwierdzenie hasla:</td>
				<td><input type="password" required="required"
					style="width: 220px" name="password2" value="" /></td>
			</tr>
		</table>
		<center>
			<input type="submit" value="Zarejetruj" />
		</center>
	</fieldset>
</form>
<% } %>
