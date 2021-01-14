	function incluirlevel(){
		document.forms["form-level"]["acao"].value='I';
		document.forms["form-level"]["nm_level"].value='';
		document.forms["form-level"]["id_level"].value='';
		
		$('#dialog-inclui-level').dialog('open');
	}

	function editarlevel(){
		if (validaredicaoselect('id_level', 'level') == -1) return;
	
		document.forms["form-level"]["acao"].value='A';
		document.forms["form-level"]["nm_level"].value=$('#id_level').multipleSelect('getSelects', 'text');
		document.forms["form-level"]["nm_level"].value = document.forms["form-level"]["nm_level"].value.trim();
		document.forms["form-level"]["id_level"].value=$('#id_level').multipleSelect('getSelects');
		
		$('#dialog-inclui-level').dialog('open');
	}

	function excluirlevel(){
		if (validaredicaoselect('id_level', 'level') == -1) return;
	
		document.forms["form-level"]["acao"].value='E';
		document.forms["form-level"]["id_level"].value=$('#id_level').multipleSelect('getSelects');
		
 		document.getElementById("msg-confirm-alert").innerHTML = "Confirm level delete?";
 		
 		$("#dialog-confirm").dialog('option', 'buttons', {
 	        "Yes": function() {
 	        	$( "#dialog-confirm" ).dialog( "close" );
 	        	salvarlevel();
 	        },
 	        "No": function() {
 		        $( "#dialog-confirm" ).dialog( "close" );
 		    }
 	      });

 		$( "#dialog-confirm").dialog( "open" );

	}

	function salvarlevel(){
		$.ajax({
	        type: "POST",
	        url:  document.getElementById("context_path").value + "/salvalevel",
	        data: $('#form-level').serialize(),                   
	        cache: false,
	        success: function(response) {
	        	var ret = response.split("|");
	            msg = ret[1];
	            document.getElementById("msg-dialog-alert").innerHTML = msg;
	            
	            if (document.forms["form-level"]["acao"].value != 'E' || ret[0] != 0){
	            		$( "#dialog-alert" ).dialog("open");
	           	}
				
	            if (ret[0] == 0){
	            	 $( "#dialog-inclui-level" ).dialog("close");
		    	     carregaselect("level", 'id_level', 1, 1);
	            }
	        }
	    });		
		
	}
	