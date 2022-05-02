<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.project.Helper,com.project.User" %>
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
<%
String message = "";
if(request.getParameter("submit") != null){
	user.name = request.getParameter("name");
	user.password = request.getParameter("password");
	user.address = request.getParameter("address");
	user.role="USER";
	message = user.CheckRegisValidation();
	if(message == null){
		if(!user.email.contains("@")){
			message = "Email is invalid.";
		}else if(!request.getParameter("password_con").equals(user.password)){
			message = "Password are not same";
		}else if(user.password.length()<8)
		{
			message="Password length should be greater than 8 characters";
		}
		else if(!(user.phone.length()==10))
		{
			message="Phone number should be greater than 10";
		}
		else if(user.Update()>0){ 
			message = "Profile Updated";
		}
		}else{
			message = "User Phone or Email Exist";
		}
	
	
	
}
%>

<%@ include file="header.jsp" %>
<div class="signpage">
	<% if(!message.equals("")){ %>
	<div class="alert alert-danger"><p><%= message %></p></div>
	<% } %>
	<form class="register_form" action="<%= Helper.baseUrl %>Update.jsp" method="post">
			<h4>***You cannot change email and phone number***</h4>
        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <div class="rs_form_box">
                    <h3 class="form_section_title">
                        Update Personal Information
                    </h3>
                    <div class="input-group">
                        <label> Name*</label>
                        <input type="text" name="name" value=<%= user.name %> class="form-controller">
                    </div>
                    <div class="input-group">
                        <label>Email Address</label>
                        <input type="email" name="email" value=<%= user.email %> class="form-controller" disabled>
                    </div>

                    <div class="input-group">
                        <label>Change Password*</label>
                        <input type="password" name="password"  class="form-controller">
                    </div>

                    <div class="input-group">
                        <label>Re-Enter Changed Password*</label>
                        <input type="password" name="password_con" class="form-controller">
                    </div>

                </div>

            </div>
            <div class="col-xs-12 col-sm-6">
                <div class="rs_form_box">
                    <h3 class="form_section_title">
                        Extra information
                    </h3>
                    <div class="input-group">
                        <label>Address*</label>
                        <textarea name="address"  class="form-controller"><%= user.address %></textarea>
                    </div>
                    <div class="input-group">
                        <label>Phone Number</label>
                        <input type="text" name="phone" value=<%= user.phone %> class="form-controller" disabled>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 text-center">
                <div class="rs_btn_group">
                    <button class="btn btn-default pull-left" name="submit" type="submit">Update</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%@ include file="footer.jsp" %>	