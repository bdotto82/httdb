<%@page import="java.util.Map"%>
<%@page import="org.unipampa.db.conector.htt.ResultCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.dotto.util.Util"%>
<%@page import="java.util.ArrayList"%>
<%
	Map parm = new HashMap();
	
	parm.put("id_classe", Util.converterSelectString(request.getParameterValues("id_classe")));
	parm.put("id_superfamily", Util.converterSelectString(request.getParameterValues("id_superfamily")));
	parm.put("id_family", Util.converterSelectString(request.getParameterValues("id_family")));

	//ID Organism represent id_organism|id_level|nm_organism
	parm.put("id_organism", Util.converterSelectString(request.getParameterValues("id_organism"), 2));

	parm.put("id_level", Util.converterSelectString(request.getParameterValues("id_level")));
	parm.put("id_methods", Util.converterSelectString(request.getParameterValues("id_method")));

	parm.put("id_organism_relation", Util.converterSelectString(request.getParameterValues("id_organism_relation")));

	parm.put("tipo", (String)request.getParameter("tipo_grafico"));

	ResultCon rescon = new ResultCon();
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