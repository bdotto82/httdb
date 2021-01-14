	function incluirclasse(){
		document.forms["form-classe"]["acao"].value='I';
		document.forms["form-classe"]["nm_classe"].value='';
		document.forms["form-classe"]["id_classe"].value='';
		
		$('#dialog-inclui-classe').dialog('open');
	}

	function editarclasse(){
		if (validaredicaoselect('id_classe', 'class') == -1) return;
	
		document.forms["form-classe"]["acao"].value='A';
		document.forms["form-classe"]["nm_classe"].value=$('#id_classe').multipleSelect('getSelects', 'text');
		document.forms["form-classe"]["nm_classe"].value = document.forms["form-classe"]["nm_classe"].value.trim();
		document.forms["form-classe"]["id_classe"].value=$('#id_classe').multipleSelect('getSelects');
		
		$('#dialog-inclui-classe').dialog('open');
	}

	function excluirclasse(){
		if (validaredicaoselect('id_classe', 'class') == -1) return;
	
		document.forms["form-classe"]["acao"].value='E';
		document.forms["form-classe"]["id_classe"].value=$('#id_classe').multipleSelect('getSelects');
		
 		document.getElementById("msg-confirm-alert").innerHTML = "Confirm class delete?";
 		
 		$("#dialog-confirm").dialog('option', 'buttons', {
 	        "Yes": function() {
 	        	$( "#dialog-confirm" ).dialog( "close" );
 	        	salvarclasse();
 	        },
 	        "No": function() {
 		        $( "#dialog-confirm" ).dialog( "close" );
 		    }
 	      });

 		$( "#dialog-confirm").dialog( "open" );

	}

	function salvarclasse(){
		$.ajax({
	        type: "POST",
	        url:  document.getElementById("context_path").value + "/salvaclasse",
	        data: $('#form-classe').serialize(),                   
	        cache: false,
	        success: function(response) {
	        	var ret = response.split("|");
	            msg = ret[1];
	            document.getElementById("msg-dialog-alert").innerHTML = msg;
	            
	            if (document.forms["form-classe"]["acao"].value != 'E' || ret[0] != 0){
	            		$( "#dialog-alert" ).dialog("open");
	           	}
				
	            if (ret[0] == 0){
	            	 $( "#dialog-inclui-classe" ).dialog("close");
		    	     carregaselect("classe", 'id_classe', 1, 1);
		    		 carregaselect('classe', 'id_classe_form_superfamily', 0, 0);
	            }
	        }
	    });		
		
	}
	