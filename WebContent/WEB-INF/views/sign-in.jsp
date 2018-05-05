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
<meta name="google-signin-client_id" content="239246160174-v00ck40rsicn72n9d21642v0gpdf2q0s.apps.googleusercontent.com">
<title>Sign-in Page</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-social.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" rel="stylesheet">
<link href='${pageContext.request.contextPath}/resources/css/bootstrap.min.css' rel='stylesheet' />

<link rel='stylesheet' href='${pageContext.request.contextPath}/resources/css/api.css' />
</head>
<%@ include file="header.jsp" %>
<body>
	<div class="sign-in-up-container">
	  	
		<a id="fb-a" class="btn btn-block btn-social btn-lg btn-facebook" >
	    	<span class="fa fa-facebook"></span> Sign in with Facebook
	  	</a>
  		<a id="googleSignIn" class="btn btn-block btn-social btn-lg btn-google" >
	    	<span class="fa fa-google"></span> Sign in with Google
	  	</a>
	  	
	  	<a class="btn btn-block btn-social btn-lg btn-twitter" href="twitterLogin">
	    	<span class="fa fa-twitter"></span> Sign in with Twitter
	  	</a>
	  	<h4 id="text-divider"><span  class="line-center"><strong>OR</strong></span></h4>
	  	
	  	<form:form id="sign-in-form" method="post" action="authenticate" modelAttribute="client">
		  	<div class="input-group ">
			  <span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-envelope"></span></span>
			  <form:input path="email" value="" type="text" class="form-control" placeholder="Email" aria-describedby="sizing-addon1"></form:input>
			</div>
			<div class="error-msg">
				<form:errors path="email" cssClass="error"/>
			</div>
			
			<div class="input-group ">
			  <span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-lock"></span></span>
			  <form:input path="password" value="" type="password" class="form-control" placeholder="Password" aria-describedby="sizing-addon1"></form:input>
			</div>
			<div class="error-msg">
				<form:errors path="password" cssClass="error"/>
			</div>
			
			<div id="forgot-pw-link">
				<p>
				<a href="#">Forgot password?</a>
				</p>
			</div>
			<a id="sign-in-btn" class="btn btn-block btn-lg btn-default" href="javascript:{}" onclick="document.getElementById('sign-in-form').submit();">
		    	Sign in
		  	</a>
		  	<div id="no-account-link">
				<p> No account yet?
				<a href="sign-up">Register</a>
				</p>
			</div>
	  	</form:form>
  	</div>
  	
  	
  	<script src='${pageContext.request.contextPath}/resources/js/jquery.min.js'></script>
	<script src='${pageContext.request.contextPath}/resources/js/bootstrap.min.js'></script>
	<script src="https://apis.google.com/js/platform.js?onload=onLoadGoogleCallback" async defer></script>
	<script src='${pageContext.request.contextPath}/resources/js/api.js'></script>
	
	
</body>

<%@ include file="footer.jsp" %>
</html>