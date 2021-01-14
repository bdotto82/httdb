package org.unipampa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotto.util.Util;
import org.unipampa.cadastro.htt.Classe;
import org.unipampa.db.conector.htt.ClasseCon;

/**
 * Servlet implementation class SalvaCliente
 */
@WebServlet("/SalvaClasse")
public class SalvaClasse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public SalvaClasse() {
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
		
			ClasseCon classecon = new ClasseCon();
			String acao = request.getParameter("acao");
			
			//Excluir
			if (acao.equals("E")){
				int idclasse = Integer.parseInt((String)request.getParameter("id_classe"));

				classecon.excluir(idclasse);
				
				return;
			}
			else{
				
				Classe classe;
				classe = new Classe();
				
				if (acao.equals("A"))
					classe.setIdclasse(Integer.parseInt(request.getParameter("id_classe")));
				
				classe.setNmclasse(request.getParameter("nm_classe"));
				
				if (!validar(classe, out))
					return;
				
				if (acao.equals("A"))
					classecon.atualizar(classe);
				if (acao.equals("I"))
					classecon.incluir(classe);
			}
			
		}
		catch (Exception e){
			out.print("-1|An error ocurred while saving class: ".concat(e.getMessage()));
			return;
		}
		
		out.print("0|Class successfully saved|0");
		return;		
	}
	

	private boolean validar(Classe cl, PrintWriter out){
		
		if (Util.format(cl.getNmclasse()).equals("")){
			out.print("-1|Enter a Class corretly");
			return false;
		}
		
		return true;
	}
}
