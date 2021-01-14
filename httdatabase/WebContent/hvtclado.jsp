<%@ include file="/menu.jsp" %>


<script src="<%=request.getContextPath()%>/js/highchart/highcharts.js"></script>
<script src="<%=request.getContextPath()%>/js/highchart/modules/exporting.js"></script>
<script src="<%=request.getContextPath()%>/js/highchart/highcharts-3d.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/raphael-min.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsphylosvg-min.js"></script> 				


<script>

		var phylocanvas;

		$(function() { 

			<%
				if (Util.isnullParm("treelevel", request))
					out.println("loadphylotree(2);");
				else
					out.println("loadphylotree("+ request.getParameter("treelevel") + ");");

			%>

		});
		
		
		function loadphylotree(level){
			
			//Arvore de filogenia
			$.get("./chartsindex/hvtphylotree.jsp?id_level=" + level, function(data) {
				var dataObject = {
					phyloxml: data,
					fileSource: false
				};		
				
				phylocanvas = new Smits.PhyloCanvas(
					dataObject,
					'svgCanvas', 
					800, 800,
					'circular'
				);
				
				/* Download Option */
				var svgSource = phylocanvas.getSvgSource();
				if(svgSource){
					document.getElementById("download-phylotree").onclick=function(){
						alert('Right-click and select "Save as..." option in the new window')
						window.open("data:image/svg+xml," + svgSource);
					}
				}
			});
			
		}
		
</script>

<body onload="inicializacontroles()">

<h3 id="phylotree" class="titulo-borda-janela borda-janela" style="width: 100%; ">HVT - Host Cladogram following NCBI taxonomy</h3>
<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px; width: 100%;text-align: center;" >

	<table style="width: 100%; padding-right: 20px; padding-left: 20px; text-align:justify;">
		
	<tr>
	<td>
		<br>
		&emsp;&emsp;
		Holding the cursor over the taxa shows you a hint with the number of HVTs for each taxa. Clicking
		on them will redirect you to the database search with the corresponding HVTs cases. Clicking on the 
		different taxa levels below will reload the cladogram with the correspondent taxa with HVT cases.
		<br>
	</td>
	</tr>
	<tr>
	<td style="text-align: center;">
	<br>
			Select Phylogeny Level:&nbsp; 
			<a href="?treelevel=2#phylotree">Kingdom</a>&nbsp;-&nbsp;
			<a href="?treelevel=3#phylotree">Phylum</a>&nbsp;-&nbsp;
			<a href="?treelevel=4#phylotree">Class</a>&nbsp;-&nbsp;
			<a href="?treelevel=5#phylotree">Order</a>
<!-- 			<a href="?treelevel=6#phylotree">Family</a>&nbsp;-&nbsp; -->
<!-- 			<a href="?treelevel=7#phylotree">Genus</a> -->
	</td>
	</tr>
	</table>
	
	<div id="svgCanvas"> </div>

	<input id="download-phylotree" type="button" value="Download as SVG image" />

</div>

<br>

</body>


