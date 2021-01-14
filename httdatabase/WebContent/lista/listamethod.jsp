<%@page import="org.unipampa.cadastro.Method"%>
<%@page import="org.unipampa.db.conector.MethodCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	MethodCon metcon = new MethodCon();

	Set set = metcon.listar();
	
	Iterator it = set.iterator();
	
	while (it.hasNext()){
		Method met = (Method)it.next();
		
		out.print("<option value=");
		out.print(Integer.toString(met.getIdmethod()));
		
		out.print(">");
		out.print(met.getNmmethod());
		out.println("</option>");
		
	}

%>