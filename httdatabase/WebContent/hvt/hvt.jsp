<%@page import="org.unipampa.cadastro.Level"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="org.unipampa.db.conector.LevelCon"%>
<%@ include file="/menu.jsp" %>

<script src="<%=request.getContextPath()%>/js/highchart/modules/exporting.js"></script>

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

// 	function menuExport(event){
// 		$('#mexport').menu('show', {left: event.pageX,top: event.pageY});
// 	}

	//Função disparada para abrir o menu dos links
	function openmenu(link){
		
		links = link.split("<BR>");
		
		for ( var i = 0; i < links.length; i++) {
			window.open(links[i], '_blank');
		}
		
	}
	//Fim - Abertura menu context

	function inicializatela(){

	}

	$(function() { 

		
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

	            var itemEl = $('#m-ref')[0];
	            if (row.Referencelink == "")
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

	            var itemEl = $('#m-ref')[0];
	            if (row.Referencelink == "")
	            	$("#refmenu").menu('disableItem', itemEl);
	            else
	            	$("#refmenu").menu('enableItem', itemEl);

	            $("#refmenu").menu('show', {
	                left:e.pageX,
	                top:e.pageY
	            });
	        }
	    });
		
 	    $('#grafico_content').highcharts({
 	        chart: {
 	        	borderWidth: 1,
 	            plotBackgroundColor: null,
 	            plotShadow: false
 	        },
 	        title: {
 	            text: 'HVT Chart Result'
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
		 
 	    $('#tabs').tabs('disableTab', 1);
		 
		$('#tabs').tabs({
			onSelect: function(title, index){
				if (index == 1){
					if ($('#stipo_grafico').val() == ''){
						$('#stipo_grafico').val('virusgroup'); 
						$('#stipo_grafico').change();
					}					
					
				}
			}
		});
 	    
 	    $('#id_virus_group').combobox({
 		    editable:false, 
 		    multiple:true, 
 		    prompt:'All',
 		    valueField:'id_virus_group',
 		    textField:'ds_virus_group', 
 		    url:'../lista/listavirusgroup.jsp',
 	        onChange: function(n, o){
 	            alterafiltro();
 	        }
 	    }); 	    

 	    $('#id_virus_type').combobox({
 		    editable:false, 
 		    multiple:true, 
 		    prompt:'All',
 		    valueField:'id_virus_type',
 		    textField:'ds_virus_type', 
 		    url:'../lista/listavirustype.jsp',
 	        onChange: function(n, o){
 	            alterafiltro();
 	        }

 	    }); 	    

 	    
 	    $('#id_virus').combotree({
 		    url:'../lista/listavirustaxonomytree.jsp',
 		    cascadeCheck: false,
 		    lines:true,
 		    prompt:'All',
 		    onLoadSuccess: function(node, data){
				var t = $('#id_virus').combotree('tree');
				t.tree('collapseAll');
			},
 	        onChange: function(n, o){
 	            alterafiltro();
 	        }

 	    });

 	    $('#id_organism').combotree({
 		    url:'../lista/listaorganismtaxonomytree.jsp',
 		    lines:true,
 		    cascadeCheck: false,
 		    prompt:'All',
 	        onChange: function(n, o){
 	            alterafiltro();
 	        }

 	    });
	    
 	    
		<%
			//Abre com as informações da tela inicial
			boolean listar = false;
			
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
	    	url: "hvt_tabela.jsp?" + 
	    		 "id_virus_group=" + $("#id_virus_group").combobox("getValues") + 
	    		 "&id_virus_type=" + $("#id_virus_type").combobox("getValues") + 
	    		 "&id_virus=" + $("#id_virus").combotree("getValues") + 
	    		 "&id_organism=" + $("#id_organism").combotree("getValues")
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
		        url:  "hvt_grafico.jsp?tipo_grafico=" + $("#stipo_grafico").find('option:selected').val() + 
		    		  "&id_virus_group=" + $("#id_virus_group").combobox("getValues") + 
		    		  "&id_virus_type=" + $("#id_virus_type").combobox("getValues") + 
		    		  "&id_virus=" + $("#id_virus").combotree("getValues") + 
		    		  "&id_organism=" + $("#id_organism").combotree("getValues"),		        		
		        data: $('#formpesq').serialize(),                   
		        cache: true, 
		        success: function(response) {
		            var obj = jQuery.parseJSON(response.trim());
			        $('#grafico_content').highcharts().series[0].setData(obj);
			        
			        if (sel.value == "virusgroup")
				        $('#grafico_content').highcharts().setTitle({ text: 'HVT Chart Result'}, { text: 'Virus Group'}, true);
			        else if (sel.value  == "virustype")	
				        $('#grafico_content').highcharts().setTitle({ text: 'HVT Chart Result'}, { text: 'Virus Type'}, true);
			        else if (sel.value == "superfamily")	
				        $('#grafico_content').highcharts().setTitle({ text: 'HVT Chart Result'}, { text: 'Super Family Column'}, true);
			        else if (sel.value == "organism")	
				        $('#grafico_content').highcharts().setTitle({ text: 'HVT Chart Result'}, { text: 'Organism Column'}, true);
			        else if (sel.value == "virus")	
				        $('#grafico_content').highcharts().setTitle({ text: 'HVT Chart Result'}, { text: 'Virus'}, true);

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

<body onload="inicializatela()">

<h3 class="titulo-borda-janela borda-janela" style="width: 800px; margin-bottom:5px;">HVT - Horizontal Virus Transfer</h3>
<div id="cabpesq" class="borda-janela" style="padding: 8px; width: 784px;" >

<fieldset style="border: 1px solid #dddddd;font-size: 11px; color: #0070A3; padding-top: 0px; ">
<legend style="font-weight: bold;">Virus Keywords:</legend>

			<label style="width: auto;">Group: </label>
			<label style="width: auto; margin-left: 215px;">Type:</label>
			<label style="width: auto; margin-left: 220px;"">Virus:</label>

			<br>
			
		    <input id="id_virus_group" name="id_virus_group" style="width: 220px;">
 	        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_virus_group').combobox('clear');" style="margin-right: 3px;"></a>
 
		    <input id="id_virus_type" name="id_virus_type" style="width: 220px; ">
 	        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_virus_type').combobox('clear');" style="margin-right: 3px;"></a>

		    <select multiple id="id_virus" name="id_virus" style="width: 220px; "></select>
 	        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_virus').combotree('clear');" style="margin-right: 3px;"></a>
	
		</fieldset>

 <fieldset style="border: 1px solid #dddddd;font-size: 11px; color: #0070A3; padding-top: 0px; margin-top:10px; margin-bottom: 10px; ">
  <legend style="font-weight: bold;">Organism Keywords:</legend>
	
				
			<label style="width: auto;">Organism:</label>
<!-- 			<label style="width: 230px;">Level:</label> -->
<!-- 			<label style="width: 382px;">Species Ecological Relationships:</label> -->

			<br>

		    <select multiple id="id_organism" name="id_organism" style="width: 220px; "></select>
 	        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" 
 	           onclick="$('#id_organism').combotree('clear');" style="margin-right: 3px;"></a>

<!-- 			<select multiple="multiple" id="id_level" name="id_level" style="width: 220px;" > -->
<!-- 			</select> -->
<!--             <button class="bclose" onclick="$('#id_level').multipleSelect('uncheckAll');alterafiltro();">Clear Filter</button> -->

<!-- 			<select multiple="multiple" id="id_organism_relation" name="id_organism_relation" style="width: 220px;" > -->
<!-- 			</select> -->
<!--             <button class="bclose" onclick="$('#id_organism_relation').multipleSelect('uncheckAll');alterafiltro();">Clear Filter</button> -->

<!-- 			<input type=hidden id="id_method" name="id_method" value="0" > -->
			
<!-- 			<br> -->

	</fieldset>

	<input type="hidden" name="tipo_grafico" id="tipo_grafico" value="">
			
	<div style="text-align: right;">
	    <a href="javascript:void(0)" id="bpesquisar" class="easyui-linkbutton" data-options="iconCls:'icon-search'" 
	       onclick="listar()" >Search</a>
	</div>

</div>

<div class="borda-janela" style="margin-top: 10px;width: 1000px;" >

	<div class="easyui-tabs" id="tabs" style="margin: 10px;height:620px;" data-options="plain: true" >
<!--      <div class="easyui-tabs" style="width:700px;height:250px"> -->
	 
	  <div title="Table" style="padding: 10px; ">
		    <table id="hvtdata" class="easyui-datagrid" style="height:560px;" data-options="striped:true,showFooter: true,remoteSort:false, toolbar:'#tb'">
		        <thead>
		            <tr>
		                <th data-options="field:'menuLink',sortable:false, styler:cellStyler">Links</th>
		                <th data-options="field:'id_hvt',sortable:true">ID</th>
		                <th data-options="field:'ds_virus_group',sortable:true">Virus Group</th>
		                <th data-options="field:'ds_virus_type',sortable:true">Virus Type</th>
		                <th data-options="field:'nm_virus',sortable:true">Virus</th>
		                <th data-options="field:'nm_organism',sortable:true">Organism</th>
		                <th data-options="field:'qt_events',sortable:true">Qt. Events</th>
		                <th data-options="field:'dt_estimates',sortable:true">HVT Dating Estimates (Mya)</th>
<!-- 		                <th data-options="field:'ds_relationship',sortable:true">Species Ecological Relationships</th> -->
		                <th data-options="field:'ds_eve',sortable:true">EVE</th>
<!-- 		                <th data-options="field:'ds_methods',sortable:true">Method</th> -->
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
			<option value="virusgroup">Virus Group</option>
			<option value="virustype">Virus Type</option>
<!-- 			<option value="relation">Species Ecological Relationships</option> -->

<!-- 			<option value="virus">Virus</option> -->

			<optgroup label="Virus">
	<!-- 			<option value="organism">Organism</option> -->
				<%
				while (it.hasNext()) {
					Level lv = (Level)it.next();
					if (lv.getIdlevel() > 4) {			%>
					<option value="virus|<%=lv.getNmlevel().toLowerCase()%>|<%=lv.getIdlevel()%>"><%=lv.getNmlevel()%></option>
				<%
					}
				}

				it = set.iterator(); 

				%>
			</optgroup>

			<optgroup label="Organism">
	<!-- 			<option value="organism">Organism</option> -->
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
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onclick="$('.datagrid-btable').tableExport({type:'excel',escape:'false',fileName:'hvtdatabase'});">Export to Excel</a>
</div>
    
<div id="refmenu" class="easyui-menu" style="width:120px;">
    <div id="m-ref" href="javascript:openmenu(link['reference'])">References</div>
<!--     <div id="m-ncbi"  href="javascript:openmenu(link['ncbi'])">NCBI</div> -->
<!--     <div id="m-repbase" href="javascript:openmenu(link['repbase'])">Repbase</div> -->
</div>    

<iframe id="txtArea1" style="display:none"></iframe>

    
</body>

</html>