<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
<%@page import="org.dotto.util.Util"%>
<%@page import="org.unipampa.cadastro.ParameterScript"%>
<%@page import="org.unipampa.db.conector.ParameterScriptCon"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%
	
	String id = "";

	if (!Util.isnullParm("id", request))
		id = request.getParameter("id");
	else
		id = request.getSession().getId();

	JSONArray jar = new JSONArray();
	
	ParameterScriptCon parcon = new ParameterScriptCon();
	ParameterScript parm = parcon.consultar(1);
	
	String tedirname = parm.getDirlocation().concat(id).concat("/TE/");

	File folder = new File(tedirname);
	File[] listOfFiles = folder.listFiles();
	Arrays.sort(listOfFiles);
	
	JSONObject jobj = new JSONObject();
	jobj.put("id_te", "ALL");
	jobj.put("nm_te", "All Transposable Elements");
	jobj.put("selected", true);
	
	jar.add(jobj);

	for (File file : listOfFiles) {
	    if (file.isFile()) {
	        
	    	String tename = file.getName();
	    	
	    	if (tename.lastIndexOf('.') > 0)
	    		tename = tename.substring(0, tename.lastIndexOf('.'));
	    	
			jobj = new JSONObject();
			jobj.put("id_te", tename);
			jobj.put("nm_te", tename);
			
			jar.add(jobj);

	    }
	}
	
	out.print(jar.toJSONString()); 

%>