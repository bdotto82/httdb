package org.unipampa.db.conector;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedHashSet;
import java.util.Set;

import org.unipampa.cadastro.Method;

public class MethodCon extends Conector {
	
	public MethodCon() throws Exception{
		super();
	}
	
	public Set listar() throws Exception{
		
		try{
			String sql = "select id_method, nm_method from method order by nm_method ";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Method method = new Method();
				method.setIdmethod(rs.getInt("id_method"));
				method.setNmmethod(rs.getString("nm_method"));
				
				set.add(method);
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
	
	public void incluir (Method met) throws Exception{
		
		try {
			
			String sql = "insert into method (id_method, nm_method) "
					+ " values(?,?) ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  getMaxId());
			setaValor(st, 2, met.getNmmethod());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void atualizar (Method met) throws Exception{
		
		try {
			
			String sql = "update method set  "
					+ " nm_method = ? " 
					+ " where id_method = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			setaValor(st, 1, met.getNmmethod());
			st.setInt(2,  met.getIdmethod());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void excluir (int idmethod) throws Exception{
		
		try {
			
			String sql = "delete from method "
					+ " where id_method = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  idmethod);
			
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

        ResultSet rs = st.executeQuery("SELECT ifnull(max(id_method), 0) + 1 FROM method "); 
         
        if (rs.next())   {
        	return rs.getInt(1);
        }
        else return 1;
		
	}	


}
