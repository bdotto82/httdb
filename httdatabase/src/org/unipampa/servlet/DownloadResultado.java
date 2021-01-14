package org.unipampa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.ListIterator;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

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
@WebServlet("/DownloadResultado")
public class DownloadResultado extends HttpServlet {
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        InputStream is = null;
        response.setCharacterEncoding("UTF-8"); 
        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment;filename=vhicaresultfiles.zip");
        
        ServletOutputStream outStream = response.getOutputStream();
        
        try {
        		
        		ParameterScriptCon parcon = new ParameterScriptCon();
        		ParameterScript parm = parcon.consultar(1);
        	
        		String id = request.getParameter("id").trim();
        		
        		//String dirname = parm.getDirlocation().concat(request.getSession().getId()).concat("/");
        		String dirname = parm.getDirlocation().concat(id).concat("/");
        		
            	File dir = new File(dirname);

//            	String [] filenames = {"Rplots.pdf", "table.txt", "table_descriptive_statistics.txt"};
//            	File file;

                ZipOutputStream zos = new 
                        ZipOutputStream(response.getOutputStream()); 
            	
                ZipEntry zentry;

            	String[] extensions = new String[] { "txt", "pdf" };
        		List<File> files = (List<File>) FileUtils.listFiles(dir, extensions, true);
        		for (File file : files) {
            		zentry = new ZipEntry(file.getName());
            		zos.putNextEntry(zentry);
            		zos.write(FileUtils.readFileToByteArray(file));
            		zos.closeEntry();
        		}
                
				zos.close();
        } catch (Exception e) {
			outStream.write("-1|Error running script: ".concat(e.getMessage()).getBytes("UTF-8") );
		}
        
    }
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadResultado() {
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
