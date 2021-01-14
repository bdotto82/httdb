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
import org.unipampa.db.conector.LevelCon;

/**
 * Servlet implementation class SalvaCliente
 */
@WebServlet("/SalvaLevel")
public class SalvaLevel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public SalvaLevel() {
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

			LevelCon levcon = new LevelCon();
			String acao = request.getParameter("acao");
			
			//Excluir
			if (acao.equals("E")){
				int idlev = Integer.parseInt((String)request.getParameter("id_level"));

				levcon.excluir(idlev);
				
				return;
			}
			else{
				
				Level lev;
				lev = new Level();
				
				if (acao.equals("A"))
					lev.setIdlevel(Integer.parseInt(request.getParameter("id_level")));
				
				lev.setNmlevel(request.getParameter("nm_level"));
				
				if (!validar(lev, out))
					return;
				
				if (acao.equals("A"))
					levcon.atualizar(lev); 
				if (acao.equals("I"))
					levcon.incluir(lev);
			}
			
		}
		catch (Exception e){
			out.print("-1|An error ocurred while saving level: ".concat(e.getMessage()));
			return;
		}
		
		out.print("0|Level successfully saved|0");
		return;		
	}
	

	private boolean validar(Level l, PrintWriter out){
		
		if (Util.format(l.getNmlevel()).equals("")){
			out.print("-1|Enter a level name corretly");
			return false;
		}
		
		return true;
	}
}
