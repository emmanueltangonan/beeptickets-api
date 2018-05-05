<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


</head>
<body>
	<!--nav class="navbar navbar-default"-->
	<nav id="head" class="navbar navbar-default">
		<div class="nav-div">
		  <div id="nav-container-div" class="container-fluid">
		    <div id="logo-div" class="navbar-header">
		      <a class="navbar-brand" href="home">
				 <img id="img-logo" src="${pageContext.request.contextPath}/resources/img/beep.png" >
			  </a>
			  <a class="navbar-brand logo-text">Beep Ticket API</a>
		    </div>
		    <ul id="nav-menu-ul" class="nav navbar-nav navbar-right">
		      <li id="home" class="nav-menu-li">
		      	<a class="nav-li-elem" href="${pageContext.request.contextPath}/home">
		      		Home
		      	</a>
		      </li>
		    <c:if test="${not empty client.email}">
		      <li id="dev" class="nav-menu-li">
		      	<a class="nav-li-elem" href="${pageContext.request.contextPath}/dev">
		      		Dev
		      	</a>
		      </li>
		      <li id="events" class="nav-menu-li">
		      	<a class="nav-li-elem" href="${pageContext.request.contextPath}/events">
		      		Events
		      	</a>
		      </li>
		    </c:if>
		      <li id="docs" class="nav-menu-li">
		      	<a class="nav-li-elem" href="${pageContext.request.contextPath}/docs">
		      		Docs
		      	</a>
		      </li>
		      <c:if test="${empty client.email}">
			      <li class="nav-menu-btn">
			      	<a id="nav-btn-a" href="${pageContext.request.contextPath}/sign-in"><button class="btn btn-default navbar-btn">Sign in</button></a>
			      </li>
			      <li class="nav-menu-btn">
			      	<a id="nav-btn-b" href="${pageContext.request.contextPath}/sign-up"><button id="sign-up-btn" class="btn btn-default navbar-btn">Sign up</button></a>
			      </li>
			  </c:if>
			  <c:if test="${not empty client.email}">
			  	  <li id="email-li" class="identity-li">
			      	<a id="client-email" >
			      		${client.name}
			      	</a>
			      		
			      </li>
			  	  <li class="nav-menu-btn">
			      	<a href="${pageContext.request.contextPath}/sign-out"><button class="btn btn-danger navbar-btn">Sign Out</button></a>
			      </li>
			  </c:if>
			 
		    </ul>
		    
		  </div>
		</div>
	</nav>
	

<script src='${pageContext.request.contextPath}/resources/js/api.js'></script>
</body>
</html>