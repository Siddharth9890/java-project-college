<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*,com.project.*,AllLayout.*" %>
<%
// get the booked id and search the details of the user and journey to print in ticket format
Long id=((Long)request.getAttribute("bookedId"));
Booking b=new Booking();
b.findByBookingId(id);

User u=new User(b.userId);
Journey j =new Journey(b.destinationId);

%>
<div class="ticket_print_section">
	<div class="rs_shadow single_ticket" style="background-image: url('images/ticket_bg.jpg');">
		<div class="ticket_header">
			<h2><%= j.fromLocation %>  Airport</h2>
		</div>
		<div class="ticket_inner">
			<div class="customer_part">
				<h4>
					<strong>Name of passenger</strong>
					<%=  u.name %>
				</h4>

				<div class="ticket_col_1">
					<table>
						<tr>
							<td>
								<strong>Flight id</strong>
								<span><%=  b.flightId %></span>
								<strong>From</strong>
								<span><%=  j.fromLocation %></span>
								<strong>To</strong>
								<span><%=  j.toLocation %></span>
							</td>
							
							<td class="wd_100px text_center">
								<strong>Journey Date</strong>
								<%=  b.journeyDate %>
							</td>
							
						</tr>
					</table>
					<table>
						<tr>
							<td>
								<strong>Class</strong>
								<span><%=  b.type %></span>
							</td>
							<td  class="wd_100px text_center">
								<strong>Seat Number</strong>
								<%=  b.seatNumbers %>
							</td>
							<td  class="text_center">
								<strong>Booking date </strong>
								<%=  b.bookingDate %>
							</td>
							<td  class="wd_100px text_center">
								<strong>Price</strong>
								<%=  j.price %>
							</td>
							<td width="90"  class="text_center">
								<img class="qr_code" src="images/qr.png" alt="">
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="company_part">
				<h4>
					<strong>Name of passenger</strong>
					<%=  u.name %>
				</h4>
				<strong>Flight Id</strong>
				<span><%= b.flightId %></span>
				<strong>Journey</strong>
				<span><%=  j.fromLocation %> To <%=  j.toLocation %></span>
				<table>
					<tr>
						<td>
							<strong>Seat Number</strong>
							<%=  b.seatNumbers %>
						</td>
						<td>
							<strong>Date and Time</strong>
							<%=  b.journeyDate %>
						</td>
						
					</tr>
					<tr>
						<td>
							<strong>Price</strong>
							<%=  j.price %>
						</td>
						<td>
							<strong>Booking Date</strong>
							<%=  b.bookingDate %>
						</td>
						
						<td>
						</td>
					</tr>
				</table>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="ticet_footer">
			<span>Have a nice journey.</span>
		</div>
	</div>
</div>