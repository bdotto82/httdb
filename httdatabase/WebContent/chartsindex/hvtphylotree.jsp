<%@page import="org.unipampa.db.conector.hvt.HVTResultCon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.unipampa.db.conector.OrganismCon"%>
<%@page import="java.io.StringWriter"%>
<%@page import="org.w3c.dom.ls.LSSerializer"%>
<%@page import="org.w3c.dom.ls.DOMImplementationLS"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.CharacterData"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.io.StringReader"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Files"%>
<%

HVTResultCon  rescon = new HVTResultCon();
OrganismCon orgcon = new OrganismCon();

int idlevel = Integer.parseInt(request.getParameter("id_level"));

String nmfile = "";
int idlevelgroup = 0;

ServletContext context = session.getServletContext();
String realContextPath = context.getRealPath("");

if (idlevel == 2){
	nmfile = realContextPath + "/xml/hvt/kingdomtree.xml";
	idlevelgroup = 0;
}
if (idlevel == 3){
	nmfile = realContextPath + "/xml/hvt/phylotree.xml";
	idlevelgroup = 1;
}
if (idlevel == 4){
	nmfile = realContextPath + "/xml/hvt/classtree.xml";
	idlevelgroup = 1;
}
if (idlevel == 5){
	nmfile = realContextPath + "/xml/hvt/ordertree.xml";
	idlevelgroup = 2;
}
if (idlevel == 6){
	nmfile = realContextPath + "/xml/hvt/familytree.xml";
	idlevelgroup = 2;
}
if (idlevel == 7){
	nmfile = realContextPath + "/xml/hvt/genustree.xml";
	idlevelgroup = 2;
}
	
byte[] encoded = Files.readAllBytes(Paths.get(nmfile));
String result = new String(encoded, "UTF-8");

DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
DocumentBuilder db = dbf.newDocumentBuilder();
InputSource is = new InputSource();
is.setCharacterStream(new StringReader(result));

Document doc = db.parse(is);
NodeList nodes = doc.getElementsByTagName("name");

NodeList stylenodes = doc.getElementsByTagName("styles");
Element stylenode = (Element) stylenodes.item(0);

String organism, uri;
ArrayList argroup = new ArrayList();

String[] colors = {"rgb(219, 179, 138)", 
				   "rgb(114, 171, 226)", 
				   "rgb(205, 217, 178)", 
				   "rgb(231, 220, 158)",
				   "rgb(160, 143, 41)",
				   "rgb(134, 227, 115)",
				   "rgb(114, 171, 226)", 
				   "rgb(205, 217, 178)", 
				   "rgb(231, 220, 158)",
				   "rgb(160, 143, 41)",
				   "rgb(114, 171, 226)", 
				   "rgb(205, 217, 178)", 
				   "rgb(231, 220, 158)",
				   "rgb(160, 143, 41)"
				  };


int color = 0; 

for (int i = 0; i < nodes.getLength(); i++) {
	Element line = (Element) nodes.item(i);

	organism = ((CharacterData)line.getFirstChild()).getData();
	int qtevents = rescon.getOrganismQtEvents(organism);
	uri = request.getContextPath()+ "/hvt/hvt.jsp?organism=1|" + Integer.toString(idlevel) + "|" +  organism + "|" +  organism;
	
	//Busca os grupos dos itens
	String group = orgcon.getNmGroup(organism, idlevelgroup);
	
	if (argroup.indexOf(group) < 0 && !group.equals("none")){
		argroup.add(group);

		Element stylegroupel = doc.createElement(group);
		stylegroupel.setAttribute("fill", colors[color]);
		stylegroupel.setAttribute("stroke", "rgb(255,255,255)");
		stylegroupel.setAttribute("opacity", "1");
		stylegroupel.setAttribute("label", group);
		stylegroupel.setAttribute("labelStyle", "sectorHighlightText");

		Element styleel = doc.createElement("E" + group);
		styleel.setAttribute("fill", colors[color]);
		styleel.setAttribute("stroke", "rgb(255,255,255)");
		styleel.setAttribute("opacity", "0.6");
		
		color++;
		
		stylenode.appendChild(stylegroupel);
		stylenode.appendChild(styleel);
	}

	line.setAttribute("bgStyle", "E" + group);
	
	Element parent = (Element)line.getParentNode();
	
	//create annotation node
	Element annotation = doc.createElement("annotation");
	Element desc = doc.createElement("desc");
	Element urinode = doc.createElement("uri");
	
	desc.setTextContent("Number of HVT events: " + qtevents);
	urinode.setTextContent(uri);

	annotation.appendChild(desc);
	annotation.appendChild(urinode);

	parent.appendChild(annotation);
	
	//create chart node
	Element chart = doc.createElement("chart");
	Element content = doc.createElement("content");
	Element groupel = doc.createElement("group");
	content.setTextContent(Integer.toString(qtevents));
	groupel.setTextContent(group);
	chart.appendChild(content);
	chart.appendChild(groupel);

	parent.appendChild(chart);
	
}

DOMImplementationLS domImplementation = (DOMImplementationLS) doc.getImplementation();
LSSerializer lsSerializer = domImplementation.createLSSerializer();
lsSerializer.getDomConfig().setParameter("xml-declaration", false);
result =  lsSerializer.writeToString(doc); 

out.print(result);


%>