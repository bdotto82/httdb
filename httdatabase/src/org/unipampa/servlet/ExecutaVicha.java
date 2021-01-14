package org.unipampa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.SystemUtils;
import org.dotto.util.Util;
import org.unipampa.cadastro.ParameterScript;
import org.unipampa.db.conector.ParameterScriptCon;
 
/**
 * Servlet implementation class RecebeArquivo
 */
@WebServlet("/ExecutaVicha")
public class ExecutaVicha extends HttpServlet {
    //private static final long serialVersionUID = -2045199313944348406L;
   
    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        InputStream is = null;
        response.setCharacterEncoding("UTF-8"); 
        
        ServletOutputStream outStream = response.getOutputStream();
        
        try {
        		
        		ParameterScriptCon parcon = new ParameterScriptCon();
        		ParameterScript parm = parcon.consultar(1);
        	
        		String id = request.getParameter("id").trim();
        		
        		String dirname = parm.getDirlocation().concat(id).concat("/");
        		String genedirname = parm.getDirlocation().concat(id).concat("/gene1/");
        		String tedirname = parm.getDirlocation().concat(id).concat("/TE/");
        		
        		String tename = request.getParameter("id_te").trim();
        		String adjustmethod = request.getParameter("adjust_method");
        		
        		String divrate = "-1"; 
        		
        		if (!Util.isnullParm("div_rate", request)){
            		divrate = request.getParameter("div_rate");
            		if (divrate.trim().equals("")) divrate = "-1";
        		}
        		
        		//on / off
        		String skipvoid = request.getParameter("skip_void");
        		if (skipvoid == null) skipvoid = "off";
        		
        		//Exclui os arquivos de resultados previamente executados
            	String[] extensions = new String[] { "txt", "pdf", "end" };
        		List<File> files = (List<File>) FileUtils.listFiles(new File(dirname), extensions, true);
        		for (File file : files) {
            		FileUtils.deleteQuietly(file);
        		}
            	
				//Salva em um arquivo o nome do TE que esta sendo executado
				FileUtils.writeStringToFile(new File(dirname.concat("tename.arq")), tename, "UTF-8");
				
				ProcessBuilder builder;
				if (!SystemUtils.IS_OS_LINUX)
					builder = new ProcessBuilder(parm.getScriptcommand(), dirname, genedirname, tedirname, tename.trim(), adjustmethod, skipvoid, divrate);
				else
					builder = new ProcessBuilder("/bin/bash", parm.getScriptcommand(), dirname, genedirname, tedirname, tename.trim(), adjustmethod, skipvoid, divrate);
                
				//builder.start();
                
                outStream.print("0|".concat(request.getContextPath()).concat("/script/scriptresult.jsp?id=").concat(id));
            
        } catch (Exception e) {
			outStream.write("-1|Error running script: ".concat(e.getMessage()).getBytes("UTF-8") );
		}
        
    }
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExecutaVicha() {
        super();
        // TODO Auto-generated constructor stub
    }
	
//    private void processFormField(FileItem item, Arquivo arq) throws Exception{
//        // Process a regular form field
//        if (item.isFormField()) {
//            String name = item.getFieldName();
//            String value = item.getString("UTF-8");
//            
//            if (name.equals("id_tipo_arquivo"))
//            	arq.setIdtipoarquivo(Integer.parseInt(value));
//            else if (name.equals("ds_arquivo"))
//            	arq.setDsarquivo(value);
//            else if (name.equals("dt_referencia") && !value.equals(""))
//            	arq.setDtreferencia(Util.getDate("01/".concat(value)));
//            
//        }
//    }
 
    
}
