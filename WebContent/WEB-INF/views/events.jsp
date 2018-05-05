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
<title>Events</title>
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
		<div id="events-div" class="container dev-container">
			<div id="event-upper-div" class="container upper-dev-container">
				<div class="col-xs-6 form-group">
				    <label for="name">Client ID</label>
				    <input type="text" class="form-control" value="${client.client_id}" name="client_id" readonly="true">
				</div>
				<div class="col-xs-6 form-group">
				    <label for="name">Enterprise Name</label>
				    <input type="text" class="form-control" value="${name}" name="name" readonly="true">
				</div>
				<div class="col-xs-10 col-centered">
					<p>Showing all created events. Get passcode for specific events below.</p>
				</div>
			
			</div>
			<div id="event-lower-div" class="container upper-dev-container">
					<div id="table-container" class="col-xs-10 form-group  col-centered">
					
						<table class="table table-striped table-hover col-sm-12 reactive-table">
							<thead>
								<tr>
									<th>Title</th>
									<th>Passcode</th>
									<th>Start DateTime</th>
									<th>End DateTime</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
								<c:when test="${not empty eventList}">
									<c:forEach var="event" items="${eventList}" >
									
										<tr>
											
											<td><a href="client/${client_id}/event/${event.event_id}">${event.title}</a></td>
											
											<td>${event.event_passcode}</td>
											<td>
												${fn:replace(event.start_datetime, 'T', ' ')}
											</td>
											<td>
												${fn:replace(event.end_datetime, 'T', ' ')}
											</td>
										</tr>
									
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td align="center" colspan="4">No events to show yet.</td>
									</tr>
								</c:otherwise>
							</c:choose>	
							</tbody>
						</table>
					</div>
				
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/slick/slick.min.js"></script>
</body>

<%@ include file="footer.jsp" %>
</html>