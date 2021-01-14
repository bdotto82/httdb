<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.unipampa.cadastro.hvt.VirusType"%>
<%@page import="org.unipampa.db.conector.hvt.VirusTypeCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	VirusTypeCon vtcon = new VirusTypeCon();

	Set set = vtcon.listar();
	
	Iterator it = set.iterator();

	JSONArray jar = new JSONArray();

	while (it.hasNext()){
		VirusType vt = (VirusType)it.next();
		
		JSONObject jobj = new JSONObject();
		jobj.put("id_virus_type", Integer.toString(vt.getIdvirustype()));
		jobj.put("ds_virus_type", vt.getDsvirustype());
		
		jar.add(jobj);
		
	}
	
	out.print(jar.toJSONString());

%>