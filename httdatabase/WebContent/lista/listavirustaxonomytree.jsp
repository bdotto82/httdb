<%@page import="org.dotto.util.Util"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.unipampa.cadastro.hvt.Virus"%>
<%@page import="org.unipampa.db.conector.hvt.VirusCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	String filtrotype = "0";
	
	if (!Util.isnullParm("id_virus_type", request)) filtrotype = (String)request.getParameter("id_virus_type");
	
	String[] afiltrotype = filtrotype.split("[,]");
	filtrotype = Util.converterSelectString(afiltrotype);

	VirusCon vcon = new VirusCon();

	JSONArray jar = new JSONArray();		
	
	vcon.listarVirusTaxonomyJSON(1, "", jar, filtrotype);
	
	out.print(jar.toJSONString());
	
	
%>