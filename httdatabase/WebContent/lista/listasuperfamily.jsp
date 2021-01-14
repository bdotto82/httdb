<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.dotto.util.Util"%>
<%@page import="org.unipampa.cadastro.htt.Superfamily"%>
<%@page import="org.unipampa.db.conector.htt.SuperfamilyCon"%>
<%@page import="org.unipampa.cadastro.htt.Classe"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="org.unipampa.db.conector.htt.ClasseCon"%>
<%

	SuperfamilyCon sfcon = new SuperfamilyCon();

	String filtro = "0";
	
	if (!Util.isnullParm("id_classe", request)) filtro = (String)request.getParameter("id_classe");

	Set set = sfcon.listar(filtro);
	
	Iterator it = set.iterator();
	
	int idgrupo = 0;
	
	JSONArray jar = new JSONArray();
	
	while (it.hasNext()){
		Superfamily sf = (Superfamily)it.next();
		
// 		//If group changed, and is not the first, close optgroup
// 		if (sf.getIdclasse() != idgrupo && idgrupo !=0)
// 			out.print("</optgroup>");
		
// 		//If group changed, set new optgroup 
// 		if (sf.getIdclasse() != idgrupo)
// 			out.print("<optgroup label='".concat(sf.getNmclasse()).concat("'>"));

// 		out.print("<option value=");
// 		out.print(Integer.toString(sf.getIdsuperfamily()));
// 		out.print("|");
// 		out.print(Util.format(sf.getIdclasse()));
			
// 		out.print(">");
// 		out.print("&emsp;".concat(sf.getNmsuperfamily()));
// 		out.println("</option>");
		
// 		//If is the last, close optgroup
// 		if (!it.hasNext())
// 			out.print("</optgroup>");

// 		idgrupo = sf.getIdclasse();
		
		JSONObject jobj = new JSONObject();
		jobj.put("group", sf.getNmclasse());
		jobj.put("id_superfamily", Integer.toString(sf.getIdsuperfamily()));
		jobj.put("nm_superfamily", sf.getNmsuperfamily());
		
		jar.add(jobj);
		
	}
	
	out.print(jar.toJSONString()); 

%>