package org.unipampa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotto.util.Util;
import org.unipampa.cadastro.htt.Superfamily;
import org.unipampa.db.conector.htt.SuperfamilyCon;

/**
 * Servlet implementation class SalvaCliente
 */
@WebServlet("/SalvaSuperFamily")
public class SalvaSuperFamily extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public SalvaSuperFamily() {
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
			
			SuperfamilyCon sfcon = new SuperfamilyCon();
			String acao = request.getParameter("acao");
			
			//Excluir
			if (acao.equals("E")){
				int idsf = Integer.parseInt((String)request.getParameter("id_superfamily"));

				sfcon.excluir(idsf);
				
				return;
			}
			else{
				
				Superfamily sf;
				sf = new Superfamily();
				
				if (Util.isnullParm("id_classe", request)){
					out.print("-1|Please select class");
					return;
				}
				
				if (acao.equals("A"))
					sf.setIdsuperfamily(Integer.parseInt(request.getParameter("id_superfamily")));
				
				sf.setNmsuperfamily(request.getParameter("nm_superfamily"));
				sf.setIdclasse(Integer.parseInt(request.getParameter("id_classe")));
				
				if (!validar(sf, out))
					return;
				
				if (acao.equals("A"))
					sfcon.atualizar(sf); 
				if (acao.equals("I"))
					sfcon.incluir(sf);
			}
			
		}
		catch (Exception e){
			out.print("-1|An error ocurred while saving super family: ".concat(e.getMessage()));
			return;
		}
		
		out.print("0|Super Family successfully saved|0");
		return;		
	}
	

	private boolean validar(Superfamily sf, PrintWriter out){
		
		if (Util.format(sf.getNmsuperfamily()).equals("")){
			out.print("-1|Enter a Super Family corretly");
			return false;
		}
		
		return true;
	}
}
