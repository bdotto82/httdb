package org.unipampa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotto.util.Util;
import org.unipampa.cadastro.Organism;
import org.unipampa.db.conector.OrganismCon;

/**
 * Servlet implementation class SalvaCliente
 */
@WebServlet("/SalvaOrganism")
public class SalvaOrganism extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public SalvaOrganism() {
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

			OrganismCon orgcon = new OrganismCon();
			String acao = request.getParameter("acao");
			
			//Excluir
			if (acao.equals("E")){
				int idorg = Integer.parseInt((String)request.getParameter("id_organism"));

				orgcon.excluir(idorg);
				
				return;
			}
			else{
				
				Organism org;
				org = new Organism();
				
				if (acao.equals("A"))
					org.setIdorganism(Integer.parseInt(request.getParameter("id_organism")));
				
				org.setNmorganism(request.getParameter("nm_organism"));
				org.setIdorganismlevel(Integer.parseInt(request.getParameter("id_organism_level")));
				org.setDsorganismtaxonomy(request.getParameter("ds_organism_taxonomy"));
				
				if (!validar(org, out))
					return;
				
				if (acao.equals("A"))
					orgcon.atualizar(org); 
				if (acao.equals("I"))
					orgcon.incluir(org);
			}
			
		}
		catch (Exception e){
			out.print("-1|An error ocurred while saving organism: ".concat(e.getMessage()));
			return;
		}
		
		out.print("0|Organism successfully saved|0");
		return;		
	}
	

	private boolean validar(Organism o, PrintWriter out){
		
		if (Util.format(o.getNmorganism()).equals("")){
			out.print("-1|Enter an organism name corretly");
			return false;
		}

		if (Util.format(o.getIdorganismlevel()).equals("")){
			out.print("-1|Select an organism level corretly");
			return false;
		}

		if (Util.format(o.getDsorganismtaxonomy()).equals("")){
			out.print("-1|Enter the organism string taxonomy corretly");
			return false;
		}

		return true;
	}
}
