<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.unipampa.cadastro.Level"%>
<%@page import="org.unipampa.db.conector.LevelCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="org.unipampa.db.conector.htt.ClasseCon"%>
<%

	LevelCon levcon = new LevelCon();

	Set set = levcon.listar();
	
	Iterator it = set.iterator();
	
	JSONArray jar = new JSONArray();
	
	while (it.hasNext()){
		Level classe = (Level)it.next();
		
// 		out.print("<option value=");
// 		out.print(Integer.toString(classe.getIdlevel()));
		
// 		out.print(">");
// 		out.print(classe.getNmlevel());
// 		out.println("</option>");
		
		JSONObject jobj = new JSONObject();
		jobj.put("id_level", Integer.toString(classe.getIdlevel()));
		jobj.put("nm_level", classe.getNmlevel());
		
		jar.add(jobj);

		
	}

	out.print(jar.toJSONString());

%>