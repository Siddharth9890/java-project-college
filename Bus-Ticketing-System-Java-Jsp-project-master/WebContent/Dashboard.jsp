<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.project.Helper,com.project.*,java.sql.ResultSet,AllLayout.*" %>
<%@ include file="header.jsp" %>
<%
String userId = null;
if(session.getAttribute("isUserLogin") == null){
	response.sendRedirect("Login.jsp");
}
if(session.getAttribute("user_id") != null){
	userId = (String) session.getAttribute("user_id");
}
User user = new User(userId);
%>
<div class="dashboard">
	<div class="box personal_info">
		<h2 class="box_title">Personal Information</h2>
		<table class="table table-bordered">
			<tr>
				<td><strong>Full Name</strong></td>
				<td><%= user.name %></td>
			</tr>
			<tr>
				<td><strong>Email Address</strong></td>
				<td><%= user.email %></td>
			</tr>
			<tr>
				<td><strong>Cell Phone Number</strong></td>
				<td><%= user.phone %></td>
			</tr>
			<tr>
				<td><strong>Address</strong></td>
				<td><%= user.address %></td>
			</tr>
		</table>
	</div>
	
	<div class="box successfully_purschase_ticket">
		<h2 class="box_title">Successful Purchase Information</h2>
		<table class="table table-bordered">
			<tr>
				<td>Train Name</td>
				<td>Coach/Class</td>
				<td>Purchase Date</td>
				<td>Journey Date</td>
				<td>Station From</td>
				<td>Station To</td>
				<td>Total Seat</td>
				<td>Option</td>
			</tr>
			<%
			Booking booking = new Booking();
			ResultSet bookedTicket = booking.FindByUser(userId);
			
			while(bookedTicket.next()){
				
				Journey journey = new Journey(bookedTicket.getString("destinationId"));
				Flights trnTemp = new Flights(journey.id);
				String stationFromTemp = journey.fromLocation;
				String stationToTemp = journey.toLocation;
				%>
				<tr>
					<td><%= trnTemp.name %></td>
					<td><%= trnTemp.type %></td>
					<td><%= bookedTicket.getString("bookingDate") %></td>
					<td><%= bookedTicket.getString("journeyDate") %></td>
					<td><%= stationFromTemp %></td>
					<td><%= stationToTemp%></td>
					<td><%= bookedTicket.getString("numberOfSeat") %></td>
					<td><a class="btn btn-success btn-sm">Cancel ticket</a></td>
					
				</tr>
				<%
			}
			%>
			
		</table>
	</div>
	
</div>
<%@ include file="footer.jsp" %>