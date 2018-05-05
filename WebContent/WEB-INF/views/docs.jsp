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
<title>Docs</title>
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

	<div id="mySidenav" class="sidenav">
	  <a href="javascript:void(0)" id="x-a" class="closebtn" onclick="closeNav()">&times;</a>
	  <a id="doc-div-link" class="border-bottom border-top super-header" >Documentation</a>
	  <a id="intro-div-link" class="border-bottom" >Introduction</a>
	  <a id="objects-div-link" class="border-bottom" >Beep Ticket Objects</a>
	  <a id="keys-div-link" class="border-bottom" >Secret ID and Passcodes</a>
	  <a id="urls-div-link" class="border-bottom" >API Request URLs</a>
	  <a id="get-all-clients-h3-link" class="border-bottom sub-menu" >Get All Clients</a>
	  <a id="add-event-h3-link" class="border-bottom sub-menu" >Adding Event</a>
	  <a id="check-card-h3-link" class="border-bottom sub-menu" >Check if Card Registered</a>
	  <a id="add-user-h3-link" class="border-bottom sub-menu" >Adding UserEvent</a>
	  <a id="get-event-h3-link" class="border-bottom sub-menu" >Get Single Event</a>
	</div>
	
	<div id="docs-main">
	  <span id="v-nav-title" onclick="openNav()" hidden="true">&#9776;</span>
	  
	  <div class="container">
	  		<div id="doc-div" class="col-xs-12">
	  			<h2>Documentation</h2>
	  			<p>This document provides some documentation for the Beep Ticket API (prototype API of the official entry of UPITDC students
	  			 in the #BeepNation contest). </p>
	  			<p>Disclaimer: All API calls return JSON format only as of the moment. </p>
	  		</div>
	  		<div id="intro-div" class="col-xs-12">
	  			<h3 class="subheader">Introduction</h3>
	  			<p>The Beep Ticket API  is meant to be used by ticketing stores in order to implement the "Pay with Beep card" functionality in their websites.
	  			This functionality will allow consumers to use their Beep cards as their ticket or gate pass in entering events via the "Beep Entrance App"
	  			which will be used by the respective event administrators to verify Beep card authenticity. Along with "Beep Payment App" (available for NFC enabled android phones only), this 
	  			API aims ultimately to provide consumers and event organizers a more convenient payment and ticketing system and to take over the paper-based ticketing system that is still
	  			currently being employed in the market today.
	  			</p>
	  		</div>
	  		<div id="objects-div" class="col-xs-12">
	  			<h3 class="subheader">Beep Ticket Objects</h3>
	  			<p><strong>Client:</strong> A person or organization using the services of this API.</p>
	  			<p><strong>Event:</strong> An event has a title, start date and end date (optional). Contains a client-specific ID 
	  				(cs_id) that is provided by the client to the system. The client must provide a unique cs_id for each of his events.</p>
	  			<p><strong>UserEvent:</strong> Contains the card serial ID of the consumer who registered for a specific event.</p>
	  		</div>
	  		<div id="keys-div" class="col-xs-12">
	  			<h3 class="subheader">Secret ID and Passcodes</h3>
	  			<p><strong>secret id:</strong> The secret ID is unique for each client and is used in some of the API calls listed below.
	  			 Located on the client's dashboard under Dev tab. Reseting the secret can be done on the same page by clicking on the button located below it.</p>
	  			<p><strong>client passcode:</strong> Used in the Beep Entrance App to query all the events of the client. Only the admin should know this passcode.</p>
	  			<p><strong>event passcode:</strong> Used in the Beep Entrance App to access a specific event. This should be the only passcode given to the entrance personnel.
	  		</div>
	  		<div id="urls-div" class="col-xs-12">
	  			<h3 class="subheader">API Request URLs</h3>
	  			<p>All calls to the API returns a response body containing <code>res</code> object. The <code>res</code> object consists of a <code>status</code> property which
	  			indicates the success or failure of a call.</p>
	  			<p>If the call is successful, the server will return along a <code>data</code> object containing relevant data that is being queried. If the call returns an error, only
	  			 the <code>res</code> object will be returned.</p>
	  			 
	  			 <p>
	  			 Reminder: 
	  			 <code>domain_name = <strong>localhost:8080/BeepTicket</strong> or <strong>beeptickets-api.herokuapp.com</strong></code>
	  			 </p>
	  			<h3 id="get-all-clients-h3">Get All Clients</h3>	  			
	  			<p><code>http://{domain_name}/api/v1/{secret_id}/events</code></p>
	  			<p>
	  				Returns a list of all events under a specific client. The event list can be access through the <code>data</code> object.
	  			</p>
	  			<p>The url <code>http://{domain_name}/api/v1/{secret_id}/events?passcode={passcode}</code> returns the same list. However,
	  			this should only be used on the entrance app by the admin for testing purposes. 
	  			</p>
	  			
	  			<h3 id="add-event-h3">Adding Events to the System</h3>	  			
	  			<p><code>http://{domain_name}/api/v1/{secret_id}/event/add</code></p>
	  			<p>
	  			This task is handled by the client's admin by sending a <code>POST</code> request to the above URL along with the <code>event</code> 
	  			object. The <code>event</code> object should have the following properties: <code>cs_id</code>, <code>title</code>, <code>img_url</code>, <code>start</code>,
	  			and <code>end</code>.
	  			</p>
	  			<p>
	  				<strong>cs_id:</strong> {String max 32 characters} Should be unique for each client. For example, the <code>id</code> used by the client for the <code>event</code> in its database.
	  			</p>
	  			<p>
	  				<strong>title:</strong> {String max 32 characters} The title that will be used in the Beep entrance app.
	  			</p>
	  			<p>
	  				<strong>img_url:</strong> {String max 256 characters} The image that will be used in the Beep entrance app.
	  			</p>
	  			<p>
	  				<strong>start:</strong> {LocalDateTime} The start date and time of the event.
	  			</p>
	  			<p>
	  				<strong>end:</strong> {LocalDateTime} The start date and time of the event.
	  			</p>
	  			
	  			
	  			<h3 id="check-card-h3">Check if Card is Registered</h3>	  			
	  			<p><code>http://{domain_name}/api/v1/event/{event_id}/{card_id}</code></p>
	  			<p>
	  			Used by the Entrance app in verifying card during entrance to the event. Along with <code>res</code> and <code>data</code>
	  			objects, a <code>valid</code> property will also be sent with two possible values, <code>true</code> or <code>false</code>, indicating if the card is 
	  			still valid for entrance. 
	  			</p>
	  			<p>
	  			If the <code>status</code> and <code>valid</code>property are <code>true</code>, then the card is registered and still valid.
	  			</p>
	  			<p>
	  			If the <code>status</code> is <code>true</code> and <code>valid</code> property is <code>false</code>, then the card is registered but has already been tapped.
	  			</p>
	  			<p>
	  			If the <code>status</code> is <code>false</code>, then the card is not registered for the event.
	  			</p>
	  			
	  			<h3 id="add-user-h3">Adding UserEvent to the System</h3>	  			
	  			<p><code>http://{domain_name}/api/v1/{admin_secret_id}/client/{client_id}/cs_id/{cs_id}/card/{card_id}/seatinfo/{seatinfo}</code></p>
	  			<p>
	  				Used by the super admin to add a <code>userEvent</code> object to the system using a <code>POST</code> request with the <code>userEvent</code>
	  				object. This service is used by the Beep Payment App.
	  			</p>
	  			
	  			<h3 id="get-event-h3">Get Single Event Details</h3>	  			
	  			<p><code>http://{domain_name}/api/v1/event?event_passcode={event_passcode}</code></p>
	  			<p>
	  				Used by the Beep Entrance App to get a specific event's details.
	  			</p>	  			
	  		</div>
	  		
	  </div>
	  
	</div>

	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/slick/slick.min.js"></script>
</body>

<%@ include file="footer.jsp" %>
</html>