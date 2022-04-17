<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="com.project.Helper" %>
<%@ page import="com.project.User" %>
<%@ include file="header.jsp" %>
<%
if(session.getAttribute("isUserLogin") != null && (boolean) session.getAttribute("isUserLogin")){
	response.sendRedirect("Dashboard.jsp");
}

User user = new User();
String message = "";
String email = null,password = null;
long userId = 0;
if(request.getParameter("submit") != null){
	email = request.getParameter("phone");
	password = request.getParameter("password");
	if(email.equals("") || password.equals("")){
		message = "email and password required!";
	}else if(email.length()<3 || password.length()<8)
	{
		message = "email length >3 and password length >8 !";
	}
	else if((userId =user.login(email,password)) >0){
		session.setAttribute("isUserLogin", true);
		user.getUser(Long.toString(userId));
		user.SetUserSession(session);
		response.sendRedirect("Dashboard.jsp");
	}else{
		message = "email id or password not found!";
		session.invalidate();
	}
	
}
%>
<div class="signpage">
	<form class="register_form form_login" action="Login.jsp" method="post">
		
		<div class="row">
			<div class="col-xs-12 col-sm-8">
			<div class="owl-carousel home_page_slider">
			  <div class="item">
			  	<div class="rs_single_slide" style="background-image:url(images/slide1.jpg)">
			  	</div>
			  </div>
			  <div  class="item">
			  	<div class="rs_single_slide" style="background-image:url(images/slide2.jpg)">
			  	</div>
			  </div>
			  <div  class="item">
			  	<div class="rs_single_slide" style="background-image:url(images/slide3.jpg)">
			  	</div>
			  </div>
			  <div  class="item">
			  	<div class="rs_single_slide" style="background-image:url(images/slide4.jpg)">
			  	</div>
			  	
			  </div>
			</div>
			</div>
			<div class="col-xs-12 col-sm-4">
				<% if(!message.equals("")){ %>
				<div class="alert alert-danger"><p><%= message %></p></div>
				<% } %>
				<div class="rs_form_box">
					<h3 class="form_section_title">
						Login
					</h3>
					<div class="input-group">
						<label>Email*</label>
						<input type="text" name="phone" class="form-controller">
					</div>
					<div class="input-group">
						<label>Password</label>
						<input type="password" name="password" class="form-controller">
					</div>
				</div>
				<div class="text-center">
					<div class="rs_btn_group">
						<button class="btn btn-default" name="submit" type="submit">Login</button>
						<a href="<%= Helper.baseUrl %>Register.jsp" class="btn btn-default">Register</a>
					</div>
				</div>
			</div>
			
		</div>
	</form>
</div>
<%@ include file="footer.jsp" %>