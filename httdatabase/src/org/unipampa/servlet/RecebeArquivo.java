package org.unipampa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.dotto.util.Util;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.unipampa.cadastro.ParameterScript;
import org.unipampa.db.conector.ParameterScriptCon;
 
/**
 * Servlet implementation class RecebeArquivo
 */
@WebServlet("/RecebeArquivo")
public class RecebeArquivo extends HttpServlet {
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
        	
        		String dirname = parm.getDirlocation().concat(request.getSession().getId()).concat("/");
        		String genedirname = parm.getDirlocation().concat(request.getSession().getId()).concat("/gene1/");
        		String tedirname = parm.getDirlocation().concat(request.getSession().getId()).concat("/TE/");
        		
                DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
     
                ServletFileUpload upload = new ServletFileUpload(diskFileItemFactory);
                upload.setHeaderEncoding("UTF-8");  
                
                String inExample = "N";
                List items = null;
                items = upload.parseRequest(request);
                
                
                ListIterator li = items.listIterator();
                
            	File dir = new File(dirname);
            	
            	if (!dir.exists())
            		dir.mkdirs();
            	else
            		FileUtils.cleanDirectory(dir);
            	
                while (li.hasNext()) {
                    FileItem fileItem = (FileItem) li.next();
                    if (fileItem.isFormField()) {
                    	if (fileItem.getFieldName().equals("inExample")){
                    		inExample = fileItem.getString();
                    		break;
                    	}
                    		
                    }
                }

                li = items.listIterator();
                
                if (inExample.equals("N")){
                    while (li.hasNext()) {
                        FileItem fileItem = (FileItem) li.next();
                        if (!fileItem.isFormField()) {
                        	
                        	if (fileItem.getFieldName().equals("genefiles")){
                            	FileUtils.copyInputStreamToFile(fileItem.getInputStream(), 
    									new File(genedirname.concat(fileItem.getName().replaceAll("[()]", "_"))));
                        	}
                        	else if (fileItem.getFieldName().equals("tefiles")){
                            	FileUtils.copyInputStreamToFile(fileItem.getInputStream(), 
    									new File(tedirname.concat(fileItem.getName().replaceAll("[()]", "_"))));
                        	}
                        	else if (fileItem.getFieldName().equals("phylofile")){
                            	FileUtils.copyInputStreamToFile(fileItem.getInputStream(), 
    									new File(dirname.concat("phylofile.nwk")));
                        	}

                        }
                    }
                	
                }
                //Se esta rodando o exemplo, apenas copia o diretório de exemplo para o diretório da sessão
                else{
                	FileUtils.copyDirectory(new File(parm.getDirlocation().concat("example/")), dir); 
                }
                	
                
//                ProcessBuilder builder = new ProcessBuilder(parm.getScriptcommand(), dirname);
//                builder.start();
                
//                outStream.print("0|".concat(request.getContextPath()).concat("/script/scriptresult.jsp?id=").concat(request.getSession().getId()));
                outStream.print("0|"
                		.concat(request.getContextPath())
                		.concat("/script/scriptselectte.jsp?id=").concat(request.getSession().getId()));

            
        } catch (Exception e) {
			outStream.write("-1|Error running script: ".concat(e.getMessage()).getBytes("UTF-8") );
		}
        
    }
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecebeArquivo() {
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
