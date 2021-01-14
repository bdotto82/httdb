package org.unipampa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.dotto.util.Email;
import org.dotto.util.Util;
import org.unipampa.cadastro.Parameter;
import org.unipampa.cadastro.htt.Classe;
import org.unipampa.db.conector.ParameterCon;

/**
 * Servlet implementation class EnviaArtigo
 */
@WebServlet("/EnviaArtigo")
public class EnviaArtigo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public EnviaArtigo() {
        super();
        // TODO Auto-generated constructor stub
    }
 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8"); 
		PrintWriter out = response.getWriter();  
		
		try{
			
			InputStream is = null;
			
			Set setfiles = null;
			HashMap mapfiles = null;
			
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);

			 // Create a new file upload handler
			  DiskFileItemFactory factory = new DiskFileItemFactory();
			  ServletFileUpload upload = new ServletFileUpload(factory);
		     
		     // Parse the request to get file items.
		      List fileItems = upload.parseRequest(request);
			
		      // Process the uploaded file items
		      Iterator i = fileItems.iterator();

		      String message = "";
		      Map parm = new HashMap();

		      
		      while ( i.hasNext () ) 
		      {
		         FileItem fi = (FileItem)i.next();
		         if ( !fi.isFormField () )	
		         {
				     if (!fi.getName().equals("")){
				    	 if (setfiles == null) setfiles = new HashSet();
				    	 
				    	 mapfiles = new HashMap();
				    	 mapfiles.put("filename", fi.getName());
				    	 mapfiles.put("filestream", fi.getInputStream());
				    	 
				    	 setfiles.add(mapfiles);
				     }
		         }
		         else{
		        	 String name = fi.getFieldName();
		        	 String value = fi.getString();
		        	 
		        	 message = message.concat(name).concat(": ").concat(value).concat("<BR>");
		         }
		      }			
		      
		      ParameterCon parcon = new ParameterCon();
		      Parameter par = parcon.consultar();
		      
		      parm.put("user", par.getUser());
		      parm.put("password", par.getPassword());
		      parm.put("server", par.getServer());
		      parm.put("port", par.getPort());
		      
		      Email email = new Email();

		      if (setfiles != null)
		    	  email.sendMailTLS(par.getUser(), par.getEmailto(), "Envio de novo artigo do site HTT", message, setfiles, parm);
		      else
		    	  email.sendMailTLS(par.getUser(), par.getEmailto(), "Envio de novo artigo do site HTT", message, parm);
		    	  
		}
		catch (Exception e){
			out.print("-1|An error ocurred while send data: ".concat(e.getMessage()));
			return;
		}
		
		out.print("0|New data successfully sent|0");
		return;		
	}
	
}
