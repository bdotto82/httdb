package org.unipampa.db.conector.htt;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedHashSet;
import java.util.Set;

import org.unipampa.cadastro.htt.Classe;
import org.unipampa.db.conector.Conector;

public class ClasseCon extends Conector {
	
	public ClasseCon() throws Exception{
		super();
	}
	
	public Set listar() throws Exception{
		
		try{
			String sql = "select id_classe, nm_classe from classe order by nm_classe ";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Classe classe = new Classe();
				classe.setIdclasse(rs.getInt("id_classe"));
				classe.setNmclasse(rs.getString("nm_classe"));
				
				set.add(classe);
			}
			
			return set;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}
				
	}

	public void incluir (Classe cl) throws Exception{
		
		try {
			
			String sql = "insert into classe (id_classe, "
					+ " nm_classe) "
					+ " values(?,?) ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  getMaxId());
			setaValor(st, 2, cl.getNmclasse());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void atualizar (Classe cl) throws Exception{
		
		try {
			
			String sql = "update classe set  "
					+ " nm_classe = ? "
					+ " where id_classe = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			setaValor(st, 1, cl.getNmclasse());
			st.setInt(2,  cl.getIdclasse());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void excluir (int idclasse) throws Exception{
		
		try {
			
			String sql = "delete from classe "
					+ " where id_classe = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  idclasse);
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	private int getMaxId() throws Exception{
        Statement st = conn.getConn().createStatement();  

        ResultSet rs = st.executeQuery("SELECT ifnull(max(id_classe), 0) + 1 FROM classe "); 
         
        if (rs.next())   {
        	return rs.getInt(1);
        }
        else return 1;
		
	}	

}
