<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.unipampa.db.conector.hvt.HVTResultCon"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.dotto.util.Util"%>
<%@page import="java.util.ArrayList"%>

<%

	if (Util.isonlynullParm("id_virus_group", request))
		return;

	Map parm = new HashMap();
	
	parm.put("id_virus_group", Util.converterSelectString(request.getParameter("id_virus_group").split("[,]")));
	parm.put("id_virus_type", Util.converterSelectString(request.getParameter("id_virus_type").split("[,]")));
	
	//ID Organism represent id_organism|id_level|nm_organism
	//System.out.println("ORG: " +request.getParameter("id_organism"));
	parm.put("id_organism", Util.converterSelectString(request.getParameter("id_organism").split("[,]"), 3));

	//ID Virus represent id_virus|id_level|nm_virus
	parm.put("id_virus", Util.converterSelectString(request.getParameter("id_virus").split("[,]"), 2));

	HVTResultCon rescon = new HVTResultCon();
	Set set = rescon.listartabela(parm);
	Iterator it = set.iterator();

	long total = 0;
	
	JSONArray jar = new JSONArray();
	
	while (it.hasNext()){
	
		Map res = (HashMap)it.next();
	
		total = total + ((Integer)res.get("qt_events")).intValue();

		JSONObject jobj = new JSONObject();
		
		jobj.put("menuLink", "");
		jobj.put("ds_virus_group", Util.format((String)res.get("ds_virus_group")));
		jobj.put("id_hvt", res.get("id_hvt"));
		jobj.put("ds_virus_type", Util.format((String)res.get("ds_virus_type")));
		jobj.put("nm_virus", Util.format((String)res.get("nm_virus_level")) + ":" + Util.format((String)res.get("nm_virus")));
		jobj.put("nm_organism", Util.format((String)res.get("nm_organism_level")) + ":" + Util.format((String)res.get("nm_organism")));
		jobj.put("dt_estimates", Util.format((String)res.get("dt_estimates")));
		jobj.put("Referencelink", Util.format((String)res.get("referenceHTML")));
//		jobj.put("ds_relationship", "");
		jobj.put("ds_eve", Util.format((String)res.get("ds_eve")));
		jobj.put("ds_methods", "");
		jobj.put("qt_events", res.get("qt_events"));
		
		jar.add(jobj);
		
	}
	
	JSONObject jobret = new JSONObject();
	
	jobret.put("rows", jar);
	jobret.put("total", total);

	JSONObject jfooter = new JSONObject();
	jfooter.put("qt_events", total);
	jfooter.put("nm_organism", "Total:");
	
	JSONArray jarfooter = new JSONArray();
	jarfooter.add(jfooter);

	jobret.put("footer", jarfooter);
	
	out.print(jobret.toJSONString());
%>
