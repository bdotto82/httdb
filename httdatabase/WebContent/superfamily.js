	function incluirsuperfamily(){

	    carregaselect('classe', 'id_classe_form_superfamily', 0, 0);

		document.forms["form-superfamily"]["acao"].value='I';
		document.forms["form-superfamily"]["nm_superfamily"].value='';
		document.forms["form-superfamily"]["id_superfamily"].value='';
		document.forms["form-superfamily"]["id_classe"].value='';
		
		$('#dialog-inclui-superfamily').dialog('open');
		
	}

	function editarsuperfamily(){
		if (validaredicaoselect('id_superfamily', 'superfamily') == -1) return;
	
	    carregaselect('classe', 'id_classe_form_superfamily', 0, 0);

	    document.forms["form-superfamily"]["acao"].value='A';
		document.forms["form-superfamily"]["nm_superfamily"].value = $('#id_superfamily').multipleSelect('getSelects', 'text');
		document.forms["form-superfamily"]["nm_superfamily"].value = document.forms["form-superfamily"]["nm_superfamily"].value.trim();
		
		var ids = String($('#id_superfamily').multipleSelect('getSelects'));

		var idarr = ids.split("|");
		
		document.forms["form-superfamily"]["id_superfamily"].value = idarr[0];
		document.forms["form-superfamily"]["id_classe"].value = idarr[1];
		
		$('#dialog-inclui-superfamily').dialog('open');
	}

	function excluirsuperfamily(){
		if (validaredicaoselect('id_superfamily', 'superfamily') == -1) return;
	
		document.forms["form-superfamily"]["acao"].value='E';
		document.forms["form-superfamily"]["id_superfamily"].value = String($('#id_superfamily').multipleSelect('getSelects')).split("|")[0];
		
 		document.getElementById("msg-confirm-alert").innerHTML = "Confirm super family delete?";
 		
 		$("#dialog-confirm").dialog('option', 'buttons', {
 	        "Yes": function() {
 	        	$( "#dialog-confirm" ).dialog( "close" );
 	        	salvarsuperfamily();
 	        },
 	        "No": function() {
 		        $( "#dialog-confirm" ).dialog( "close" );
 		    }
 	      });

 		$( "#dialog-confirm").dialog( "open" );

	}

	function salvarsuperfamily(){
		$.ajax({
	        type: "POST",
	        url:  document.getElementById("context_path").value + "/salvasuperfamily",
	        data: $('#form-superfamily').serialize(),                   
	        cache: true,
	        success: function(response) {
	        	var ret = response.split("|");
	            msg = ret[1];
	            document.getElementById("msg-dialog-alert").innerHTML = msg;
	            
	            if (document.forms["form-superfamily"]["acao"].value != 'E' || ret[0] != 0){
	            		$( "#dialog-alert" ).dialog("open");
	           	}
				
	            if (ret[0] == 0){
	            	$( "#dialog-inclui-superfamily" ).dialog("close");
	            	carregaselect("superfamily", 'id_superfamily', 1, 1, "id_classe=" + $('#id_classe').multipleSelect('getSelects'));
	            	carregaselect("family", 'id_family', 1, 1, "id_classe=" + $('#id_classe').multipleSelect('getSelects') + 
                            "&id_superfamily=" + $('#id_superfamily').multipleSelect('getSelects') );
	            }
	        }
	    });		
		
	}