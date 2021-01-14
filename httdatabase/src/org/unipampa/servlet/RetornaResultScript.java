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

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.dotto.util.Util;
import org.unipampa.cadastro.ParameterScript;
import org.unipampa.db.conector.ParameterScriptCon;
 
/**
 * Servlet implementation class RetornaResultScript
 */
@WebServlet("/RetornaResultScript")
public class RetornaResultScript extends HttpServlet {
//    private static final long serialVersionUID = -2045199313944348406L;
   
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
        	
        	String idproc = request.getParameter("id");
        		
    		ParameterScriptCon parcon = new ParameterScriptCon();
    		ParameterScript parm = parcon.consultar(1);
        	
    		String dirname = parm.getDirlocation().concat(idproc).concat("/");
    		String filename = parm.getResultfilename();
            
    		//Le arquivo contendo nome do TE selecionado na ultima analise
    		String tename = FileUtils.readFileToString(new File(dirname.concat("tename.arq")), "UTF-8");

            File dir = new File(dirname);
            
            if (!dir.exists()){
        		outStream.print("1|PROCESSO NÃO ENCONTRADO");
        		return;
            }
    		
            File result = new File(dirname + filename);
            
            if (!result.exists()){
        		outStream.print("0|".concat(request.getContextPath()).concat("/script/scriptresult.jsp?id=").concat(idproc));
        		return;
            }
            
            //String ret = Base64.encodeBase64String(FileUtils.readFileToByteArray(result));   
            //String ret = FileUtils.readFileToString(result, "UTF-8");

    		outStream.print("2|".concat(tename));

            
        } catch (Exception e) {
			outStream.write("-1|Error running script: ".concat(e.getMessage()).getBytes("UTF-8") );
		}
        

         
    }
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RetornaResultScript() {
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
