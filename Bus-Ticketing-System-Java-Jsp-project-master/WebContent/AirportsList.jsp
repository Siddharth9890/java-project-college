<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="AllLayout.*,com.project.Flights,com.project.Airports,java.util.ArrayList,java.util.Iterator" %>
<%@ include file="header.jsp" %>
<%
Airports airport = new Airports();
	if(request.getParameter("createAirport") != null){
		airport.name = (String) request.getParameter("name");
		airport.contact = (String) request.getParameter("contact");
		airport.address = (String) request.getParameter("address");
		airport.Save();
	}
	
	
	ArrayList<Airport> stationList = airport.getAll();
	Iterator stationIterator = stationList.iterator();
%>

<div class="box successfully_purschase_ticket">
	
	<div class="box_title">
		<div class="row">
			<div class="col-xs-12 col-sm-4">
				Create New Airport
			</div>
			<div class="col-xs-12 col-sm-8">
				All Airport
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12 col-sm-4">
			
			<form class="register_form" action="<%=Helper.baseUrl%>AirportsList.jsp" method="post">
					<div class="rs_form_box" style="margin:15px; padding:0; border:0;">
						<div class="input-group">
							<label>Name</label>
							<input type="text" name="name" class="form-controller">
						</div>
						<div class="input-group">
							<label>Contact</label>
							<input type="text" name="contact" class="form-controller">
						</div>
						<div class="input-group">
							<label>Address</label>
							<input type="text" name="address" class="form-controller">
						</div>
						<div class="text-center">
							<div class="rs_btn_group">
								<button class="btn btn-default pull-left" name="createAirport" value="submit" type="submit">Save</button>
							</div>
						</div>
					</div>
			</form>
		</div>
		<div class="col-xs-12 col-sm-8">
			<br>
			<table class="table table-bordered">
				<tr>
					<td>Name</td>
					<td>Contact</td>
					<td>Address</td>
				</tr>
				<%
				while(stationIterator.hasNext()){
								Airport st = (Airport) stationIterator.next();
				%>
						<tr>
							<td><%= st.name %></td>
							<td><%= st.contact %></td>
							<td><%= st.address %></td>
						</tr>
						<%
					}
						
				%>
				
			</table>
		</div>
		
		
	</div>
	
</div>
<%@ include file="footer.jsp" %>