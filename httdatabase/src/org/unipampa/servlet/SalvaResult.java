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
import org.unipampa.cadastro.htt.Result;
import org.unipampa.db.conector.htt.ClasseCon;
import org.unipampa.db.conector.htt.ResultCon;

/**
 * Servlet implementation class SalvaResult
 */
@WebServlet("/SalvaResult")
public class SalvaResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet()
     */
    public SalvaResult() {
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

			ResultCon rescon = new ResultCon();
			String acao = request.getParameter("acao");
			
			//Excluir
			if (acao.equals("E")){
				int idresult = Integer.parseInt((String)request.getParameter("id_result"));

				rescon.excluir(idresult);
				
				return;
			}
			else{
				
				Result res;
				res = new Result();
				
				if (acao.equals("A"))
					res.setIdresult(Integer.parseInt(request.getParameter("id_result")));
				
				if (Util.isnullParm("id_classe", request) || request.getParameter("id_classe").equals("-1")){
					out.print("-1|Please select a class");
					return;
				}

				if (Util.isnullParm("id_superfamily", request) || request.getParameter("id_superfamily").equals("-1")){
					out.print("-1|Please select a superfamily");
					return;
				}

				if (Util.isnullParm("reference", request) ){
					out.print("-1|Please enter the reference");
					return;
				}

				if (Util.isnullParm("qt_events", request) ){
					out.print("-1|Please enter the amount of events");
					return;
				}

				res.setIdclasse(Integer.parseInt(request.getParameter("id_classe")));
				res.setIdsuperfamily(Integer.parseInt(request.getParameter("id_superfamily").split("[|]")[0]));
				
				if (!Util.isnullParm("id_family", request))
					if (!request.getParameter("id_family").equals("-1"))
						res.setIdfamily(Integer.parseInt(request.getParameter("id_family").split("[|]")[0]));

				if (!Util.isnullParm("id_organism", request))
					if (!request.getParameter("id_organism").equals("-1"))
						res.setIdorganism(Integer.parseInt(request.getParameter("id_organism").split("[|]")[0]));

				if (!Util.isnullParm("id_level", request))
					if (!request.getParameter("id_level").equals("-1"))
						res.setIdlevel(Integer.parseInt(request.getParameter("id_level")));

				res.setQtevents(Integer.parseInt(request.getParameter("qt_events")));
				res.setReference(request.getParameter("reference"));

				//Seta o http no reference, caso não exista
				
				
				if (!Util.isnullParm("id_method", request)){
					String[] sidmethods = request.getParameterValues("id_method");
					
					
					int[] idmethods = new int[sidmethods.length];
					
					for (int i = 0; i < sidmethods.length; i++) {
						
						idmethods[i] = Integer.parseInt(sidmethods[i]);
					} 
					
					res.setMethods(idmethods);
				}
				
				if (acao.equals("A"))
					rescon.atualizar(res);
				if (acao.equals("I"))
					rescon.incluir(res);
			}
			
		}
		catch (Exception e){
			out.print("-1|An error ocurred while saving result: ".concat(e.getMessage()));
			return;
		}
		
		out.print("0|Result successfully saved|0");
		return;		
	}
	

//	private boolean validar(Classe cl, PrintWriter out){
//		
//		if (Util.format(cl.getNmclasse()).equals("")){
//			out.print("-1|Enter a Class corretly");
//			return false;
//		}
//		
//		return true;
//	}
}
