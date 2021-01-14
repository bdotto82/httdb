package org.unipampa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.unipampa.db.conector.UsuarioCon;

/**
 * Servlet implementation class ValidaLogin
 */
@WebServlet("/ValidaLogin")
public class ValidaLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidaLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8"); 
		PrintWriter out = response.getWriter();  
		
		try {
			
			UsuarioCon ucon = new UsuarioCon();
			
			if (ucon.validarLogin(request.getParameter("nm_usuario"), request.getParameter("ds_senha"))){
				
				request.getSession().setAttribute("loguser", request.getParameter("nm_usuario"));
				
				out.print("1|Login ok");
				request.getSession().setAttribute("id_sessao", request.getSession().getId());
			}
					
			out.print("0|Login incorrect");
			
		} catch (Exception e) {
			out.print("0|An error occur when saving Ocorreu um erro ao efetuar o login: ".concat(e.getMessage()));
			return;
		}
			
	}

}
