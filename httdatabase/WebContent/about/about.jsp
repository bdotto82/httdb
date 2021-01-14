<%@ include file="/menu.jsp" %>

<%-- <script src="<%=request.getContextPath()%>/js/highchart/highcharts.js"></script> --%>
<%-- <script src="<%=request.getContextPath()%>/js/highchart/modules/exporting.js"></script> --%>
<%-- <script src="<%=request.getContextPath()%>/js/highchart/highcharts-3d.js"></script> --%>

<style>

	a {
		font-size: small;
	}

</style>


<script>

</script>

<body onload="inicializacontroles()">

<!-- <h3 class="titulo-borda-janela borda-janela" style="width: 100%; margin-bottom:5px;">About</h3> -->
<br>

<div class="borda-janela" style="padding-top: 8px; padding-bottom: 8px;width: 100%;" >
	
	<table style="width: 100%; padding-right: 20px; padding-left: 20px; text-align:justify;"">
	
		<tr>
			<td>
				<a href=#db>Database Organisation</a><br>
				&emsp;&emsp;<a href=#dbfilter>Filters</a><br>
				&emsp;&emsp;<a href=#dbtable>Table</a><br>
				&emsp;&emsp;&emsp;&emsp;<a href=#dbexcelexport>Save table as tabular and figure format</a><br>
				&emsp;&emsp;<a href=#dbchart>Chart</a><br>
				&emsp;&emsp;&emsp;&emsp;<a href=#dbchartexport>Chart Export</a><br>
				<a href=#vhica>Vhica online - Vertical and Horizontal Inheritance Consistency Analysis (VHICA package)</a><br>
				&emsp;&emsp;<a href=#vhicapage1>Sending Files</a><br>
				&emsp;&emsp;<a href=#vhicapage2>Setting VHICA Parameteres</a><br>
				&emsp;&emsp;<a href=#vhicaout>Outputs of VHICA implemented in HTT database</a><br>
				<a href=#adddata>How to add data</a><br>
				<a href=#references>References</a><br>
				
			</td>
		</tr>
	
	</table>
	
	<table style="width: 100%; padding: 20px; ">
		
	<tr>
		<td style="width: 50%; vertical-align: middle; text-align: justify; padding-right: 20px; "> 
			<hr>

<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
	<Span id="db">Database Organisation</Span>
</h3>

				&emsp;&emsp;The HTT database is organised as a table with eight columns. Three columns contain "TEs
				keywords" following the TEs classification hosted in Repbase: Class, Superfamily and Family.
				Two columns include "Host Organisms keywords" following the NCBI taxonomy classification of
				Organism (the higher taxonomic level before the taxonomic level where the HTT occurred) and
				the taxonomic levels where the HTT occurred. The last column includes the method or methods
				used to detect the HTT.
				<br> 
				&emsp;&emsp;Users can visualise the data in two formats: as a row/column table or as a dynamic chart.
				<br><br> 
		</td>	
	</tr>

	<tr>
		<td style="width: 50%; vertical-align: middle; text-align: justify; padding-right: 20px; "> 

<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
	<Span id="dbfilter">Filters</Span>
</h3>

				&emsp;&emsp;Selecting filters to select data allows the user to interact and select the HTT cases as they
				wish. In the figure below, two kinds of filters are explained: TEs Keyword and Host Organism
				Keywords. If the user presses the 'X' button, this will clear all of the previous selections on the
				corresponding dropdown menu.
				<br><br>
				<img src="<%=request.getContextPath()%>/about/images/te_filter.png" style="padding: 5px;">
				<br>
				<b>&emsp;> Class Filter: </b>Used to select TE Class level.
				<br>
				<b>&emsp;> Super Family Filter: </b>Used to select TE Super Family level.
				<br>
				<b>&emsp;> Family Filter: </b>Used to select TE Family level.
				<br><br>
				&emsp;All according with Repbase classification - (<a style="font-size: small;" href="http://www.girinst.org/repbase/" target="_blank">http://www.girinst.org/repbase/</a>)
				<br><br>
				<img src="<%=request.getContextPath()%>/about/images/host_filter.png" style="padding: 5px;">
				<br>
				<b>&emsp;> Organism: </b>Used to select host organism taxa where HTT occurred. Such drop-down menu follows the NCBI taxonomy classification.
				<br>
				<b>&emsp;> Level: </b>Used to select the host taxonomic level where HTT event occurred.
				<br>
				<b>&emsp;> Species Ecological Relationships: </b>The relationship between the host organisms.
				<br>
				<br>

<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
	<Span id="dbtable">Table</Span>
</h3>

				&emsp;&emsp;According to the selected filters, the tab "table" will show the corresponding database
				information. The columns are explained below.
				<br><br>
				<img src="<%=request.getContextPath()%>/about/images/database_table.png" style="padding: 5px;">
				<br><br>
				<b>&emsp;> Class Column: </b>TE Class, following the TEs classification hosted in Repbase.
				<br>
				<b>&emsp;> Super Family Column: </b>TE Super Family, following the TEs classification hosted in Repbase.
				<br>
				<b>&emsp;> Family Column: </b>TE Family, following the TEs classification hosted in Repbase.
				<br>
				<b>&emsp;> Organism Column: </b>The higher taxonomic level before the taxonomic level were the HTT occurred following the NCBI taxonomy classification as Organism.
				<br>
				<b>&emsp;> Level Column: </b>The taxonomic levels were the HTT occurred.
				<br>
				<b>&emsp;> HTT Date Estimates (Mya): </b>The estimated date of when the HTT occurred, in million years.
				<br>
				<b>&emsp;> Species Ecological Relationships: </b>The relationship between the host organisms involved in the HTT.
				<br>
				<b>&emsp;> Evolutionary impact on the receptor host: </b>The impact on the host genome. Ex.: Generate new genes, burst and origin of a new genes.
				<br>
				<b>&emsp;> Confirmed Vector: </b>Vector involved in the transfer, responsible for the transmission.
				<br>
				<b>&emsp;> Events Column: </b>Number of HTT events described into published manuscripts.
				<br>
				<b>&emsp;> Method Column: </b>Method or methods used to detect the HTT. 
				<br>
				<b>&emsp;> Reference Column: </b>Links to the abstract of original paper where HTT events had been described.
				<br>
				<br>	
			<b><Span id="dbtable" style="font-size: large;">Methods and evidences to detect HTT</Span></b> <br><br>
				&emsp;&emsp;Method or methods used to detect the HTT. Several evidences and methods can be used to
				detect HTT, such as:

				<div style="padding-left: 30px;">

					<table>
						<tr>
							<td style="width: 100%">
								<b>SS - Sequence similarity: </b>High sequence similarity of TEs present in distantly-related species.
								<br><b>&emsp;&emsp;kA/kS (dN/dS): </b>Molecular evolutionary test of selective pressure - this test is used to evaluate whether the strong selective pressure on TEs can maintain high sequence similarity.  
								<br><b>&emsp;&emsp;kS (dS): </b>ks is another measure of sequence similarity analysing only synonymous substitutions, since it is considered to evolve neutrally.
							</td>
						</tr>
						<tr>
							<td>
								<table>
									<tr>
										<td style="text-align: center; vertical-align: middle;">
											<img src="<%=request.getContextPath()%>/about/images/ss.png" style="padding: 5px;">
											<br>
											Image 1
										</td>
										<td style="text-align: center; vertical-align: middle;">
											<img src="<%=request.getContextPath()%>/about/images/ks.png" style="padding: 5px; height: 203px;">
											<br>
											Image 2
										</td>
									</tr>								
								</table>
							</td>
						</tr>

						<tr>
							<td style="width: 100%">
								<br><b>PD - Patchy distribution: </b>The presence of a specific TE in one or a few species inside a phylogenetic cluster lacking this element.
							</td>
						</tr>
						<tr>
							<td>
								<table>
									<tr>
										<td style="text-align: center; vertical-align: middle;">
											<img src="<%=request.getContextPath()%>/about/images/pd.png" style="padding: 5px; height: 203px;">
											<br>
											Image 3
										</td>
									</tr>								
								</table>
							</td>
						</tr>

						<tr>
							<td style="width: 100%">
								<br><b>Phyl - Phylogenetic incongruences: </b>The phylogenetic discordance between host and TEs trees.
							</td>
						</tr>
						<tr>
							<td>
								<table>
									<tr>
										<td style="text-align: center; vertical-align: middle;">
											<img src="<%=request.getContextPath()%>/about/images/phyl.png" style="padding: 5px;height: 203px;">
											<br>
											Image 4
										</td>
									</tr>								
								</table>
							</td>
						</tr>

				</table>

				</div>

				<br>
				<br>

<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
	<Span id="dbexcelexport">Save table as tabular and figure format</Span>
</h3>

					&emsp;&emsp;After selecting data using one or several filters, the user can export the 
					resulting table in several tabular formats as .xls, .csv, .xml, .txt, and .doc or in .png 
					figure format. To download the table, the user just presses the button "Export Table Data", 
					and selects the path and name for the exported file.		
			<br><br>

				<img src="<%=request.getContextPath()%>/about/images/save_excel.png" style="padding: 5px;">
				<br><br>
			
			<hr><br>

<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
	<Span id="dbchart">Charts</Span>
</h3>
			
				&emsp;&emsp;Users can also visualise the results as pie graphs; they just 
				select the "graph" tab, and choose one column to display this information 
				on a pie chart.				
				<br><br>
			
				<img src="<%=request.getContextPath()%>/about/images/database_chart.png" style="padding: 5px;">
				<br><br>

<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
	<Span id="dbchartexport">Charts Export</Span>
</h3>
				&emsp;&emsp;Users can export any chart generated by the HTT-DB site by pressing 
				menu on the upper right corner of the graph. Several download formats are available, 
				including PNG, JPG, PDF and SVG.
				<br><br>
			
				<img src="<%=request.getContextPath()%>/about/images/chart_export.png" style="padding: 5px;">
				<br><br>
							
			<hr><br>


<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
	<Span id="vhica">Vhica online - Vertical and Horizontal Inheritance Consistency Analysis (VHICA package)</Span>
</h3>
				<p>
				&emsp;&emsp;In order to evaluate whether Transposable Elements (TEs) have evolved by vertical or horizontal transfer (HT) 
				across species, researchers usually look at several evolutionary history features such as: (i) non expected high similarity 
				of TE sequences between species that diverged a long time ago;  (ii) Patchy distribution of TEs in a group of species 
				and (iii) phylogenetic incongruences between the reconstructed evolutionary TE tree and the species tree (See above). 
				All this information along with the knowledge of the host species biology can support or not the hypothesis of horizontal 
				transfer over vertical transfer. 
				</p>
				<p>
				&emsp;&emsp;Although several proposed methods to detect HT exist, only a few are currently  implemented in softwares<sup>1</sup>. 
				Moreover, the available tools are normally command line softwares which demand knowledge of bioinformatics, consequently hindering 
				this type of analysis for biologists with basic computational experience. Recently, we developed a versatile R package called 
				VHICA (Vertical and Horizontal Inheritance Consistency Analysis - https://cran.r-project.org/web/packages/vhica/index.html)<sup>2</sup>
			 	for HT detection. Now we are making VHICA analyses available through the HTT-DB website and the usage is described as below.
				</p>
				&emsp;&emsp;VHICA performs a correlation analysis of two metrics extracted from single copy orthlog genes of the host species and TEs found in a pair of species.
				<p>
				&emsp;&emsp;The package calculates the dS - synonymous substitutions - which is a measure of the neutral evolution of coding sequences and the ENC - effective number of codons - which represents the selection pressure on the dS substitution as a response to translation efficiency of each gene (Figure 1). For more information on how it is calculated please see reference Wallau et al 2016.
				</p>
				<p><br>
					<b><Span id="vhicapage1" style="font-size: large;">First Page - Sending Files</Span></b> <br><br>
				</p>

				<img src="<%=request.getContextPath()%>/about/images/vhicapage1.png" style="padding: 5px;">

				<p>
				&emsp;&emsp;VHICA starts reading two required inputs: codon-aligned gene and TE files. Additionally, an optional 
				newick tree file can be provided. Some tips about the TE copy selection and the number of genes needed in order to have 
				a properly supported VHICA result can be found in the original VHICA publication. However a quick recipe is:
				</p>

				<ul style="list-style-type:disc">
					<li>Evaluating TEs polymorphism inside of a genome in order to decide how many copies of a given TE to include in VHICA analysis. Perform a phylogenetic reconstruction with all copies of a given TE from the same host genome to evaluate if there is any evidence of polymorphism that could represent different TE sublineages are evolving independently. If it does appears pick the most complete copy of each lineage for analysis.</li>
					<li>The higher the number of genes, the better, but a minimum of 20 genes should be enough to keep the robustness of the statistical analysis. Running VHICA with less than 20 genes can generate biased results and careful analysis is necessary.</li>
					<li>Codon alignment can be performed using MACSE webserver (http://mbb.univ-montp2.fr/MBB/subsection/softExec.php?soft=macse)<sup>3</sup> or any other tool available for codon alignment.					</li>
				</ul>
				<p>
				&emsp;In order to run VHICA smoothly in the HTT-DB server we established some standards:
				</p>
				<p>
				&emsp;The codon alignment of each gene should be in one multiple fasta file where the name of such file is the the 
				name of the gene/TE and the species names are in the fasta header. Before the upload, the user should certificate the 
				correctness of those standards:
				</p>
				
				<ul style="list-style-type:disc">
					<li>Gaps should be represented by "-" character, any other character added by the codon alignment software should be replaced by '-'.</li>
					<li>The gene and TE names should be properly added to the codon alignment file of each. The only special character allowed are 
					underscore "_" and dot ".", and each the header should not have more than 10 characters.
					<br><br>&emsp;&emsp;Ex: "P_element"<br><br>
					</li>
					<li>The species names from which the genes and TEs came from should be added as the fasta header name as an 
					acronym of four letters which may or may not be followed by dot "." and a letter to indicate one or multiple TE lineage 
					present in the same genome.
					<br><br>
					&emsp;&emsp;Ex:<br>&emsp;&emsp;>dmel.a 
	                <br>&emsp;&emsp;ATGCAGT
				    <br>&emsp;&emsp;>dsim	
				    <br>&emsp;&emsp;ATGCGGT
			        <br>&emsp;&emsp;>dmel.b
			        <br>&emsp;&emsp;ATGCTGG
					</li>
				</ul>
				<p>
					Click <a href=#>HERE</a> to download a zip containing genes, TEs and newick tree file example.
				</p>

				<p><br>
					<b><Span id="vhicapage2" style="font-size: large;">Second Page - Setting VHICA Parameteres</Span></b> <br><br>
				</p>

				<img src="<%=request.getContextPath()%>/about/images/vhicapage2.png" style="padding: 5px;">

				<p>
				&emsp;&emsp;The second page allows one to select one or all TEs, if one submitted more than one TE for analysis. 
				Moreover, it allows one to select the statistical correction method of preference (Bonferroni or False Discovery Rate) 
				and select a VHICA option (skip.void in the R package = Keep only species which presented a given TE). The last option 
				in the "on" state will output the graphical pairwise species comparison only with the species which presented at least 
				one TE copy. Otherwise, it will output all species even if no TE was analysed.
				</p>
				<p>
				&emsp;&emsp;The VHICA package 0.2.4 compiled in the HTT-DB has some improvements compared with the original version. 
				Now it enables the software to  export the comparison in which HTTs were detected along with the dS distance, and the 
				corresponding p-value in tabular format. We also implemented an option where the user can provide the evolutionary 
				rate, if available, which will then be used to estimate the time, in million years, when the detected horizontal 
				transfer events took place. It is based on the formula:
				<br><br>
				&emsp;&emsp;T = k/2r where,
				<br><br>
				&emsp;&emsp;T is the time since the split of two sequences, k is the dS estimate between two sequences and r is the 
				evolutionary rate by million years multiplied by two since the two sequences accumulate mutations independently 
				after the horizontal transfer event<sup>4,5</sup>.

				<p><br>
					<b><Span id="vhicaout" style="font-size: large;">Outputs of VHICA implemented in HTT database</Span></b> <br><br>
				</p>

				<img src="<%=request.getContextPath()%>/about/images/vhicapage3.png" style="padding: 5px;">

				<p>
				&emsp;&emsp;VHICA outputs a text file containing the summary of all HTT cases reported for only one TE (if the user 
				selected only one TE in <b>Second Page</b>) or one file for each TE (if the user selected "ALL" in <b>Second Page</b>) as follows:
				</p>
				
				<img src="<%=request.getContextPath()%>/about/images/outtxt1.png" style="padding: 5px;">
				
				<p>
				&emsp;&emsp;And a file containing the message below, if a given TEs is  not likely to have evolved by horizontal transfer.
				</p>
				
				<img src="<%=request.getContextPath()%>/about/images/outtxt2.png" style="padding: 5px;">
				
				<p>
				&emsp;&emsp;In addition, it will output the graphical plot for every TE analysed in a single .pdf file.
				</p>

				<img src="<%=request.getContextPath()%>/about/images/outpdf.png" style="padding: 5px;">

		<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
			<Span id="adddata">How to add data</Span>
		</h3>
				 &emsp;&emsp;The "How to add data" tab can be accessed by users publishing new cases 
				 of HTT and who want to include them in the database. All of the information will be 
				 submitted to the HTT-DB curators who will review and update the HTT-DB.
				<br><br>

		<h3 class="titulo-borda-janela borda-janela" style="width: 100%; ">
			<Span id="references">References</Span>
		</h3>
				 
			<ol type="1">
				<li>Carvalho, M.O. de, Loreto, E.L.S., 2012. Methods for detection of horizontal transfer of transposable elements in complete genomes. Genet. Mol. Biol. 35, 1078–1084. doi:10.1590/S1415-47572012000600024</li>
				<li>Wallau, G.L., Capy, P., Loreto, E., Le Rouzic, A., Hua-Van, A., 2015. VHICA, a new method to discriminate between vertical and horizontal transposon transfer: application to the mariner family within Drosophila. Mol. Biol. Evol. msv341. doi:10.1093/molbev/msv341</li>
				<li>Ranwez, V., Harispe, S., Delsuc, F., Douzery, E.J.P., 2011. MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons. PLoS One 6, e22594. doi:10.1371/journal.pone.0022594</li>
				<li>Kimura, M., 1980. A simple method for estimating evolutionary rates of base substitutions through comparative studies of nucleotide sequences. J. Mol. Evol. 16, 111–20.</li>
				<li>Graur D, Li W-H (2000) Fundamentals of molecular evolution, 2nd edn. Sinauer Associates, Sunderland</li>
			</ol>						
							
		</td>	
	</tr>
	</table>
</div>

</body>
