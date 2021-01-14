package org.unipampa.db.conector;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedHashSet;
import java.util.Set;

import org.unipampa.cadastro.Level;

public class LevelCon extends Conector {
	
	public LevelCon() throws Exception{
		super();
	}
	
	public Set listar() throws Exception{
		
		try{
			String sql = "select id_level, nm_level from level order by id_level ";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Level lev = new Level();
				lev.setIdlevel(rs.getInt("id_level"));
				lev.setNmlevel(rs.getString("nm_level"));
				
				set.add(lev);
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
	
	public void incluir (Level lev) throws Exception{
		
		try {
			
			String sql = "insert into level (id_level, nm_level) "
					+ " values(?,?) ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  getMaxId());
			setaValor(st, 2, lev.getNmlevel());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void atualizar (Level lev) throws Exception{
		
		try {
			
			String sql = "update level set  "
					+ " nm_level = ? " 
					+ " where id_level = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			setaValor(st, 1, lev.getNmlevel());
			st.setInt(2,  lev.getIdlevel());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void excluir (int idlevel) throws Exception{
		
		try {
			
			String sql = "delete from level "
					+ " where id_level = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  idlevel);
			
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

        ResultSet rs = st.executeQuery("SELECT ifnull(max(id_level), 0) + 1 FROM level "); 
         
        if (rs.next())   {
        	return rs.getInt(1);
        }
        else return 1;
		
	}	


}
