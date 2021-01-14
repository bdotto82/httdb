<%@page import="java.util.HashMap"%>
<%@page import="org.unipampa.db.conector.hvt.HVTResultCon"%>
<% 
// 	SuperfamilyCon sfcon = new SuperfamilyCon();
// 	HashMap mapsf = sfcon.getGraphicData();
// 	ParameterCon dbparmcon = new ParameterCon();
// 	Parameter dbparm = dbparmcon.consultar();

 	HVTResultCon reshvt = new HVTResultCon();
 	HashMap mapyearhvt = reshvt.getGraphicYear();
%>

<script>
		$(function() { 
	        
	        //Grafico da evolução da quantidade de HTT 
	        $('#grafico_evolucao_qtart_hvt').highcharts({
	        	 chart: {
	 	            borderWidth: 1,
	                type: 'column',
	             },
	            title: {
	                text: 'Cumulative number of manuscripts in the last 10 years'
	            },
	            plotOptions: {
	                column: {
	                    stacking: 'normal',
	                }
	            },
	 	       legend: {
	 	            enabled: false
	 	        },
	 	       xAxis: {
	 	            categories: <%=mapyearhvt.get("yearlabel")%>,
	 	            title: {
	 	                text: "Years"
	 	            }
	 	        },
	 	       yAxis: {
	 	            min: 0,
	 	            title: {
	 	                text: 'Manuscripts'
	 	            },
	 	            
	 	            
	 	           stackLabels: {
	 	                enabled: true,
	 	                style: {
	 	                    fontWeight: 'bold',
	 	                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
	 	                }
	 	            }
	 	        },
	            series: [{
	                name: 'Manuscripts',
	                data: <%=mapyearhvt.get("ret1")%>,
	                size: '80%',
	                innerSize: '15%',
	                dataLabels: {
	                    formatter: function() {
	                        return this.y > 1 ? this.point.name : null;
	                    },
	                    color: 'white',
	                    distance: -60
	                },

	            }]
	        });
	        
	        //Grafico da evolução da quantidade de HTT 
	        $('#grafico_evolucao_qthvt').highcharts({
	        	 chart: {
	 	            borderWidth: 1,
	                type: 'column',
	             },
	            title: {
	                text: 'Cumulative number of HVTs in the last 10 years'
	            },
	            plotOptions: {
	                column: {
	                    stacking: 'normal',
	                }
	            },

	 	       legend: {
	 	            enabled: false
	 	        },
	 	       xAxis: {
	 	            categories: <%=mapyearhvt.get("yearlabel")%>,
	 	            title: {
	 	                text: "Years"
	 	            }
	 	        },
	 	       yAxis: {
	 	            min: 0,
	 	            title: {
	 	                text: 'HVTs'
	 	            },
	 	           stackLabels: {
	 	                enabled: true,
	 	                style: {
	 	                    fontWeight: 'bold',
	 	                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
	 	                }
	 	            }
	 	        },
	            series: [{
	                name: 'HVTs',
	                data: <%=mapyearhvt.get("ret2")%>,
	                size: '80%',
	                innerSize: '15%',
	                dataLabels: {
	                    formatter: function() {
	                        return this.y > 1 ? this.point.name : null;
	                    },
	                    color: 'white',
	                    distance: -60
	                },

	            }]
	        });
	        
	        
    });
    
  </script>