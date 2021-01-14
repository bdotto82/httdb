<%@page import="org.unipampa.cadastro.ParameterScript"%>
<%@page import="org.unipampa.db.conector.ParameterScriptCon"%>
<%@page import="java.io.File"%>
<%@ include file="/menu.jsp" %>

<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

<script type="text/javascript" > 

$(function() {
    $( "#progressbar" ).progressbar({
      value: 0,
      change: function() {
    	  $( ".progress-label" ).text(Math.round( $( "#progressbar" ).progressbar( "value" ), 2) + "%" );
        },
    });
  
    $("#aviso").hide();  
  
    $("#phylofile").prop('disabled', true);
    
    $('#in_tree').switchbutton({
        onChange: function(checked){
            $("#phylofile").prop('disabled', !checked);
            
            if (!checked){
                $("#phylofile").val("");
            }
        }
    })
    
    $('#genelabel').tooltip({
        position: 'right',
        content: '<div style="width: 300px; text-align:center">Here the user can upload as many single copy ortholog gene alignment files are available for the analysed sepcies, it should be one gene per file and homolog genes needs to be codons aligned. The used can upload several genes at once.</div>'
    });
    
    $('#telabel').tooltip({
        position: 'right',
        content: '<div style="width: 300px; text-align:center">Here the user can upload as many TEs alignment files he wants to analyse, it should be one TE family per file and homolog TEs needs to be codons aligned. The used can upload several TE aligned files at once.</div>'
    });

    $('#treelabel').tooltip({
        position: 'right',
        content: '<div style="width: 300px; text-align:center">Here the user can provide a phylogenetic tree of the host specie in newick format. It is an optional file but can help the user to interpret HT events.</div>'
    });
    
        
    
});

$('#form-upload').ajaxForm({	
	 beforeSend: function() {
		 //$('#buttonrun').button("disable");
		 $( ".progress-label" ).text("Upload files...");
	 },
	 uploadProgress: function(event, position, total, percentComplete) {
		
		$( "#progressbar" ).progressbar({
		      value: Math.round(percentComplete * .99)
	    });

	 },
	 complete: function(xhr) {
		 var ret = xhr.responseText.split("|");

		 if (ret[0] == 0){
		 	window.location=ret[1];
		 }
		 else{
	 	 	document.getElementById("msgaviso").innerHTML = ret[1];
	 	    $("#aviso").show();  
		 }
		     
// 	 	 document.getElementById("msg-dialog-alert").innerHTML = ret[1];
// 	 	 $("#dialog-alert").dialog("open");
	 	 
// 	 	 $('#bsalvardialog').button("enable");		   
	 }
});  

function validate(){
	//Validate form data
	if ($("#genefiles").val() == ""){
		alert("Please inform gene codon files");
		return;
	}
	
	if ($("#tefiles").val() == ""){
		alert("Please inform TE codon files");
		return;
	}

	if ($("#phylofile").val() == "" && $('#in_tree').prop('checked')){
		alert("Please inform phylogenetic tree file");
		return;
	}

	runscript();
}

function runscript(){
    
	$("#aviso").hide();
	$("#form-upload").submit();
	
}

function setExample(){
    
	$("#inExample").val("S");
	runscript();
	
}
</script>

<body onload="inicializacontroles()">



<h3 class="titulo-borda-janela borda-janela" style="width: 800px; margin-bottom:5px;">HTT Script Detect - VHICA</h3>
<!-- <h3 class="titulo-borda-janela borda-janela" style="width: 600px; margin-bottom:5px;">How to add data</h3> -->

<div class="borda-janela" style="padding: 20px ; width: 760px; text-align: left; margin-bottom:5px;" >
		&emsp;&emsp;<a href="https://cran.r-project.org/web/packages/vhica/index.html">VHICA (Vertical and Horizontal Inheritance Consistency Analysis)</a><sup>2</sup> 
		is a versatile R package intende to detect horizontal transposon transfer events. VHICA performs a correlation analysis of 
		two metrics extracted from single copy orthologous genes and TEs of the host species. The package calculates the dS - synonymous 
		substitutions - which is a measure of the neutral evolution of coding sequences and the ENC - effective number of codons - 
		which represents the selection pressure on the dS substitution as a response to translation efficiency of each gene (Figure 1). 
		For more information on how it is calculated and the statistical tests used please see reference Wallau et al 2016.
<br><br>
		<b>First Page</b><br>
		&emsp;&emsp;VHICA starts reading two required inputs: a codon-aligned gene file and TE file. Additionally, an optional newick tree file 
		can be provided.<br>
		The codon alignment of each gene should be in one multiple fasta file where the name of such file is the the name of the 
		gene/TE and the species names are in the fasta header (ex. >dmel for Drosophila melanogaster). Before the upload, the user 
		should certificate the correctness of those names.	
</div>

<div class="borda-janela" style="padding: 20px;width: 760px; text-align: left; " >
	
<%
ParameterScriptCon parcon = new ParameterScriptCon();
ParameterScript parm = parcon.consultar(1);

String dirname = parm.getDirlocation().concat(request.getSession().getId()).concat("/");
String filename = parm.getResultfilename();
File result = new File(dirname + filename);

//Se existe já o diretório, avisa se deseja ver o resultado direto
if (result.exists()){

%>	
	<p style="text-align: center;">We just have a result to your session. If you want to access this result, <a href="scriptresult.jsp?id=<%=request.getSession().getId()%>">click here</a>.</p><br>
<%
}
%>	
	
	<form id="form-upload" name="form-upload" action="recebearquivo" enctype="multipart/form-data" method="post">
	
		<label>* Required Fields</label><br><br>
	
		<label id="genelabel">* Gene codon alignment files:</label><br>
		<input type="file" name="genefiles" id="genefiles" multiple><br><br>

		<label id="telabel">* Transposable elements codon alignment files:</label><br>
		<input type="file" name="tefiles" id="tefiles" multiple><br><br>

		<label id="treelabel">Do you have any phylogenetic tree of the analysed species in newick format?</label><br>
		<input id="in_tree" name="in_tree" class="easyui-switchbutton" data-options="onText:'Yes',offText:'No'"> 
		<input type="file" name="phylofile" id="phylofile"><br><br>

		<input type="hidden" name="inExample" id="inExample" value="N">

        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="validate()" data-options="iconCls:'icon-ok'" style="margin: 2px 2px 2px 2px; float:right;">Send</a>
		<br><br>
		
		<div id="progressbar" style="width:100%;"><div class="progress-label"></div></div>
		<br>
		
		<p style="text-align: center;">
			Click <a href="<%=request.getContextPath()%>/script/example.zip">HERE</a> to download a zip containing genes, TEs and newick tree file example. 
		</p>
		<p style="text-align: center;">
			Click <a href="#" onClick="javascript:setExample();">HERE</a> to run the example files directly, no download needed. 
		</p>
		
		<div id=aviso class="ui-widget" style="width: 280px; margin: 0 auto; text-align: center;">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p style=" text-align: center;"><span class="ui-icon ui-icon-alert" style="float:left;"></span>
				<strong>Alert: </strong><div id="msgaviso">Error running script</div></p>
			</div>
		</div>		

	</form>
	
</div>

</body>