<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page session="false"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign-up Page</title>

<link rel='stylesheet' href='${pageContext.request.contextPath}/resources/css/bootstrap.min.css' />
<script src='${pageContext.request.contextPath}/resources/js/jquery.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/bootstrap.min.js'></script>

<link rel='stylesheet' href='${pageContext.request.contextPath}/resources/css/api.css' />
</head>
<%@ include file="header.jsp" %>
<body>
	<div class="sign-in-up-container">
		
		<div id="sign-up-head">
			<h3><strong>Create Account</strong></h3>
		</div>
	<form:form id="create-form" method="post" modelAttribute="client" action="${pageContext.request.contextPath}/sign-up/createAccount">
		<div class="input-group ">
		  <span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-envelope"></span></span>
		  <form:input path="email" type="email" class="form-control" placeholder="Email" aria-describedby="sizing-addon1"></form:input>
		</div>
		<div class="error-msg">
			<form:errors path="email" cssClass="error"/>
		</div>
		
		<div class="input-group ">
		  <span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-lock"></span></span>
		  <form:input path="password" type="password" class="form-control" placeholder="Password" aria-describedby="sizing-addon1"></form:input>
		</div>
		
		<div class="input-group ">
		  <span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-lock"></span></span>
		  <input name="password_confirm" type="password" class="form-control" placeholder="Confirm Password" aria-describedby="sizing-addon1">
		</div>
		<div class="error-msg">
			<form:errors path="password" cssClass="error"/>
		</div>
		
		<a id="register-btn" href="javascript:{}" onclick="document.getElementById('create-form').submit();" class="btn btn-block btn-lg btn-success">
	    	Register
	  	</a>
	  
	  </form:form>
		
		<div id="terms-of-use-link">
			<p>By clicking Register, you agree to our 
			<a href="#">Privacy Policy and Terms of Use</a>
			</p>
		</div>
		
		<div id="sign-in-link">
			<p> Already have an account?
			<a href="sign-in">Sign in</a>
			</p>
		</div>
		
	</div>
	
</body>

<%@ include file="footer.jsp" %>
</html>