<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.unipampa.cadastro.hvt.Virus"%>
<%@page import="org.unipampa.db.conector.hvt.VirusCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	VirusCon vcon = new VirusCon();

// 	JSONArray jartax = new JSONArray();
// 	vcon.listarVirusTaxonomyJSON(1, "", jartax);
	
	Set set = vcon.listarTaxonomy(null);
	
	Iterator it = set.iterator();

	int idgrupo = 0;
	
	while (it.hasNext()){
		Virus virus = (Virus)it.next();
		
		//Dont show '-' into select
		if (virus.getNmvirus().equals("-"))
			continue;
		
		//If group changed, and is not the first, close optgroup
		if (virus.getViruslevel().getIdlevel() != idgrupo && idgrupo !=0)
			out.print("</optgroup>");
		
		//If group changed, set new optgroup 
		if (virus.getViruslevel().getIdlevel() != idgrupo)
			out.print("<optgroup label='".concat(virus.getViruslevel().getNmlevel()).concat("'>"));
		
		out.print("<option value=");
		out.print(Integer.toString(virus.getIdvirus()));
		out.print("|");
		out.print(Integer.toString(virus.getViruslevel().getIdlevel()));
		out.print("|");
		out.print(virus.getNmvirus());
		
		out.print(">");
		out.print("&emsp;".concat(virus.getNmvirus()));
		out.println("</option>");

		//If is the last, close optgroup
		if (!it.hasNext())
			out.print("</optgroup>");

		idgrupo = virus.getViruslevel().getIdlevel();
	}

%>