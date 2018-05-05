<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page session="false"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${empty client.email}">
	<c:redirect url="/home"/>
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Developer Page</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/slick/slick-theme.css"/>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-social.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" rel="stylesheet">
<link href='${pageContext.request.contextPath}/resources/css/bootstrap.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/css/api.css' rel='stylesheet' />

<script src='${pageContext.request.contextPath}/resources/js/jquery.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/bootstrap.min.js'></script>

</head>
<%@ include file="header.jsp" %>

<body class="dev-body">
<div class="container-wrapper">
<div class="container dev-container">
<form:form action="updateClientInfo" method="post" modelAttribute="client">
	<div class="container upper-dev-container">
		<div class="col-xs-6">
			<div class="form-group"  >
			    <label >Secret ID</label>
			    <form:input type="text" class="form-control" path="secret_id" readonly="true"></form:input>
			    <a href="newSecretId">
			    	<input type="button" id="secret_id_button" class="btn btn-default btn-sm pull-right" value="Get New Secret ID">
			    </a>
			</div>
		</div>
		<div class="col-xs-6">
			<div class="form-group" >
				<label >Passcode</label>
				<form:input type="text" class="form-control" path="passcode" readonly="true"></form:input>
				<a href="newPasscode">
					<input type="button" id="passcode_button" class="btn btn-default btn-sm pull-right" value="Get New Passcode">
				</a>
			</div>
			
		</div>
	</div>	
			
		
		
	<div class="container mid-dev-container">
		<div class="col-xs-6">
			<div class="form-group">
			    <label for="name">Enterprise Name</label>
			    <form:input type="text" class="form-control" path="name" ></form:input>
			</div>
			<div class="form-group">
			    <label>User Email/Account</label>
			    <form:input type="text" class="form-control" value="${identity}" path="email" readonly="true"></form:input>
			</div>
		</div>
		<div class="col-xs-6">
			<div class="form-group">
			    <label for="domain_name">Domain Name</label>
			    <form:input type="text" class="form-control" path="domain_name" ></form:input>
			</div>
			<div class="form-group" >
			    <label>Registered since</label>
			    <form:input type="text" class="form-control" value="${reg_date}" path="reg_date" readonly="true"></form:input>
			</div>
			
			<input type="submit" id="save-button" class="btn btn-primary btn-sm pull-right" value="Save">
			<c:if test="${not empty save_success}">
				<div class="col-xs-9 alert alert-success alert-dismissable fade in">
						<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						<strong>Changes successfully saved.</strong> 
				</div>
			</c:if>
		</div>
	</div>
</form:form>
</div>
</div>

	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/slick/slick.min.js"></script>
</body>

<%@ include file="footer.jsp" %>
</html>