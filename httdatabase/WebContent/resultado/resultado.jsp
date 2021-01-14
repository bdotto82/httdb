<%@page import="org.unipampa.cadastro.Level"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="org.unipampa.db.conector.LevelCon"%>
<%@ include file="/menu.jsp" %>

<script src="<%=request.getContextPath()%>/js/highchart/modules/exporting.js"></script>

<script src="<%=request.getContextPath()%>/jquery/contextmenu/jquery.ui.position.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/jquery/contextmenu/jquery.contextMenu.js" type="text/javascript"></script>
<link href="<%=request.getContextPath()%>/jquery/contextmenu/jquery.contextMenu.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="<%=request.getContextPath()%>/js/excelexport/tableExport.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/excelexport/jquery.base64.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/excelexport/html2canvas.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/excelexport/jspdf/libs/sprintf.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/excelexport/jspdf/jspdf.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/excelexport/jspdf/libs/base64.js"></script>

<script>

var Disabled = {};
var link = {};
var limpo = true;
var cliqueX;
var cliqueY;


	//Função disparada para abrir o menu dos links
	function openmenu(link){
		
		links = link.split("<BR>");
		
		for ( var i = 0; i < links.length; i++) {
			window.open(links[i], '_blank');
		}
		
	}
	//Fim - Abertura menu context
	
	$(function() { 

		$('#tabs').tabs('disableTab', 1);
		
		$('#tabs').tabs({
			onSelect: function(title, index){
				if (index == 1){
					if ($('#stipo_grafico').val() == ''){
						$('#stipo_grafico').val('classe'); 
						$('#stipo_grafico').change();
					}					
					
				}
			}
		});
		
		//Pega as coordenadas do mouse - precisei fazer isso por causa do Firefox, pra abrir o menu das referências
		$('#tabs').mousedown(function(e) {
		    cliqueX = e.pageX;
		    cliqueY = e.pageY;
		})
		
		
		$('#hvtdata').datagrid({
			
			onClickCell: function(index,field,value){
				
				if (field != 'menuLink')  
					return;
				
				row = $('#hvtdata').datagrid('getRows')[index];
				
	    		link["reference"] = row.Referencelink;
	    		link["ncbi"] = row.NCBIlink;
	    		link["repbase"] = row.Repbaselink;
	            
	            var itemEl = $('#m-ref')[0];
	            if (row.Referencelink == "")
	            	$("#refmenu").menu('disableItem', itemEl);
	            else
	            	$("#refmenu").menu('enableItem', itemEl);

	            var itemEl = $('#m-ncbi')[0];
	            if (row.NCBIlink == "")
	            	$("#refmenu").menu('disableItem', itemEl);
	            else
	            	$("#refmenu").menu('enableItem', itemEl);

	            var itemEl = $('#m-repbase')[0];
	            if (row.Repbaselink == "")
	            	$("#refmenu").menu('disableItem', itemEl);
	            else
	            	$("#refmenu").menu('enableItem', itemEl);
	            
	            $("#refmenu").menu('show', {
	                left:cliqueX,
	                top:cliqueY
	            });
	        			
			},
			
			onRowContextMenu: function(e,index,row){
	            e.preventDefault();
	
	    		link["reference"] = row.Referencelink;
	    		link["ncbi"] = row.NCBIlink;
	    		link["repbase"] = row.Repbaselink;
	            
	            var itemEl = $('#m-ref')[0];
	            if (row.Referencelink == "")
	            	$("#refmenu").menu('disableItem', itemEl);
	            else
	            	$("#refmenu").menu('enableItem', itemEl);

	            var itemEl = $('#m-ncbi')[0];
	            if (row.NCBIlink == "")
	            	$("#refmenu").menu('disableItem', itemEl);
	            else
	            	$("#refmenu").menu('enableItem', itemEl);

	            var itemEl = $('#m-repbase')[0];
	            if (row.Repbaselink == "")
	            	$("#refmenu").menu('disableItem', itemEl);
	            else
	            	$("#refmenu").menu('enableItem', itemEl);
	            
	            $("#refmenu").menu('show', {
	                left:e.pageX,
	                top:e.pageY
	            });
	        },
	        
	    });
		
 	    $('#grafico_content').highcharts({
 	        chart: {
 	        	borderWidth: 1,
 	            plotBackgroundColor: null,
 	            plotShadow: false
 	        },
 	        title: {
 	            text: 'HTT Chart Result'
 	        },
 	        subtitle: {
 	            text: '-'
 	        },
 	        tooltip: {
 	            pointFormat: '<b>{point.percentage:.1f}%</b>'
 	        },
 	        plotOptions: {
 	            pie: {
 	                allowPointSelect: true,
 	                cursor: 'pointer',
 	                dataLabels: {
 	                    enabled: true,
 	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
 	                    style: {
 	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
 	                    }
 	                }
 	            }
 	        },
 	        series: [{
 	            type: 'pie',
 	            data: []
 	        }]
 	    });
		 
 	    $('#id_classe').combobox({
 		    editable:false, 
 		    multiple:true, 
 		    valueField:'id_classe',
 		    textField:'nm_classe', 
 		    prompt:'All',
            url:'../lista/listaclasse.jsp',
 	        onChange: function(n, o){
 	           alterafiltro(); 
 	           $('#id_superfamily').combobox('reload','../lista/listasuperfamily.jsp?id_classe=' + $("#id_classe").combobox("getValues"));
 	           $('#id_family').combobox('reload','../lista/listafamily.jsp?id_classe=' + $("#id_classe").combobox("getValues"));
 	        }
	    });

 	    $('#id_superfamily').combobox({
 		    editable:false, 
 		    multiple:true, 
 		    valueField:'id_superfamily',
 		    textField:'nm_superfamily',
 		    groupField:'group',
 		    prompt:'All',
 		    url:'../lista/listasuperfamily.jsp',
 	        onChange: function(n, o){
 	            alterafiltro();
  	            $('#id_family').combobox('reload','../lista/listafamily.jsp?id_classe=' + $("#id_classe").combobox("getValues") +
  	        	  	   			"&id_superfamily=" +  $("#id_superfamily").combobox("getValues"));
 	        }
	    });
 	    
 	    $('#id_family').combobox({
 		    editable:false, 
 		    multiple:true, 
 		    valueField:'id_family',
 		    textField:'nm_family', 
 		    groupField:'group',
 		    prompt:'All',
 		    url:'../lista/listafamily.jsp',
 	        onChange: function(n, o){
 	           alterafiltro();
 	        }
	    });

 	    $('#id_organism').combotree({
 		    url:'../lista/listaorganismtaxonomytree.jsp',
 		    lines:true,
 		    prompt:'All',
 		    cascadeCheck: false,
 	        onChange: function(n, o){
  	           alterafiltro();
  	        }

 	    });

 	    $('#id_level').combobox({
 		    editable:false, 
 		    multiple:true, 
 		    valueField:'id_level',
 		    textField:'nm_level', 
 		    prompt:'All',
 		    url:'../lista/listalevel.jsp',
 	        onChange: function(n, o){
 	           alterafiltro();
 	        }
	    });

 	    $('#id_organism_relation').combobox({
 		    editable:false, 
 		    multiple:true, 
 		    valueField:'id_organism_relation',
 		    textField:'ds_organism_relation', 
 		    url:'../lista/listaorganismrelation.jsp',
 		    prompt:'All',
 	        onChange: function(n, o){
 	           alterafiltro();
 	        }
	    });

 	    
		<%
		//Abre com as informações da tela inicial
		boolean listar = false;
		
		//Recebe o parametro da classe
		if (!Util.isnullParm("class", request)){
			out.println("$('#id_classe').combobox('setValue', '" + request.getParameter("class") + "');");
			listar = true;
		}

		//Recebe o parametro da superfamilia
		if (!Util.isnullParm("superfamily", request)){
			out.println	("$('#id_superfamily').combobox('setValue', '" + 
			request.getParameter("superfamily") + "');");
			listar = true;
		}

		//Recebe o parametro da familia
		if (!Util.isnullParm("family", request)){
			out.println	("$('#id_family').combobox('setValue', '" + 
			request.getParameter("family") + "');");
			listar = true;
		}

		//Recebe o parametro do organism
		if (!Util.isnullParm("organism", request)){
			out.println("$('#id_organism').combotree('setValue', {id:'" + 
							request.getParameter("organism") + "', text:'" + 
							request.getParameter("organism").split("[|]")[2] + "'});");
			listar = true;
		}

		if (listar)
			out.println("listar();");
		%> 

    });
	
	function listar(){
		
	    $('#hvtdata').datagrid( {
	    	url: "resultado_tabela.jsp?" + 
	    		 "id_classe=" + $("#id_classe").combobox("getValues") + 
	    		 "&id_superfamily=" + $("#id_superfamily").combobox("getValues") + 
	    		 "&id_family=" + $("#id_family").combobox("getValues") + 
	    		 "&id_organism=" + $("#id_organism").combotree("getValues") + 
	    		 "&id_level=" + $("#id_level").combobox("getValues") + 
	    		 "&id_organism_relation=" + $("#id_organism_relation").combobox("getValues")
	    });
	    
    	limpo = false;
		
    	$('#tabs').tabs('select', 0);
		$('#tabs').tabs('enableTab', 1);
		
	};
	
	function carregagrafico(sel){
		if (sel.value=="")
            $('#grafico_content').highcharts().series[0].setData();
        else{

 			$.ajax({
		        type: "POST",
		        url:  "resultado_grafico.jsp?" +
		    		 "id_classe=" + $("#id_classe").combobox("getValues") + 
		    		 "&id_superfamily=" + $("#id_superfamily").combobox("getValues") + 
		    		 "&id_family=" + $("#id_family").combobox("getValues") + 
		    		 "&id_organism=" + $("#id_organism").combotree("getValues") + 
		    		 "&id_level=" + $("#id_level").combobox("getValues") + 
		    		 "&id_organism_relation=" + $("#id_organism_relation").combobox("getValues") + 
		    		 "&tipo_grafico=" + sel.value,
		        cache: true,
		        success: function(response) {
		            var obj = jQuery.parseJSON(response.trim());
			        $('#grafico_content').highcharts().series[0].setData(obj);
			        
			        if (sel.value == "classe")
				        $('#grafico_content').highcharts().setTitle({ text: 'HTT Chart Result'}, { text: 'Class Column'}, true);
			        else if (sel.value  == "family")	
				        $('#grafico_content').highcharts().setTitle({ text: 'HTT Chart Result'}, { text: 'Family Column'}, true);
			        else if (sel.value == "superfamily")	
				        $('#grafico_content').highcharts().setTitle({ text: 'HTT Chart Result'}, { text: 'Super Family Column'}, true);
			        else if (sel.value == "organism")	
				        $('#grafico_content').highcharts().setTitle({ text: 'HTT Chart Result'}, { text: 'Organism Column'}, true);
			        else if (sel.value == "level")	
				        $('#grafico_content').highcharts().setTitle({ text: 'HTT Chart Result'}, { text: 'Level Column'}, true);

		        }
		    });
        }
	}

	function alterafiltro(){
        if (!limpo){
    		$('#tabs').tabs('select', 0);
    		$('#tabs').tabs('disableTab', 1);
     		document.getElementById("stipo_grafico").value="";
            $('#grafico_content').highcharts().series[0].setData();
        	$('#hvtdata').datagrid('loadData', {"total":0,"rows":[]});
        	limpo = true;
        }
	}
	
    function cellStyler(value,row,index){
        if (value != null)
           return "background: #f2f5f7 url('../images/file.png') 50% 50% no-repeat ";
        else
           return "";
    }
	
</script>

<html>

<body onload="">

<h3 class="titulo-borda-janela borda-janela" style="width: 800px; margin-bottom:5px;">HTT - Horizontal Transposable Transference</h3>
<div id="cabpesq" class="borda-janela" style="padding: 8px; width: 784px;" >

<fieldset style="border: 1px solid #dddddd;font-size: 11px; color: #0070A3; padding-top: 0px; ">
  <legend style="font-weight: bold;">TEs Keywords:</legend>

			<label>Class: </label>
			<label style="margin-left: 220px;">Super Family:</label>
			<label style="margin-left: 180px;">Family:</label>
			<br>
			
		    <select multiple id="id_classe" name="id_classe" style="width: 220px; "></select>
 	        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_classe').combobox('clear');" style="margin-right: 3px;"></a>

		    <select multiple id="id_superfamily" name="id_superfamily" style="width: 220px; "></select>
 	        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_superfamily').combobox('clear');" style="margin-right: 3px;"></a>

		    <select multiple id="id_family" name="id_family" style="width: 220px; "></select>
 	        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_family').combobox('clear');" style="margin-right: 3px;"></a>

			<br>
	
</fieldset>

 <fieldset style="border: 1px solid #dddddd;font-size: 11px; color: #0070A3; padding-top: 0px; margin-top:10px; margin-bottom: 10px; ">
  <legend style="font-weight: bold;">Host Organism Keywords:</legend>
	
				
<!-- 			<label>Organism:</label> -->
<!-- 			<label style="margin-left: 196px;">Level:</label> -->
<!-- 			<label style="margin-left: 513px;">Species Ecological Relationships:</label> -->
			<label>Organism: </label>
			<label style="margin-left: 196px;">Level:</label>
			<label style="margin-left: 220px;">Species Ecological Relationships:</label>
			<br>

		    <select multiple id="id_organism" name="id_organism" style="width: 220px; "></select>
 	        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_organism').combotree('clear');" style="margin-right: 3px;"></a>

		    <select multiple id="id_level" name="id_level" style="width: 220px; "></select>
 	        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_level').combobox('clear');" style="margin-right: 3px;"></a>

		    <select multiple id="id_organism_relation" name="id_organism_relation" style="width: 220px; "></select>
 	        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_organism_relation').combobox('clear');" style="margin-right: 3px;"></a>

</fieldset>
			
	<div style="text-align: right;">
	    <a href="javascript:void(0)" id="bpesquisar" class="easyui-linkbutton" data-options="iconCls:'icon-search'" 
	       onclick="listar()" >Search</a>
	</div>

</div>

<div class="borda-janela" style="margin-top: 10px;width: 100%;" >

	<div class="easyui-tabs" id="tabs" style="margin: 10px;height:620px;" data-options="plain: true" >
	 
	  <div title="Table" style="padding: 10px; ">

	    	<div style="text-align: left;">
	    		* Right click to open references, NCBI links and Repbase Links.
	    	</div>      

		    <table id="hvtdata" class="easyui-datagrid" style="height:550px;" data-options="striped:true,showFooter: true, remoteSort:false, toolbar:'#tb'">
		        <thead>
		                <th data-options="field:'menuLink',sortable:false, styler:cellStyler">Links</th>
		                <th data-options="field:'id_result',sortable:true">ID</th>
		                <th data-options="field:'nm_classe',sortable:true">Class</th>
		                <th data-options="field:'nm_superfamily',sortable:true">Super Family</th>
		                <th data-options="field:'nm_family',sortable:true">Family</th>
		                <th data-options="field:'nm_organism',sortable:true">Organism</th>
		                <th data-options="field:'nm_level',sortable:true">Level</th>
		                <th data-options="field:'dt_estimates_htt',sortable:true">HTT Dating Estimates (Mya)</th>
		                <th data-options="field:'ds_organism_relation',sortable:true">Species Ecological Relationships</th>
		                <th data-options="field:'ds_host_impact',sortable:true">Host Impact</th>
		                <th data-options="field:'nm_vector',sortable:true">Confirmed Vector</th>
		                <th data-options="field:'nm_methods',sortable:true">Methods</th>
		                <th data-options="field:'qt_events',sortable:true">Qt. Events</th>
		            </tr>
		        </thead>
	    	</table>  
	  </div>
	
		<% 
			LevelCon lcon = new LevelCon();
			Set set = lcon.listar();
			Iterator it = set.iterator(); 
		%>
	
	  <div  title="Chart" style="padding: 10px; text-align: center; ">
		<label style="width: auto;">Chart Column:</label><br>
		<select name="stipo_grafico" id="stipo_grafico" onchange="carregagrafico(this)"  style="width: 220px;">
			<option value=""></option>
			<option value="classe">Class</option>
			<option value="superfamily">Superfamily</option>
			<option value="family">Family</option>
			<option value="level">Level</option>
			<option value="relation">Species Ecological Relationships</option>
			<optgroup label="Organism">
				<%
				while (it.hasNext()) {
					Level lv = (Level)it.next();
					if (lv.getIdlevel() < 8) {			%>
				<option value="organism|<%=lv.getNmlevel().toLowerCase()%>|<%=lv.getIdlevel()%>"><%=lv.getNmlevel()%></option>
				<%
					}
				}
				%>
			</optgroup>
		</select>
		<br>
		<br>
		
	    <div id="grafico_content" style="height: 500px;width: 600px; margin:0 auto;">
			
		</div>
	</div>
	</div>
</div>

<div id="tb" style="padding:8px; text-align: right;">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onclick="$('.datagrid-btable').tableExport({type:'excel',escape:'false',fileName:'httdatabase'});">Export to Excel</a>
</div>

<div id="refmenu" class="easyui-menu" style="width:120px;">
    <div id="m-ref" href="javascript:openmenu(link['reference'])">References</div>
    <div id="m-ncbi"  href="javascript:openmenu(link['ncbi'])">NCBI</div>
    <div id="m-repbase" href="javascript:openmenu(link['repbase'])">Repbase</div>
</div>


<div class="context-menu-one box menu-1"></div>

<iframe id="txtArea1" style="display:none"></iframe>

</body>

</html>