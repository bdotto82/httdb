
<%@page import="org.unipampa.cadastro.htt.Result"%>
<%@page import="org.unipampa.db.conector.htt.ResultCon"%>
<%@page import="org.dotto.util.Util"%>
<%

boolean blog = false;
if (session.getAttribute("loguser") != null)
	blog = true;

String idclasse="-1", idsuperfamily="-1", idfamily="-1", idorganism="-1", idlevel="-1", qtevents="", reference="", sidresult="", sidmethods="";

if (!Util.isnullParm("id_result", request)){

	ResultCon rescon = new ResultCon();
	
	int idresult = Integer.parseInt(request.getParameter("id_result"));
	
	sidresult = Util.format(idresult);
	
	Result res = rescon.consultar(idresult);
	
	if (res != null){
		
		idclasse=Util.format(res.getIdclasse());

		if (!Util.format(res.getIdsuperfamily()).equals("")) 
			idsuperfamily=Util.format(res.getIdsuperfamily()).concat("|").concat(idclasse);
		
		if (!Util.format(res.getIdfamily()).equals("")) 
			idfamily=Util.format(res.getIdfamily()).concat("|").concat(idsuperfamily);

		if (!Util.format(res.getIdorganism()).equals("")) 
			idorganism=Util.format(res.getIdorganism()).concat("|").concat(Util.format(res.getIdorganismlevel()));

		if (!Util.format(res.getIdlevel()).equals("")) 
			idlevel=Util.format(res.getIdlevel());

		if (!Util.format(res.getIdmethods()).equals("")) 
			sidmethods = Util.format(res.getIdmethods());

		qtevents=Util.format(res.getQtevents());
		reference=Util.format(res.getReference());
		
	}
	
}	

%>

<fieldset>

	<form name='form-result' id='form-result'>

			<label style="width: auto;">Class: </label>
			<label style="width: 240px;">Super Family:</label>
			<label style="width: 163px;">Family:</label>
			<br>
			
			<input type=hidden name='hid_classe' value=<%=idclasse %>>
			<select multiple=multiple id="id_classe_form_result" name="id_classe" style="width: 200px;" >
			</select>
			
			<input type=hidden name='hid_superfamily' value=<%=idsuperfamily%>>
			<select id="id_superfamily_form_result" name="id_superfamily" style="width: 200px;" >
			</select>
			
			<input type=hidden name='hid_family' value=<%=idfamily %>>
			<select id="id_family_form_result" name="id_family" style="width: 200px;" >
			</select>
			<br>

			<label style="width: auto;">Organism:</label>
			<%if (blog){ %>
				(<a href=# onClick="incluirorganism();">Add</a>-<a href=# onClick="editarorganism();">Edit</a>-<a href=# onClick="excluirorganism();">Del</a>)
			<%} %>
			<label style="width: 105px;">Level:</label>
			<label style="width: 210px;">Method:</label>
			<br>

			<input type=hidden name='hid_organism' value=<%=idorganism %>>
			<select id="id_organism_form_result" name="id_organism" style="width: 200px;" >
			</select>
			<input type=hidden name='hid_level' value=<%=idlevel %>>
			<select id="id_level_form_result" name="id_level" style="width: 200px;"  value=<%=idlevel %>>
			</select>
			<input type=hidden name='hid_method' value=<%=sidmethods%>>
			<select id="id_method_form_result" multiple name="id_method" style="width: 200px;" >
			</select><br>

			<label style="width: auto;">Events:</label>
			<br>
			
			<input type="text" style="width: 196px" name="qt_events"  value=<%=qtevents %>>
			<br>
			<label style="width: auto;">Reference:</label>
			<textarea rows="5" style="width: 600px" name="reference"><%=reference %></textarea>
<%-- 			<input type="text" style="width: 400px" name="reference"  value=<%=reference %>> --%>
			
			
			<input type=hidden name='id_result' value=<%=sidresult %> >
			<input type=hidden name='acao' >
			
	</form>

</fieldset>

