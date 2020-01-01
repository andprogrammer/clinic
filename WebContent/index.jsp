<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link href="style/style.css" type="text/css" rel="stylesheet" />
<title>Przychodnia</title>
</head>

<%@ page import="com.clinic.DatabaseService"%>

<body>
	<div id="container">
		<div id="header">
			<h1>
				<a href="#">Przychodnia</a>
			</h1>

			<p>
				<font color="WHITE">Zainwestuj w zdrowie</font>
			</p>

			<ul id="menu">
				<% if(session.getAttribute("logged")!=null)
	  if(session.getAttribute("logged").equals("online")) {
	 	if(session.getAttribute("account_type").equals("user")) { %>
				<li id="tab_02"><a href="index.jsp?subpage=2">Wizyty</a></li>
				<li id="tab_02"><a href="index.jsp?subpage=8">Oplaty</a></li>
				<li id="tab_03"><a href="index.jsp?subpage=9">Kokpit</a></li>
				<% 	} else if(session.getAttribute("account_type").equals("admin")) { %>
				<li id="tab_01"><a href="index.jsp?subpage=10">Uzytkownicy</a></li>
				<li id="tab_02"><a href="index.jsp?subpage=11">Edycja wizyt</a></li>
				<li id="tab_03"><a href="index.jsp?subpage=9">Kokpit</a></li>
				<%	}
	} %>
				<li id="tab_01"><a href="index.jsp?subpage=1">Start</a></li>
				<li id="tab_03"><a href="index.jsp?subpage=3">Placówki</a></li>
			</ul>

		</div>
		<div id="content">
			<div id="main_column">

				<%
	if(request.getParameter("subpage") != null) {
		String tmp = request.getParameter("subpage");
		int subpage = Integer.parseInt(tmp);
		
		switch(subpage) {
		case 1:
			%>
				<jsp:include page="start.jsp" />
				<%
		break;
		case 2:
			%>
				<jsp:include page="appointments.jsp" />
				<%
		break;
		case 3:
			%>
				<jsp:include page="institutions.jsp" />
				<%
		break;
		case 4:
			%>
				<jsp:include page="reservation.jsp" />
				<%
		break;
		case 6:
			%>
				<jsp:include page="registration.jsp" />
				<%
		break;
		case 8:
			%>
				<jsp:include page="fees.jsp" />
				<%
		break;
		case 9:	//admin and user
			%>
				<jsp:include page="cockpit.jsp" />
				<%
		break;
		default:
			%>
				<jsp:include page="start.jsp" />
				<%
		}
	} else {
		%>
				<jsp:include page="start.jsp" />
				<%
	}
	%>

			</div>
			<div id="side_panel">
				<div id="search_box">
					<div id="search_content">
						<% if(session.getAttribute("logged")==null || session.getAttribute("logged").equals("offline")) { %>
						<form action="logInServlet" method="post">
							<br> email: <input type="text" name="email" /> haslo: <input
								type="password" name="pass" /> <input type="submit"
								value="Zaloguj" /><a href="index.jsp?subpage=6">Zarejetruj
									sie</a> </br>
						</form>
						<% } else if(session.getAttribute("logged").equals("online")) { %>
						<form action="logOutServlet" method="post">
							<br>Witaj: <% if(session.getAttribute("account_type").equals("user")) { %>
								<font color='blue'>
									<% out.println(""+(String) session.getAttribute("first_name"));
									%>
							</font></br>
							<% } else if(session.getAttribute("account_type").equals("admin")) { %>
							<font color='red'>
								<% out.println(""+(String) session.getAttribute("email")); %>
							</font></br>
							<% } %>
							<br><input type="submit" value="Wyloguj" /> </br>
						</form>
						<% } else if(session.getAttribute("logged").equals("ErrorEmailPass")) {
			session.setAttribute("logged", "offline");
			session.setAttribute("account_type", "offline");
			session.setAttribute("email", "offline");
		%>
						<form action="logInServlet" method="post">
							<br>Zle haslo lub email:-(</br> <br> email: <input
								type="text" name="email" /> haslo: <input type="password"
								name="pass" /> <input type="submit" value="Zaloguj" /><a
								href="index.jsp?subpage=6">Zarejetruj sie</a> </br>
						</form>
						<% } %>
					</div>
				</div>

				<div id="archives_box">
					<div id="archives_content">
						<h4>Terminarz</h4>
						<ul>
							<li><a href="#">Marzec 2020</a></li>
							<li><a href="#">Kwiecien 2020</a></li>
							<li><a href="#">Maj 2020</a></li>
							<li><a href="#">Czerwiec 2020</a></li>
						</ul>
					</div>
					<span id="archives_footer"></span>
				</div>
			</div>
			<div class="clear"></div>

		</div>
	</div>

	<div id="footer"></div>
</body>

</html>
