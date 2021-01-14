	function incluirfamily(){

	    carregaselect('classe', 'id_classe_form_family', 0, 0);
	    carregaselect('superfamily', 'id_superfamily_form_family', 0, 0);

		document.forms["form-family"]["acao"].value='I';
		document.forms["form-family"]["id_family"].value='';
		document.forms["form-family"]["nm_family"].value='';
		document.forms["form-family"]["id_superfamily"].value='';
		document.forms["form-family"]["id_classe"].value='';
		
		$('#dialog-inclui-family').dialog('open');
		
	}

	function editarfamily(){
		if (validaredicaoselect('id_family', 'family') == -1) return;
	
	    carregaselect('classe', 'id_classe_form_family', 0, 0);

		var ids = String($('#id_family').multipleSelect('getSelects'));
		var idarr = ids.split("|");

	    carregaselect('superfamily', 'id_superfamily_form_family', 0, 0, "id_classe=" + idarr[2]);

	    document.forms["form-family"]["acao"].value='A';
		document.forms["form-family"]["nm_family"].value = $('#id_family').multipleSelect('getSelects', 'text');
		document.forms["form-family"]["nm_family"].value = document.forms["form-family"]["nm_family"].value.trim();
		document.forms["form-family"]["id_family"].value = idarr[0];
		document.forms["form-family"]["id_superfamily"].value = idarr[1] + "|" + idarr[2];
		document.forms["form-family"]["id_classe"].value = idarr[2];
		
		$('#dialog-inclui-family').dialog('open');
	}

	function excluirfamily(){
		if (validaredicaoselect('id_family', 'family') == -1) return;
	
		document.forms["form-family"]["acao"].value='E';
		document.forms["form-family"]["id_family"].value = String($('#id_family').multipleSelect('getSelects')).split("|")[0];
		
 		document.getElementById("msg-confirm-alert").innerHTML = "Confirm family delete?";
 		
 		$("#dialog-confirm").dialog('option', 'buttons', {
 	        "Yes": function() {
 	        	$( "#dialog-confirm" ).dialog( "close" );
 	        	salvarfamily();
 	        },
 	        "No": function() {
 		        $( "#dialog-confirm" ).dialog( "close" );
 		    }
 	      });

 		$( "#dialog-confirm").dialog( "open" );

	}

	function salvarfamily(){
		$.ajax({
	        type: "POST",
	        url:  document.getElementById("context_path").value + "/salvafamily",
	        data: $('#form-family').serialize(),                   
	        cache: true,
	        success: function(response) {
	        	var ret = response.split("|");
	            msg = ret[1];
	            document.getElementById("msg-dialog-alert").innerHTML = msg;
	            
	            if (document.forms["form-family"]["acao"].value != 'E' || ret[0] != 0){
	            		$( "#dialog-alert" ).dialog("open");
	           	}
				
	            if (ret[0] == 0){
	            	$( "#dialog-inclui-family" ).dialog("close");
	            	carregaselect("family", 'id_family', 1, 1, "id_superfamily=" + $('#id_superfamily').multipleSelect('getSelects') );
	            }
	        }
	    });		
		
	}