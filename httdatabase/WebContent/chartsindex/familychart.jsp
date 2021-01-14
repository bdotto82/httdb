<%@page import="org.unipampa.db.conector.htt.FamilyCon"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
    FamilyCon fcon = new FamilyCon();
	String familychartdata = fcon.getGraphicData(Integer.parseInt(request.getParameter("idsuperfamily")), Integer.parseInt(request.getParameter("qttotal")));
	
	out.print(familychartdata);
%>  