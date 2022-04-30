<%@page import="java.util.*,AllLayout.*,com.project.*,AllLayout.*" %>
<%
if(session.getAttribute("isUserLogin") == null){
	response.sendRedirect("Login.jsp");
}
ArrayList<HashMap<String,String>> trains = new ArrayList<HashMap<String,String>>();
Flights trnObj = new Flights();
String stationTo =  request.getParameter("to");
String stationFrom =  request.getParameter("from");
String sCoach = (String) request.getParameter("coach");
String journey_date = (String) request.getParameter("journey_date");

Airport stationFromObj = new Airport();
Airport stationToObj = new Airport();
if(stationTo != null || stationFrom != null){
	trains = trnObj.SearchTrainFromTo(stationFrom, stationTo,sCoach);
	Airports tempStationsObj = new Airports();
	stationFromObj = tempStationsObj.getStation(stationFrom);
	stationToObj = tempStationsObj.getStation(stationTo);
}
%>

<%@ include file="header.jsp" %>
<form class="ticket_selecting_form" action="<%= Helper.baseUrl %>FindTicket.jsp">
	<h2 class="title">  <span>Flight Route Showing For ::</span> <%= stationFrom %> to  <%= stationTo%> <span>:: Journey Date: <%= journey_date%></span>
	<table class="table rs_shadow">
					
		<tr>
			<th>Serial</th>
			<th>Flight No</th>
			<th>Flight Name</th>
			<th>Class</th>
			<th>Departure Time</th>
			<th>Remaining Seats</th>
			<th>Status</th>
			<th>Price</th>
			<th>Number Of Seat</th>
			<th>Selection</th>
		</tr>
		<% for(int i =0; i<trains.size(); i++){ 
			HashMap<String,String> tempTrain= trains.get(i);
		
		%>
		<tr>
			<td><%= i+1 %></td>
			<td><%= tempTrain.get("code") %></td>
			<td><%= tempTrain.get("name") %></td>
			<td><%= tempTrain.get("type") %></td>
			<td><%= tempTrain.get("departureTime") %></td>
			<td><%= tempTrain.get("totalSeats") %></td>
			<td><%= tempTrain.get("status") %></td>
			<td><%= tempTrain.get("price")+" INR"  %></td>
			<td>
				<select name="total_seat"  class="form-control total_seat_select">
					    <option value="1">01</option>
					    <option value="2">02</option>
					    <option value="3">03</option>
					    <option value="4">04</option>
				</select>
			</td>
			<td>
				<a href="javascript:;" class="btn btn-success rs_search_ticket" data-date="<%= journey_date %>" data-destination="<%= tempTrain.get("id") %>">Search Ticket</a>
			</td>
		</tr>
	<% } %>
	</table>
	
</form>
<div id="rs_ticket_result">

</div>
<%@ include file='footer.jsp' %>