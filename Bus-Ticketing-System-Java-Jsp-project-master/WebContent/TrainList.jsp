<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="com.project.Helper,com.project.Flights,java.util.ArrayList,AllLayout.Flight,java.util.Iterator" %>   
<%@ include file="header.jsp" %>
<%
Flights trn = new Flights();

	if(request.getParameter("delete") != null){
		String trnId = (String) request.getParameter("delete");
		trn.Delete(trnId);
	}

	ArrayList<Flight> trainlist = new ArrayList<Flight>();
	trainlist = trn.getAll();
	Iterator trnIt = trainlist.iterator();
%>
<div class="text-right">
	<a class="btn btn-success" href="Add.jsp">Create Train</a>
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
		while(trnIt.hasNext()){
			Flight trin = (Flight) trnIt.next();
		%>
			<tr>
				<td><%= trin.code %></td>
				<td><%= trin.type %></td>
				<td><%= trin.name %></td>
				<td><%= trin.totalSeats %></td>
				<td><a href="?delete=<%= trin.id %>" class="btn btn-sm btn-danger">Delete</a></td>
			</tr>
			<%
		}
		%>
		
	</table>
</div>
<%@ include file="footer.jsp" %>