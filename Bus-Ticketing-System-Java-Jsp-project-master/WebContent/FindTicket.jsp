<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*,com.project.*,AllLayout.*" %>

<%
if(session.getAttribute("isUserLogin") == null){
	response.sendRedirect("Login.jsp");
}
String totalSeat = request.getParameter("totalSeat");
	String date = request.getParameter("date");
	String destination = request.getParameter("destination");
	String actionType = request.getParameter("actionType");
	Double bankCharge = 0.0;
	String userId = (String) session.getAttribute("user_id");
	if(totalSeat != null && date != null && destination != null && actionType.equals("search")){
		Booking booking = new Booking();
		HashMap<String,String> tickDetails = booking.Find(destination, date, totalSeat);
		
		if(tickDetails.get("is_avaiable").equals("yes")){
	Double totalamount = 0.0;
	String flightId=tickDetails.get("flightId");
	String journeyId=tickDetails.get("id");
	totalamount = Double.parseDouble(tickDetails.get("price")) * Double.parseDouble(totalSeat);
	Airports tempStation = new Airports();
	Airport stationFrom = tempStation.getStation(tickDetails.get("fromLocation"));
	Airport stationTo = tempStation.getStation(tickDetails.get("toLocation"));
%>
		<div class="ticket_info">
			<h2>Ticket Details</h2>
			<table class="table">
				<tr>
					<td>
						<ul>
							<li><strong>Journey Date</strong> <span><%= " "+tickDetails.get("departureTime") %></span></li>
							<li><strong>From</strong> <span><%= tickDetails.get("fromLocation") %></span></li>
							<li><strong>From</strong> <span><%= tickDetails.get("toLocation") %></span></li>
						</ul>
					</td>
					<td>
						<ul>
							<li><strong>Flight Name</strong> <span><%= tickDetails.get("flightName") %></span></li>
							<li><strong>Class</strong> <span><%= tickDetails.get("flightType") %></span></li>
							<li><strong>Total Seats</strong> <span><%= totalSeat %></span></li>
						</ul>
					</td>
					<td>
						<ul>
							<li><strong>Price</strong> <span><%= Double.toString(totalamount) + " "+ Helper.Currency %></span></li>
							<li><strong>Bank Charge</strong> <span><%= bankCharge + " "+ Helper.Currency %></span></li>
							<li><strong>Total Amount</strong> <span><%= (totalamount+bankCharge)+ " "+ Helper.Currency %></span></li>
						</ul>
					</td>
				</tr>
			</table>
			<div class="rs_btn_sections">
				<a href="" class="btn btn-success btn_confirm_ticket" data-userId="<%= userId %>" data-journeyId="<%= journeyId %>"  data-flightId="<%= flightId %>" data-seat="<%= totalSeat %>" >Confirm/Book Now</a>
			</div>
		</div>
		<%
		} 
				
			}else{
				String tickId = "10";
				request.setAttribute("ticket_id", "10");
				String flightId = request.getParameter("flightId");
				String journeyId = request.getParameter("journeyId");
				String userId1=request.getParameter("userId");
				
				String message = "";
				boolean isError = false;
				Flights flight = new Flights();
				flight.findFlight(flightId);
				Journey journey=new Journey(journeyId);
				Booking booking = new Booking();
				
				
				try{
							
			if(!booking.IsAvailable(flight , totalSeat)){
				isError = true;
				message = "Seat Is not Available!";
			}
				}catch(Exception e){
			e.printStackTrace();
			
				}
				if(isError){
		%>
			<div class="alert alert-default alert-danger text-center">
				<%= message %>
			</div>
			<%
		}else{
			//needed flight id ,journey id,user id ,date,totals eat
			
			 long bookedId = booking.BookNow(journey,flight,userId1, date, totalSeat);
			
			request.setAttribute("bookedId", bookedId);
		
		%>
		<div class="ticket_info">
			<h2>Congrats! Your ticket has been booked.</h2>
			<p class="text_center">Please print your ticket.</p>
		</div>
		<%@ include file="PrintTicket.jsp" %>
		<%
		}
	}
	%>