	function incluirmethod(){
		document.forms["form-method"]["acao"].value='I';
		document.forms["form-method"]["nm_method"].value='';
		document.forms["form-method"]["id_method"].value='';
		
		$('#dialog-inclui-method').dialog('open');
	}

	function editarmethod(){
		if (validaredicaoselect('id_method', 'method') == -1) return;
	
		document.forms["form-method"]["acao"].value='A';
		document.forms["form-method"]["nm_method"].value=$('#id_method').multipleSelect('getSelects', 'text');
		document.forms["form-method"]["nm_method"].value = document.forms["form-method"]["nm_method"].value.trim();
		document.forms["form-method"]["id_method"].value=$('#id_method').multipleSelect('getSelects');
		
		$('#dialog-inclui-method').dialog('open');
	}

	function excluirmethod(){
		if (validaredicaoselect('id_method', 'method') == -1) return;
	
		document.forms["form-method"]["acao"].value='E';
		document.forms["form-method"]["id_method"].value=$('#id_method').multipleSelect('getSelects');
		
 		document.getElementById("msg-confirm-alert").innerHTML = "Confirm method delete?";
 		
 		$("#dialog-confirm").dialog('option', 'buttons', {
 	        "Yes": function() {
 	        	$( "#dialog-confirm" ).dialog( "close" );
 	        	salvarmethod();
 	        },
 	        "No": function() {
 		        $( "#dialog-confirm" ).dialog( "close" );
 		    }
 	      });

 		$( "#dialog-confirm").dialog( "open" );

	}

	function salvarmethod(){
		$.ajax({
	        type: "POST",
	        url:  document.getElementById("context_path").value + "/salvamethod",
	        data: $('#form-method').serialize(),                   
	        cache: false,
	        success: function(response) {
	        	var ret = response.split("|");
	            msg = ret[1];
	            document.getElementById("msg-dialog-alert").innerHTML = msg;
	            
	            if (document.forms["form-method"]["acao"].value != 'E' || ret[0] != 0){
	            		$( "#dialog-alert" ).dialog("open");
	           	}
				
	            if (ret[0] == 0){
	            	 $( "#dialog-inclui-method" ).dialog("close");
		    	     carregaselect("method", 'id_method', 1, 1);
	            }
	        }
	    });		
		
	}
	