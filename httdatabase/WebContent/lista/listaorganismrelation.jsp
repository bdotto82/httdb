<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.unipampa.cadastro.OrganismRelation"%>
<%@page import="org.unipampa.db.conector.OrganismRelationCon"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%

	OrganismRelationCon orgcon = new OrganismRelationCon();

	Set set = orgcon.listar();
	
	Iterator it = set.iterator();
	
	JSONArray jar = new JSONArray();
	
	while (it.hasNext()){
		OrganismRelation org = (OrganismRelation)it.next();
		
// 		out.print("<option value=");
// 		out.print(Integer.toString(org.getIdorganismrelation()));
		
// 		out.print(">");
// 		out.print(org.getDsorganismrelation());
// 		out.println("</option>");
		
		JSONObject jobj = new JSONObject();
		jobj.put("id_organism_relation", Integer.toString(org.getIdorganismrelation()));
		jobj.put("ds_organism_relation", org.getDsorganismrelation());
		
		jar.add(jobj);
		
	}

	out.print(jar.toJSONString());


%>