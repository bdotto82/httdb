package org.unipampa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotto.util.Util;
import org.unipampa.cadastro.Level;
import org.unipampa.cadastro.Method;
import org.unipampa.db.conector.LevelCon;
import org.unipampa.db.conector.MethodCon;

/**
 * Servlet implementation class SalvaCliente
 */
@WebServlet("/SalvaMethod")
public class SalvaMethod extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public SalvaMethod() {
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
		
	
			if (request.getSession().getAttribute("loguser") == null){
				out.print("-1|You need to be logged to change database data!");
				return;
			}

			MethodCon metcon = new MethodCon();
			String acao = request.getParameter("acao");
			
			//Excluir
			if (acao.equals("E")){
				int idmet = Integer.parseInt((String)request.getParameter("id_method"));

				metcon.excluir(idmet);
				
				return;
			}
			else{
				
				Method met;
				met = new Method();
				
				if (acao.equals("A"))
					met.setIdmethod(Integer.parseInt(request.getParameter("id_method")));
				
				met.setNmmethod(request.getParameter("nm_method"));
				
				if (!validar(met, out))
					return;
				
				if (acao.equals("A"))
					metcon.atualizar(met); 
				if (acao.equals("I"))
					metcon.incluir(met);
			}
			
		}
		catch (Exception e){
			out.print("-1|An error ocurred while saving method: ".concat(e.getMessage()));
			return;
		}
		
		out.print("0|Method successfully saved|0");
		return;		
	}
	
	private boolean validar(Method m, PrintWriter out){
		
		if (Util.format(m.getNmmethod()).equals("")){
			out.print("-1|Enter a method name corretly");
			return false;
		}
		
		return true;
	}
}
