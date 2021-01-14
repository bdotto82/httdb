<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="org.unipampa.db.conector.htt.ResultCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.dotto.util.Util"%>
<%@page import="java.util.ArrayList"%>

<%

if (Util.isonlynullParm("id_classe", request))
	return;

Map parm = new HashMap();

parm.put("id_classe", Util.converterSelectString(request.getParameter("id_classe").split("[,]")));
parm.put("id_superfamily", Util.converterSelectString(request.getParameter("id_superfamily").split("[,]")));
parm.put("id_family", Util.converterSelectString(request.getParameter("id_family").split("[,]")));
	
//ID Organism represent id_organism|id_level|nm_organism
parm.put("id_organism", Util.converterSelectString(request.getParameter("id_organism").split("[,]"), 3));

parm.put("id_level", Util.converterSelectString(request.getParameter("id_level").split("[,]")));
// 	parm.put("id_methods", Util.converterSelectString(request.getParameter("id_method").split("[,]")));

parm.put("id_organism_relation", Util.converterSelectString(request.getParameter("id_organism_relation").split("[,]")));

ResultCon rescon = new ResultCon();
Set set = rescon.listartabela(parm);
Iterator it = set.iterator();

JSONArray jar = new JSONArray();

long total = 0;

while (it.hasNext()){

	Map res = (HashMap)it.next();

	total = total + ((Integer)res.get("qt_events")).intValue();

	JSONObject jobj = new JSONObject();
	
	jobj.put("menuLink", "");
	jobj.put("id_result", res.get("id_result"));
	jobj.put("nm_classe", Util.format((String)res.get("nm_classe")));
	jobj.put("nm_superfamily", Util.format((String)res.get("nm_superfamily")));
	jobj.put("nm_family", Util.format((String)res.get("nm_family")));
	jobj.put("nm_organism", Util.format((String)res.get("nm_organism_level")) + ":" + Util.format((String)res.get("nm_organism")));
	jobj.put("nm_level", Util.format((String)res.get("nm_level")));
	jobj.put("dt_estimates_htt", Util.format((String)res.get("dt_estimates_htt")));
	jobj.put("ds_organism_relation", Util.format((String)res.get("ds_organism_relation")));
	jobj.put("ds_host_impact", Util.format((String)res.get("ds_host_impact")));
	jobj.put("nm_vector", Util.format((String)res.get("nm_vector")));
	jobj.put("qt_events", res.get("qt_events"));
	jobj.put("nm_methods", res.get("nm_methods"));
	jobj.put("Referencelink", Util.format((String)res.get("referenceHTML")));
	jobj.put("NCBIlink", Util.format((String)res.get("ncbiHTML")));
	jobj.put("Repbaselink", Util.format((String)res.get("repbaseHTML")));
	
	jar.add(jobj);
	

}

JSONObject jobret = new JSONObject();

jobret.put("rows", jar);
jobret.put("total", total);

JSONObject jfooter = new JSONObject();
jfooter.put("qt_events", total);
jfooter.put("nm_methods", "Total:");

JSONArray jarfooter = new JSONArray();
jarfooter.add(jfooter);

jobret.put("footer", jarfooter);

out.print(jobret.toJSONString());

%>