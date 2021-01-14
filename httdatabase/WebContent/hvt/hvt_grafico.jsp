<%@page import="org.unipampa.db.conector.hvt.HVTResultCon"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.dotto.util.Util"%>
<%@page import="java.util.ArrayList"%>
<%
	Map parm = new HashMap();
	
	parm.put("id_virus_group", Util.converterSelectString(request.getParameter("id_virus_group").split("[,]")));
	parm.put("id_virus_type", Util.converterSelectString(request.getParameter("id_virus_type").split("[,]")));
	
	//ID Organism represent id_organism|id_level|nm_organism
	parm.put("id_organism", Util.converterSelectString(request.getParameter("id_organism").split("[,]"), 2));
	
	//ID Virus represent id_virus|id_level|nm_virus
	parm.put("id_virus", Util.converterSelectString(request.getParameter("id_virus").split("[,]"), 2));
	
	//	parm.put("id_organism_relation", Util.converterSelectString(request.getParameter("id_organism_relation").split("[,]")));
	parm.put("id_organism_relation", "0");

	parm.put("tipo", (String)request.getParameter("tipo_grafico"));

	HVTResultCon rescon = new HVTResultCon();
	Set set = rescon.montargrafico(parm);
	Iterator it = set.iterator();
	
	out.print("[");
	
	while (it.hasNext()){
		Map ret = (HashMap)it.next();	
        out.print("[\"" + ret.get("name") + "(" +  ret.get("qt_events") + ")" + "\"," + ret.get("qt_events") + "]");
        if (it.hasNext())
			out.print(",");        
	}
	out.print("]");

%>