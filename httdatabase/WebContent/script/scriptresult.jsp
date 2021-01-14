<%@ include file="/menu.jsp" %>

<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>

<script type="text/javascript" > 
var ct = 9;
$(function() {
	
	$("#aviso").hide();
	$("#mensagem").hide();
	$("#resultado").hide();
	
	if (document.forms["form-data"]["id"].value == ""){
		window.location = "scriptform.jsp";
		return;
	}
  
	$.ajax({
        type: "POST",
        url:  "retornaresultscript",
        data: $('#form-data').serialize(),                   
        cache: true,
        success: function(response) {
        	var ret = response.split("|");

        	if (ret[0] == -1){
        		$("#aviso").show();
    			document.getElementById("msgaviso").innerHTML = ret[1];
        	}
        	else if (ret[0] == 0){

        		$("#mensagem").show();
    			document.getElementById("pagelocation").innerHTML = "<a href='" + window.location + "'>" + window.location + "</a>";
        		
        		var timer = setInterval(function(){
        			
        			if (ct == 0){
          			   window.location.reload(1);
          			   clearInterval(timer);
         			}

        			if (ct > 0)
        				document.getElementById("msgrun").innerHTML = "Still working... This screen will be refreshed in " + ct + " seconds.";
        			
        			ct--;
        		
        		}, 1000);

        	} 
        	else if (ret[0] == 1){
        		$("#aviso").show();
    			document.getElementById("msgaviso").innerHTML = "The process requested was NOT Found in our Database. Make sure you correctly copied the address. Processes more than 10 days are automatically deleted.";
        	}
        	else if (ret[0] == 2){
        		$("#mensagem").show();
    			document.getElementById("msgrun").innerHTML = "Process finished!";
    			document.getElementById("pagelocation").innerHTML = "<a href='" + window.location + "'>" + window.location + "</a>";

    			document.getElementById("idtename").innerHTML = "Selected TE: <b>" + ret[1] + "</b>";
    			$("#resultado").show();
//     			$("#resimg").attr("src", "data:image/png;base64," + ret[1]);
        	}
        	
        }
    });
	
	
});

</script>

<%
String id="";

if (!Util.isnullParm("id", request))
	id = request.getParameter("id");
%>

<body onload="inicializacontroles()">

<h3 class="titulo-borda-janela borda-janela" style="width: 600px; margin-bottom:5px;">HTT Script Detect - VHICA</h3>
<!-- <h3 class="titulo-borda-janela borda-janela" style="width: 600px; margin-bottom:5px;">How to add data</h3> -->

<div class="borda-janela" style="padding: 20px;width: 560px; text-align: left; " >
	
	<form id="form-data" name="form-data">
		<input type="hidden" name="id" value="<%=id%>" >
	</form>

	<div id=aviso class="ui-widget" style="width: 100%; margin: 0 auto; text-align: center;">
		<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
			<p style=" text-align: center;"><span class="ui-icon ui-icon-alert" style="float:left;"></span>
			<strong>Alert: </strong><div id="msgaviso"></div></p>
		</div>
	</div>		

	<div id=mensagem class="ui-widget" style="width: 100%; margin: 0 auto; text-align: center;">
		<div id="msgrun">Still working... This screen will be refreshed in 10 seconds.</div>	
		<p>You can save the address above, results are be saved for 10 days.</p>
		<div id="pagelocation"></div>
	</div>		
	
</div>

<div id=resultado class="borda-janela" style="padding: 20px;width: 560px; text-align: left; margin-top:10px;" >
	<div  class="ui-widget" style="width: 100%; margin: 0 auto; text-align: center;">
		<div id="idtename"></div>
		<p><a href="scriptselectte.jsp?id=<%=id%>">Click here to change TE and script parameters</a></p>
		<p>Click above to open a ZIP containing results files.</p>
		<a href="downloadresult?id=<%=id%>" target="_blank">
			<img id="zipicon" height="100" width="100" src="zip-icon.png" />
		</a>
<!-- 		<img id="resimg" width="100%" src="" /> -->
	</div>		
</div>
<br><br>
</body>