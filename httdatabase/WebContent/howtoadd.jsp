<%@ include file="/menu.jsp" %>

<style>

fieldset {
	border: 1px solid #dddddd;
	font-size: 11px; 
	color: #0070A3; 
	padding-top: 0px; 
	margin-bottom: 15px;
}

</style>

<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

<script>

window.onbeforeunload = function(){
	window.scrollTo(0,0);
}

$(function() {
	$("#dialog-send").dialog({
	    title: 'Send new data',
	    resizable: false,
	    height:130,
	    width:400,
	    modal: true,
	    closed: true
	});				 
	
	$( "#progressbar" ).progressbar({
      value: 0,
      change: function() {
    	  $( ".progress-label" ).text(Math.round( $( "#progressbar" ).progressbar( "value" ), 2) + "%" );
        },
    });
	
    $('#fastalabel').tooltip({
        position: 'right',
        content: '<div style="width: 300px; text-align:center">Sequences in fasta format should be named following RepBase (ex. Academ-12_LMi) plus (_Genus_specificname) that is, ex. Academ-12_LMi_Locusta_migratoria.</div>'
    });
	
	
});

$(function() {
	$('#form-add').ajaxForm({	
		 beforeSend: function() {

			 $('html,body').scrollTop(0);			 

			 $( "#dialog-send" ).dialog("open");
			 
			 $( ".progress-label" ).text("Saving...");
		 	 document.getElementById("msgconf").innerHTML = "Sending...";
		 },
			uploadProgress: function(event, position, total, percentComplete) {
				
				$( "#progressbar" ).progressbar({
				      value: percentComplete * .9
				    });

			},
		 complete: function(xhr) {
			 var ret = xhr.responseText.split("|");

			 $( "#progressbar" ).progressbar({value: 100});
		 	 document.getElementById("msgconf").innerHTML = ret[1];
		 }
	});  
});  

function validateform(){

	var field = ["#nm_author", "#email_author"];
	var name = ["Author Name", "Author Email"];
	
	for (i=0; i<field.length;i++){
	
		if ($.trim($(field[i]).val()) == ""){
			alert("Please inform " + name[i] + "!");
			$(field[i]).focus();
			return;
		}
	}
	
	if ($.trim($("#link_article").val()) == "" && $.trim($("#file_paper").textbox('getValue')) == "") {
		alert("Please inform Article Link or Article File!");
		return;
	}

	
	if ($.trim($("#file_table").textbox('getValue')) == "") {

		var field = ["#nm_class", "#nm_superfamily", "#nm_organism", "#nm_level"];
		var name = ["TE Class", "TE Super Family", "Host Organism", "Host Level"];
		
		for (i=0; i<field.length;i++){
		
			if ($.trim($(field[i]).val()) == ""){
				alert("Please inform " + name[i] + " or select an HTT table data file!");
				$(field[i]).focus();
				return;
			}
		}
		
	}
	
	$('#form-add').submit();

}


</script>

<body onload="inicializacontroles()">

<!-- <h3 class="titulo-borda-janela borda-janela" style="width: 600px; margin-bottom:5px;">How to add data</h3> -->
<br>

<div class="borda-janela" style="padding: 40px;width: 520px; text-align: left;" >

	<div style="text-align: center;">Please edit the information on this page and submit to us<BR>* Required Fields</div> 
	<br>
	
	<form name="form-add" id="form-add" value='Send'  method="post" action='enviaartigo' enctype="multipart/form-data" >
	
 <fieldset>
  <legend style="font-weight: bold;">Author Fields:</legend>

		<label style="width: auto;">* Author name:</label>
		<br>
		<input type=text id="nm_author" name="nm_author" style="width: 450px;">
		<br>			

		<label style="width: auto;">* Author email:</label>
		<br>
		<input type=text id="email_author" name="email_author" style="width: 450px;">
		<br>			
</fieldset>

 <fieldset>
  <legend style="font-weight: bold;">* Article Information:</legend>

		<label style="width: auto;">Article link:</label>
		<br>
		<input type=text id="link_article" name="link_article" style="width: 450px;">
		<br>			

		<label style="width: auto;">or article file:</label>
		<br>
<!-- 		<input type=file id="file_article" name="file_article" style="width: 450px;"> -->
		<input name="file_paper"  id="file_paper" class="easyui-filebox" style="width: 100%;"></input>
		<br>			
</fieldset>

<div style="text-align: center;">
	<label style="font-weight: bold;width: auto;">OBS: You can send a table with more than one HTT event, or a individual event.</legend>
</div> 
<br>

 <fieldset>
  <legend style="font-weight: bold;">HTT Table Data (Download model <a href="modeltable.xls" target="_blank">here</a>)</legend>

		<label style="width: auto;">Table Data File:</label>
		<br>
<!-- 		<input type=file id="file_table" name="file_table" style="width: 450px;"> -->
			<input name="file_table"  id="file_table" class="easyui-filebox" style="width: 100%;"></input>
		<br>			


</fieldset>

<div style="text-align: center;">
	<label style="font-weight: bold;width: auto;">or</legend>
</div> 
<br>

 <fieldset>
  <legend style="font-weight: bold;">TE Fields: (According to Repbase - <a  href="http://www.girinst.org/repbase/" target="_blank">link</a>)</legend>

		<label style="width: auto;">* Class: (Ex.: DNA, Non-LTR, LTR)</label>
		<br>
		<input type=text id="nm_class" name="nm_class" style="width: 450px;">
		<br>			
			
		<label style="width: auto;">* Super Family: (Ex.: Helitron, Copia, Gypsy)</label>
		<br>
		<input type=text id="nm_superfamily" name="nm_superfamily" style="width: 450px;">
		<br>			

		<label style="width: auto;">Family: Ex.: (Helianu, Helibats, IS5)</label>
		<br>
		<input type=text name="nm_family" style="width: 450px;">
		<br>			
</fieldset>

 <fieldset>
  <legend style="font-weight: bold;">Host Organism Fields: (According to NCBI Taxonomy - <a  href="http://www.ncbi.nlm.nih.gov/taxonomy" target="_blank">link</a>)</legend>

		<label style="width: auto;">* Organism Taxonomic Classification: (Ex.: Eukaryota;Metazoa;Chordata;Actinopteri;)</label>
		<br>
		<input type=text id="nm_organism" name="nm_organism" style="width: 450px;">
		<br>			

		<label style="width: auto;">* Level: (Ex.: Class, Domain, Family)</label>
		<br>
		<input type=text id="nm_level" name="nm_level" style="width: 450px;">
		<br>			

		<label style="width: auto;">HTT Dating Estimates (Million Years): (Ex.: '0-3.1', '120', '300-400')</label>
		<br>
		<input type=text id="dt_estimated_htt" name="dt_estimated_htt" style="width: 450px;">
		<br>			

		<label style="width: auto;">Species Ecological Relationships: (Ex.: Host-parasite, parasitism, species distribution overposition)</label>
		<br>
		<input type=text id="ds_organism_relation" name="ds_organism_relation" style="width: 450px;">
		<br>			

</fieldset>

 <fieldset>
  <legend style="font-weight: bold;">Other Information:</legend>
		<label style="width: auto;">Method: (Ex.: ss, phyl, pd, dN/dS)</label>
		<br>
		<input type=text name="nm_method" style="width: 450px;">
		<br>			

		<label style="width: auto;" id="fastalabel">Multi fasta file with nucleotide sequences:</label>
		<br>
<!-- 		<input type=file id="file_table" name="file_table" style="width: 450px;"> -->
			<input name="file_sequence"  id="file_sequence" class="easyui-filebox" style="width: 100%;"></input>
		<br>			

		<label style="width: auto;">Obs:</label>
		<br>
		<textarea name="obs" style="width: 450px;"></textarea>
		<br>			
</fieldset>

		<div style="text-align: right;">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="validateform()" data-options="iconCls:'icon-ok'" >Send</a>
		</div>
		
	</form>
	
</div>

<div id="dialog-send">
 	<p id="msgconf" style="text-align: center;">
		Sending...
 	</p>
	<div id="progressbar" style="width:90%; margin-left: 10px;"><div class="progress-label"></div></div>
</div>

</body>
