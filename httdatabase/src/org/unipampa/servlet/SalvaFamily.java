package org.unipampa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotto.util.Util;
import org.unipampa.cadastro.htt.Family;
import org.unipampa.db.conector.htt.FamilyCon;

/**
 * Servlet implementation class SalvaCliente
 */
@WebServlet("/SalvaFamily")
public class SalvaFamily extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public SalvaFamily() {
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

			FamilyCon fcon = new FamilyCon();
			String acao = request.getParameter("acao");
			
			//Excluir
			if (acao.equals("E")){
				int idfam = Integer.parseInt((String)request.getParameter("id_family"));

				fcon.excluir(idfam);
				
				return;
			}
			else{
				
				Family fam;
				fam = new Family();
				
				if (Util.isnullParm("id_superfamily", request)){
					out.print("-1|Please select super family");
					return;
				}
				
				if (acao.equals("A"))
					fam.setIdfamily(Integer.parseInt(request.getParameter("id_family")));
				
				fam.setNmfamily(request.getParameter("nm_family"));
				fam.setIdsuperfamily(Integer.parseInt(request.getParameter("id_superfamily").split("[|]")[0]));
				
				if (!validar(fam, out))
					return;
				
				if (acao.equals("A"))
					fcon.atualizar(fam); 
				if (acao.equals("I"))
					fcon.incluir(fam);
			}
			
		}
		catch (Exception e){
			out.print("-1|An error ocurred while saving family: ".concat(e.getMessage()));
			return;
		}
		
		out.print("0|Family successfully saved|0");
		return;		
	}
	

	private boolean validar(Family f, PrintWriter out){
		
		if (Util.format(f.getNmfamily()).equals("")){
			out.print("-1|Enter a Family name corretly");
			return false;
		}
		
		return true;
	}
}
