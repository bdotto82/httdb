	function incluirorganism(){
		document.forms["form-organism"]["acao"].value='I';
		document.forms["form-organism"]["nm_organism"].value='';
		document.forms["form-organism"]["id_organism"].value='';
		document.forms["form-organism"]["id_organism_level"].value='1';
		document.forms["form-organism"]["ds_organism_taxonomy"].value='';
		
		$('#dialog-inclui-organism').dialog('open');
	}

	function editarorganism(){
		if (validaredicaoselect('id_organism_form_result', 'organism') == -1) return;
	
		document.forms["form-organism"]["acao"].value='A';
		document.forms["form-organism"]["nm_organism"].value=$('#id_organism_form_result').multipleSelect('getSelects', 'text');

		var name = String($('#id_organism_form_result').multipleSelect('getSelects', 'text'));
		var namearr = name.split(":");
		document.forms["form-organism"]["nm_organism"].value=$.trim(namearr[1].replace(/\]/g,"")   );
		
		var ids = String($('#id_organism_form_result').multipleSelect('getSelects'));
		var idarr = ids.split("|");
		
		document.forms["form-organism"]["id_organism"].value=idarr[0];
		document.forms["form-organism"]["id_organism_level"].value=idarr[1];
		document.forms["form-organism"]["ds_organism_taxonomy"].value=idarr[2];
		
		$('#dialog-inclui-organism').dialog('open');
	}

	function excluirorganism(){
		if (validaredicaoselect('id_organism', 'organism') == -1) return;
	
		document.forms["form-organism"]["acao"].value='E';
		document.forms["form-organism"]["id_organism"].value=$('#id_organism').multipleSelect('getSelects');
		
 		document.getElementById("msg-confirm-alert").innerHTML = "Confirm organism delete?";
 		
 		$("#dialog-confirm").dialog('option', 'buttons', {
 	        "Yes": function() {
 	        	$( "#dialog-confirm" ).dialog( "close" );
 	        	salvarorganism();
 	        },
 	        "No": function() {
 		        $( "#dialog-confirm" ).dialog( "close" );
 		    }
 	      });

 		$( "#dialog-confirm").dialog( "open" );

	}

	function salvarorganism(){
		$.ajax({
	        type: "POST",
	        url:  document.getElementById("context_path").value + "/salvaorganism",
	        data: $('#form-organism').serialize(),                   
	        cache: false,
	        success: function(response) {
	        	var ret = response.split("|");
	            msg = ret[1];
	            document.getElementById("msg-dialog-alert").innerHTML = msg;
	            
	            if (document.forms["form-organism"]["acao"].value != 'E' || ret[0] != 0){
	            		$( "#dialog-alert" ).dialog("open");
	           	}
				
	            if (ret[0] == 0){
	            	 $( "#dialog-inclui-organism" ).dialog("close");
		    	     carregaselect("organism", 'id_organism_form_result', 1, 1);
		    	     carregaselect("organismtaxonomy", 'id_organism', 1, 1);
	            }
	        }
	    });		
		
	}
	