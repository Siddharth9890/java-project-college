<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.project.Helper,com.project.*,java.sql.ResultSet,AllLayout.*" %>
<%@ include file="header.jsp" %>
<%
session.invalidate();

	response.sendRedirect("Login.jsp");

%>