<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.dotto.util.Util"%>
<%@page import="org.unipampa.cadastro.htt.Family"%>
<%@page import="org.unipampa.db.conector.htt.FamilyCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	FamilyCon fcon = new FamilyCon();

	String filtroclasse = "0", filtrosuperfamily = "0";

	if (!Util.isnullParm("id_classe", request)) filtroclasse = (String)request.getParameter("id_classe");
	if (!Util.isnullParm("id_superfamily", request)) filtrosuperfamily = (String)request.getParameter("id_superfamily");
	
	String[] afiltrosf = filtrosuperfamily.split("[,]");
	filtrosuperfamily = Util.converterSelectString(afiltrosf);
	
	Set set = fcon.listar(filtroclasse, filtrosuperfamily);
	
	Iterator it = set.iterator();

	JSONArray jar = new JSONArray();
	
	int idgrupo = 0;
	
	while (it.hasNext()){
		Family sf = (Family)it.next();
		
// 		//If group changed, and is not the first, close optgroup
// 		if (sf.getIdsuperfamily() != idgrupo && idgrupo !=0)
// 			out.print("</optgroup>");
		
// 		//If group changed, set new optgroup 
// 		if (sf.getIdsuperfamily() != idgrupo)
// 			out.print("<optgroup label='".concat(sf.getNmsuperfamily()).concat("'>"));
		
// 		out.print("<option value=");
//  		out.print(Integer.toString(sf.getIdfamily()) + "|" +
//  	              Integer.toString(sf.getIdsuperfamily()) + "|" +
//  		          Integer.toString(sf.getIdclasse()));
		
// 		out.print(">");
// 		out.print("&emsp;".concat(sf.getNmfamily()));
// 		out.println("</option>");
		
// 		//If is the last, close optgroup
// 		if (!it.hasNext())
// 			out.print("</optgroup>");

// 		idgrupo = sf.getIdsuperfamily();

		JSONObject jobj = new JSONObject();
		jobj.put("group", sf.getNmsuperfamily());
		jobj.put("id_family", Integer.toString(sf.getIdfamily()));
		jobj.put("nm_family", sf.getNmfamily());
		
		jar.add(jobj);

		
	}

	out.print(jar.toJSONString());
	
%>