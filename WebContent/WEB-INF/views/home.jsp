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
<title>Home Page</title>
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
<body>
	<div id="carousel-container">
		<div class="main-content">
			
			<div class="img-div">
				<img class="carousel-img" src="${pageContext.request.contextPath}/resources/img/beep-card-cropped.jpg">
			</div>
			<div class="img-div">
				<img class="carousel-img" src="${pageContext.request.contextPath}/resources/img/beep-card-hand.jpg">
			</div>
			<div class="img-div">
				<img class="carousel-img" src="${pageContext.request.contextPath}/resources/img/maxresdefault.jpg">
			</div>
		</div>
	</div>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/slick/slick.min.js"></script>
</body>
<%@ include file="footer.jsp" %>
</html>