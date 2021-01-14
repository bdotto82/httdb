<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.unipampa.cadastro.hvt.VirusGroup"%>
<%@page import="org.unipampa.db.conector.hvt.VirusGroupCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	VirusGroupCon vgcon = new VirusGroupCon();

	Set set = vgcon.listar();
	
	Iterator it = set.iterator();
	
	JSONArray jar = new JSONArray();
	
	while (it.hasNext()){
		VirusGroup vg = (VirusGroup)it.next();
		
// 		out.print("<option value=");
// 		out.print(Integer.toString(vg.getIdvirusgroup()));
		
// 		out.print(">");
// 		out.print(vg.getDsvirusgroup());
// 		out.println("</option>");

		JSONObject jobj = new JSONObject();
		jobj.put("id_virus_group", Integer.toString(vg.getIdvirusgroup()));
		jobj.put("ds_virus_group", vg.getDsvirusgroup());
		
		jar.add(jobj);
		
	}
	
	out.print(jar.toJSONString());

%>