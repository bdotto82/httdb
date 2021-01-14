<%@page import="org.unipampa.cadastro.Organism"%>
<%@page import="org.unipampa.db.conector.OrganismCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	OrganismCon forg = new OrganismCon();

	Set set = forg.listar();
	
	Iterator it = set.iterator();

	int idgrupo = 0;
	
	while (it.hasNext()){
		Organism org = (Organism)it.next();

		//If group changed, and is not the first, close optgroup
		if (org.getIdorganismlevel() != idgrupo && idgrupo !=0)
			out.print("</optgroup>");
		
		//If group changed, set new optgroup 
		if (org.getIdorganismlevel() != idgrupo)
			out.print("<optgroup label='".concat(org.getNmorganismlevel()).concat("'>"));
		
		out.print("<option value='");
		out.print(Integer.toString(org.getIdorganism()));
		out.print("|");
		out.print(Integer.toString(org.getIdorganismlevel()));
		out.print("|");
		out.print(org.getDsorganismtaxonomy());
		
		out.print("'>");
//		out.print(org.getNmorganismlevel());
//		out.print(": ");
		out.print("&emsp;".concat(org.getNmorganism()));
		out.println("</option>");

		//If is the last, close optgroup
		if (!it.hasNext())
			out.print("</optgroup>");

		idgrupo = org.getIdorganismlevel();
	}

%>