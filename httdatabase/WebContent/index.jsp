<%@page import="org.unipampa.db.conector.ParameterCon"%>
<%@page import="org.unipampa.cadastro.Parameter"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/menu.jsp" %>
<%@ include file="/chartsindex/httcharts.jsp" %>
<%@ include file="/chartsindex/hvtcharts.jsp" %>

<style>
.marquee {position:relative;
     overflow:hidden;
     height:22px;
     padding-left: 50px;
     }
.marquee span {white-space:nowrap;}

</style>

<script src="<%=request.getContextPath()%>/js/highchart/highcharts.js"></script>
<script src="<%=request.getContextPath()%>/js/highchart/modules/exporting.js"></script>
<script src="<%=request.getContextPath()%>/js/highchart/highcharts-3d.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/raphael-min.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsphylosvg-min.js"></script> 				


<script>

function start() {
	   new mq('m1');
	   mqRotate(mqr); // must come last
	}

	// Continuous Text Marquee
	// copyright 30th September 2009by Stephen Chapman
	// http://javascript.about.com
	// permission to use this Javascript on your web page is granted
	// provided that all of the code below in this script (including these
	// comments) is used without any alteration
	function objWidth(obj) {if(obj.offsetWidth) return  obj.offsetWidth; if (obj.clip) return obj.clip.width; return 0;} var mqr = []; function mq(id){this.mqo=document.getElementById(id); var wid = objWidth(this.mqo.getElementsByTagName('span')[0])+ 5; var fulwid = objWidth(this.mqo); var txt = this.mqo.getElementsByTagName('span')[0].innerHTML; this.mqo.innerHTML = ''; var heit = this.mqo.style.height; this.mqo.onmouseout=function() {mqRotate(mqr);}; this.mqo.onmouseover=function() {clearTimeout(mqr[0].TO);}; this.mqo.ary=[]; var maxw = Math.ceil(fulwid/wid)+1; for (var i=0;i < maxw;i++){this.mqo.ary[i]=document.createElement('div'); this.mqo.ary[i].innerHTML = txt; this.mqo.ary[i].style.position = 'absolute'; this.mqo.ary[i].style.left = (wid*i)+'px'; this.mqo.ary[i].style.width = wid+'px'; this.mqo.ary[i].style.height = heit; this.mqo.appendChild(this.mqo.ary[i]);} mqr.push(this.mqo);} function mqRotate(mqr){if (!mqr) return; for (var j=mqr.length - 1; j > -1; j--) {maxa = mqr[j].ary.length; for (var i=0;i<maxa;i++){var x = mqr[j].ary[i].style;  x.left=(parseInt(x.left,10)-1)+'px';} var y = mqr[j].ary[0].style; if (parseInt(y.left,10)+parseInt(y.width,10)<0) {var z = mqr[j].ary.shift(); z.style.left = (parseInt(z.style.left) + parseInt(z.style.width)*maxa) + 'px'; mqr[j].ary.push(z);}} mqr[0].TO=setTimeout('mqRotate(mqr)',10);}

</script>

<script>

		var phylocanvas;



		$(function() { 
			
			start();
			
			//Janela do grafico da familia
	        $('.easyui-window').window({
	            collapsible: false,
	            minimizable: false,
	            maximizable: false,
	            closable: true
	        });

		});
		
		
		function loadfamilychart(idsuperfamily, qttotal){
			$.ajax({
		        type: "POST",
		        url:  "./chartsindex/familychart.jsp?" +
		    		 "idsuperfamily=" + idsuperfamily + 
		    		 "&qttotal=" + qttotal,
		        cache: true,
		        success: function(response) {
		            
		            var obj = jQuery.parseJSON(response.trim());
			        $('#grafico_familiate').highcharts().series[0].setData(obj);
		        }
		    });
		}
		

</script>

<body onload="inicializacontroles()">

<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">Horizontal Transposon Transfer (HTT)</h3>

<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%;" >
	
	<table style="width: 100%; padding-right: 20px; padding-left: 20px; text-align:justify;">
	
		<tr>
		<td>
<!-- 		<p style="text-align:center; font-size: large;"> <b>Horizontal Transposon Transfer (HTT) </b></p> -->
		
		&emsp;&emsp;Transposons or Transposable elements (TEs) are "mobile genes" capable of mobilization from one 
		genomic location to another through non-homologous recombination. As this movement is mediated 
		by its own proteins and does not contribute to the survival of the host that it inhabits, they 
		are known as selfish genomic parasites. Despite their capacity for transposition inside genomes, 
		they can frequently transpose the species boundaries and consequently migrate from one species 
		to another. Such phenomenon is called Horizontal Transposons Transfer. HTT was first discovered 
		by Daniels et al. (1984) when analysing a <i>P</i> element that was transferred from <i>Drosophila willistoni</i> 
		to <i>D. melanogaster</i>. Since then, many more cases have been documented in the literature. Moreover, 
		in the last years, such discoveries have been boosted by the unprecedented amount of new genomes 
		available. Despite the recognition of HTT as a common phenomenon in recent years, it is still 
		difficult to draw major conclusions about HTT patterns, such as where in the tree of life these 
		cases are more frequently found. This is mainly due to the historical bias and lack of studies in 
		many taxa. To date, there has been no easy way to visualise each TE or host species, and should 
		be further analysed in order to provide a more comprehensive view of such phenomena. Based on these 
		concerns, we developed the HTT database to keep an updated repository of HTT events in all 
		eukaryotes, allowing not only TE specialists to add new events and search the database, but 
		also non-specialists. Moreover, we expanded the database to include Horizontal-Virus Transfer 
		also known as endogenization events which is characterized by the stable integration a viral 
		genomic fragment into the host genome.

		</td>
		</tr>
	
	</table>
</div>
	
<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">TEs classification</h3>

<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%;" >

	<table style="width: 100%; padding-right: 20px; padding-left: 20px; text-align:justify;">
		
	<tr>

	<td> 
<!-- 		<b><Span style="font-size: large;">TEs classification</Span></b> <br><br> -->
		&emsp;&emsp;
		TEs are classified into two classes: class I includes those that transpose through 
		an RNA intermediate, while class II describes those that use DNA as an intermediate 
		in the transposition process. Here, we are using the Repbase classification implemented 
		in <a href="http://www.girinst.org/repbase/" target="_blank">http://www.girinst.org/repbase/</a>
		 since it is an expandable TEs database frequently 
		used by TEs researchers. Non-LTR and LTR are class I elements and DNA Transposons 
		are class II TEs, as can be seen in the figure below.<br><br> 
		&emsp;&emsp;
		Clicking on each part of the chart will redirect you to the database search with the 
		corresponding HTT cases.		
	</td>	
	</tr>
	<tr>
	<td>
		<div id="grafico_hierarquia" style="width: 800px; height: 650px; margin: 0 auto;">
		</div>
		
	</td>
	</tr>



	</table>

</div>

<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">HTT Database Evolution</h3>
<table style="width: 100%;  ">
<tr>
	<td style="width: 50%; vertical-align: top; text-align: center;">
		<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%;text-align: center;" >
			<div id="grafico_evolucao_qtart" style="width: 75%; vertical-align: top; margin: 0 auto; ">
			</div>
		</div>
	</td>

	<td style="width: 50%; vertical-align: top; text-align: center;">
		<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%;text-align: center;" >
			<div id="grafico_evolucao_qthtt" style="width: 75%; vertical-align: top; margin: 0 auto; ">
			</div>
		</div>
	</td>

</tr>

</table>

<!-- HVT CHARTS -->
<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">HVT Database Evolution</h3>
<table style="width: 100%;  ">
<tr>
	<td style="width: 50%; vertical-align: top; text-align: center;">
		<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%;text-align: center;" >
			<div id="grafico_evolucao_qtart_hvt" style="width: 75%; vertical-align: top; margin: 0 auto; ">
			</div>
		</div>
	</td>

	<td style="width: 50%; vertical-align: top; text-align: center;">
		<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%;text-align: center;" >
			<div id="grafico_evolucao_qthvt" style="width: 75%; vertical-align: top; margin: 0 auto; ">
			</div>
		</div>
	</td>

</tr>

</table>


<table style="width: 100%; ">

<tr>
	<td style="width: 50%; vertical-align: top;">
		<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">News and Updates</h3>
		<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%; height: 120px;" >
			The HTT-DB will be updated every year with new HTT cases and features to improve the 
			user experience. 
			<br><br>
			Last published findings about HTT:
			<br>
				<div style="padding: 10px; width: 96%;text-align: center;" >
				<div id="m1" class="marquee"  style="text-align: center;">	
				<span>
					<%=Util.format(dbparm.getDsmainbanner()) %>
				</span>
				</div>
	</div>
			
		</div>
	</td>

	<td style="width: 50%; vertical-align: top;">
		<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">Citing HTT-DB</h3>
		<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%; height: 120px;" >
			<br>
				<%=dbparm.getDsciting() %>
<!-- 			<a href="http://bioinformatics.oxfordjournals.org/cgi/content/abstract/btv281?ijkey=emu4bwsllEd8Hvm&keytype=ref" target="_blank"> -->
<!-- 			<b>HTT-DB - Horizontally transferred transposable elements database</b><br> -->
<!-- 			Bruno Reis Dotto; Evelise Leis Carvalho; Alexandre Freitas; Luis Fernando Duarte; Paulo Marcos Pinto; Mauro Freitas Ortiz; Gabriel Luz Wallau. Bioinformatics 2015; doi: 10.1093/bioinformatics/btv281 -->
<!-- 			</a>		 -->
		</div>
		<br>
	</td>

</tr>


</table>

    
<!--     Janela para abrir o gráfico das famílias -->
    <div id="wfamilychart" class="easyui-window" data-options="modal:true,closed:true" title="Family Data" style="width:700px;height:500px;padding:10px;">
        
        		<div id="grafico_familiate" style="width: 600px; height: 400px; margin: 0 auto;">
		</div>
        
    </div>

</body>


