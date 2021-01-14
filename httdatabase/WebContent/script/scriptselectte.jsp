<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.unipampa.cadastro.ParameterScript"%>
<%@page import="org.unipampa.db.conector.ParameterScriptCon"%>
<%@ include file="/menu.jsp" %>

<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/mask.js" charset="utf-8"></script> --%>

<script type="text/javascript" > 

var id='<%
		if (!Util.isnullParm("id", request))
			out.print(request.getParameter("id"));
	%>';

$(function() {
	
    $("#aviso").hide();  

    if (id == ""){
		window.location = "scriptform.jsp";
		return;
	}
  
    $('#id_te').combobox({
		    editable:false, 
		    multiple:false, 
		    valueField:'id_te',
		    textField:'nm_te', 
		    url:'../lista/listatevicha.jsp?id=' + id,
		    prompt:'Select a TE',
		    required:true
    });
    
    $('#adjust_method').combobox({
	    editable:false, 
	    multiple:false
	});
    
	if ($("#phylotree").val() == "N"){
		$('#skip_void').switchbutton('disable');
		$('#skip_void').switchbutton('uncheck');
	}
	
    $("#div_rate").numberbox('disable');

    $('#in_divergence').switchbutton({
        onChange: function(checked){
            
            if (!checked){
                $("#div_rate").numberbox('setValue', "");
                $("#div_rate").numberbox('disable');
            }
            else
                $("#div_rate").numberbox('enable');
            	
        }
    })

    
});

$('#form-upload').ajaxForm({	
	 beforeSend: function() {
		alert('evnviando');
	 },
	 uploadProgress: function(event, position, total, percentComplete) {
		
	 },
	 complete: function(xhr) {
		 var ret = xhr.responseText.split("|");

		 alert('terminou');
	
		 if (ret[0] == 0){
		 	window.location=ret[1];
		 }
		 else{
	 	 	document.getElementById("msgaviso").innerHTML = ret[1];
	 	    $("#aviso").show();  
		 }
		     
	 }
});  

function runscript(){
	if (!$("#form-upload").form('enableValidation').form('validate')){
		$.messager.alert('Warning','Please select required fields!','warning');
		return;
	}
	
	if ($("#div_rate").val() == "" && $('#in_divergence').prop('checked')){
		alert("Please inform divergence rate");
		return;
	}

	$("#aviso").hide();
	$("#form-upload").submit();
	
}
</script>

<body onload="inicializacontroles()">

<%
String id="";
String phylo="N";

if (!Util.isnullParm("id", request))
	id = request.getParameter("id");

ParameterScriptCon parcon = new ParameterScriptCon();
ParameterScript parm = parcon.consultar(1);


File phylofile = new File(parm.getDirlocation().concat(id).concat("/phylofile.nwk"));

if (phylofile.exists())
	phylo="Y";
else
	phylo="N";
	

%>

<h3 class="titulo-borda-janela borda-janela" style="width: 800px; margin-bottom:5px;">HTT Script Detect - VHICA</h3>
<!-- <h3 class="titulo-borda-janela borda-janela" style="width: 600px; margin-bottom:5px;">How to add data</h3> -->

<div class="borda-janela" style="padding: 20px ; width: 760px; text-align: left; margin-bottom:5px;" >
	<b>Second Page</b><br>
	&emsp;&emsp;The second page allows one to select one or all TEs, if the user submitted more than one TE. Moreover, 
	it allows one to select the statistical correction method of preference (Bonferroni or False Discovery Rate).<br>
	The VHICA package 0.2.4 compiled in the HTT-DB has some improvements compared with the original version. Now it 
	enables the software to  export the comparison in which HTTs were detected along with the dS distance, and the 
	corresponding p-value in tabular format. We also implemented an option where the user can provide the evolutionary 
	rate in million years time, if available, which will then be used to estimate the time when the detected horizontal 
	transfer events took place. It is based on the formulae:
	<br><br>	
	T = k/2r where,
	<br><br>
	T is the time since the split of two sequences, k is the dS estimate between two sequences and r is the evolutionary 
	rate by million years. 
</div>

<div class="borda-janela" style="padding: 20px;width: 760px; text-align: left;" >
	
	<form  id="form-upload" name="form-upload" action="executavicha" method="post" >

		<label>Select Transposable Element to compare:</label><br>
	    <select id="id_te" name="id_te" style="width: 220px; "></select><br><br>
	    
	    <label>Adjust Method:</label><br>
	    <select id="adjust_method" name="adjust_method" style="width: 220px; ">
	    	<option value="bonferroni" selected>Bonferroni</option>
	    	<option value="fdr">FDR</option>
	    </select><br><br>

	    <label>Do you have any divergence rate estimate?</label><br>
		<input id="in_divergence" name="in_divergence" class="easyui-switchbutton" data-options="onText:'Yes',offText:'No'"> 
		<input class="easyui-numberbox" precision="15" id="div_rate" style="width: 150px;" name="div_rate"> 
	    <br><br>

		<input type="text" name="phylotree" id="phylotree" value="<%=phylo%>">

<%
		if (phylo.equals("Y")){
%>
	    <label>Keep only species which presented a given TEs?</label><br>
		<input id="skip_void" name="skip_void" class="easyui-switchbutton" data-options="onText:'Yes',offText:'No'" checked> 
<% }
else{
%>
		<input id="skip_void" name="skip_void" type="hidden" value="off"> 
<%
}
%>

		<input id="id" name="id" type="hidden" value="<%=id%>">

        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="runscript()" data-options="iconCls:'icon-ok'" style="margin: 5px 2px 5px 2px; float:right;">Send</a>
		<br><br>
		
		<div id=aviso class="ui-widget" style="width: 280px; margin: 0 auto; text-align: center;">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p style=" text-align: center;"><span class="ui-icon ui-icon-alert" style="float:left;"></span>
				<strong>Alert: </strong><div id="msgaviso">Error running script</div></p>
			</div>
		</div>		
		
	</form>
	
</div>

<br><br>

</body>