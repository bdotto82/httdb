<%@page import="org.dotto.util.Util"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.unipampa.cadastro.Organism"%>
<%@page import="org.unipampa.db.conector.OrganismCon"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	int nivel = 1;
	String pesq = "";

	//System.out.println(request.getParameter("id"));

	if (!Util.isnullParm("id", request)){
		nivel = Integer.parseInt(request.getParameter("id").split("[|]")[1]) + 1;
		pesq = request.getParameter("id").split("[|]")[3];
	}

	
	OrganismCon orgcon = new OrganismCon();
			
	JSONArray jar = new JSONArray();		

	orgcon.listarTaxonomyTree(nivel, pesq, jar);
	
	out.print(jar.toJSONString());	

%>