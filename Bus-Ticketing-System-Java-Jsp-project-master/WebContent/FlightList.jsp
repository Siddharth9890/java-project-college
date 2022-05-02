<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="com.project.Helper,com.project.Flights,java.util.ArrayList,AllLayout.Flight,java.util.Iterator" %>   
<%@ include file="header.jsp" %>
<%
Flights flight = new Flights();

	if(request.getParameter("delete") != null){
		String trnId = (String) request.getParameter("delete");
		flight.Delete(trnId);
	}

	ArrayList<Flight> flightlist = new ArrayList<Flight>();
	flightlist = flight.getAll();
	Iterator flightIt = flightlist.iterator();
%>
<div class="text-right">
	<a class="btn btn-success" href="AddFlight.jsp">Create Train</a>
</div>
<br>
<div class="box successfully_purschase_ticket">
	<h2 class="box_title">All Train List</h2>
	<table class="table table-bordered">
		<tr>
			<td wide="50">Train Code</td>
			<td>Name</td>
			<td>Coach</td>
			<td>Total Seat</td>
			<td>Actions</td>
		</tr>
		<%
		while(flightIt.hasNext()){
			Flight f = (Flight) flightIt.next();
		%>
			<tr>
				<td><%= f.code %></td>
				<td><%= f.type %></td>
				<td><%= f.name %></td>
				<td><%= f.totalSeats %></td>
				<td><a href="?delete=<%= f.id %>" class="btn btn-sm btn-danger">Delete</a></td>
			</tr>
			<%
		}
		%>
		
	</table>
</div>
<%@ include file="footer.jsp" %>