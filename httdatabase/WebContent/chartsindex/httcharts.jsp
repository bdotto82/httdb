<%@page import="org.unipampa.db.conector.htt.ResultCon"%>
<%@page import="org.unipampa.cadastro.Parameter"%>
<%@page import="org.unipampa.db.conector.ParameterCon"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.unipampa.db.conector.htt.SuperfamilyCon"%>
<% 
	SuperfamilyCon sfcon = new SuperfamilyCon();
	HashMap mapsf = sfcon.getGraphicData();
	ParameterCon dbparmcon = new ParameterCon();
	Parameter dbparm = dbparmcon.consultar();

	ResultCon  rescon = new ResultCon();
	HashMap mapyear = rescon.getGraphicYear();
%>

<script>
		$(function() { 
		
			//Gráfico dos TEs
	        $('#grafico_hierarquia').highcharts({
	        	 chart: {
	 	            borderWidth: 0,
	                type: 'pie',
	                backgroundColor:'transparent'
	             },
	            title: {
	                text: 'Repbase TEs Superfamilies'
	            },
	 	        tooltip: {
	 	            pointFormat: ""
	 	        },
	            series: [{
	                name: 'Class',
	                data: <%=mapsf.get("ret1")%>,
	                size: '70%',
	                innerSize: '25%',
	                dataLabels: {
	                    formatter: function() {
	                        return this.y > 1 ? this.point.name : null;
	                    },
	                    color: 'white',
	                    distance: -60
	                },
	                point:{
	                	events:{
	                		click: function (e){
	                			window.location = "<%=request.getContextPath()%>/resultado/resultado.jsp" + this.url;
	                		}
	                	}
	                }

	            }, {
	                name: 'Super Family',
	                data: <%=mapsf.get("ret2")%>,
	                size: '90%',
	                innerSize: '70%',
	                dataLabels: {
	                    formatter: function() {
	                        // display only if larger than 1
	                        return this.y > 0 ? this.point.name   : null;
	                    }
	                },
	                point:{
	                	events:{
	                		click: function (e){
<%-- 	                		   window.location = "<%=request.getContextPath()%>/resultado/resultado.jsp" + this.url; --%>
								   loadfamilychart(this.id, this.qt);
								   $('#wfamilychart').window('center');
								   $('#wfamilychart').window('open');
								   $('#grafico_familiate').highcharts().setTitle({ text:  'TE Family data'}, {text:'<a href="<%=request.getContextPath()%>/resultado/resultado.jsp' + this.url + '" >' +  this.name + '</a>'  }, true);
	                		}
	                	}
	                }

	            }
	            ]
	        });
	        
	        //Gráfico da famÃ­lia do TE, abre quando clica na superfamiilia
			$('#grafico_familiate').highcharts({
		 	        chart: {
		 	        	borderWidth: 1,
		 	            plotBackgroundColor: null,
		 	            plotShadow: false
		 	        },
		 	        title: {
		 	            useHTML: true
		 	        },
		 	        subtitle: {
		 	            useHTML: true
		 	        },
		 	        tooltip: {
		 	            pointFormat: '<b>{point.percentage:.1f}%</b>'
		 	        },
		 	        plotOptions: {
		 	            pie: {
		 	                allowPointSelect: true,
		 	                cursor: 'pointer',
		 	                dataLabels: {
		 	                    enabled: true,
		 	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		 	                    style: {
		 	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		 	                    }
		 	                }
		 	            }
		 	        },
		 	        series: [{
		 	            type: 'pie',
		 	            data: [],

		                point:{
		                	events:{
		                		click: function (e){
		                			if(this.id > 0)
		                				window.location = "<%=request.getContextPath()%>/resultado/resultado.jsp" + this.url;
		                		}
		                	}
		                }
		 	        
		 	        }]
		 	    });
				 
	        
	        //Grafico da evolução da quantidade de HTT 
	        $('#grafico_evolucao_qtart').highcharts({
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
	 	            categories: <%=mapyear.get("yearlabel")%>,
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
	                data: <%=mapyear.get("ret1")%>,
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
	        $('#grafico_evolucao_qthtt').highcharts({
	        	 chart: {
	 	            borderWidth: 1,
	                type: 'column',
	             },
	            title: {
	                text: 'Cumulative number of HTTs in the last 10 years'
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
	 	            categories: <%=mapyear.get("yearlabel")%>,
	 	            title: {
	 	                text: "Years"
	 	            }
	 	        },
	 	       yAxis: {
	 	            min: 0,
	 	            title: {
	 	                text: 'HTTs'
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
	                name: 'HTTs',
	                data: <%=mapyear.get("ret2")%>,
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