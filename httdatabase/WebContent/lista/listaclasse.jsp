<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.unipampa.cadastro.htt.Classe"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="org.unipampa.db.conector.htt.ClasseCon"%>
<%

	ClasseCon classecon = new ClasseCon();

	JSONArray jar = new JSONArray();

	Set set = classecon.listar();
	
	Iterator it = set.iterator();
	
	while (it.hasNext()){
		Classe classe = (Classe)it.next();
		
// 		out.print("<option value=");
// 		out.print(Integer.toString(classe.getIdclasse()));
		
// 		out.print(">");
// 		out.print(classe.getNmclasse());
// 		out.println("</option>");
		
		JSONObject jobj = new JSONObject();
		jobj.put("id_classe", Integer.toString(classe.getIdclasse()));
		jobj.put("nm_classe", classe.getNmclasse());
		
		jar.add(jobj);
		
	}
	
	out.print(jar.toJSONString()); 

%>