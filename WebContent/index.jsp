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

<body>
<div id="container">
<div id="header">
  <h1><a href="#">Przychodnia</a></h1>

  <p><font color="WHITE">Zainwestuj w zdrowie</font></p>
  
  <ul id="menu">
    <li id="tab_01"><a href="index.jsp?subpage=1">Start</a></li>
    <li id="tab_02"><a href="index.jsp?subpage=2">Wizyty</a></li>
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
		case 6:
			%>
			<jsp:include page="registration.jsp" />
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
			<form action="logInServlet" method="post">
				<br>
				email: <input type="text" name="email"/>
				haslo: <input type="password" name="pass"/>
				<input type="submit" value="Zaloguj"/><a href="index.jsp?subpage=6">Zarejetruj sie</a>
				</br>
			</form>
		</div>
	</div>

    <div id="archives_box">
      <div id="archives_content">
        <h4>Terminarz</h4>
        <ul>
          <li><a href="#">Marzec 2013</a></li>
          <li><a href="#">Kwiecien 2013</a></li>
          <li><a href="#">Maj 2013</a></li>
          <li><a href="#">Czerwiec 2013</a></li>
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
