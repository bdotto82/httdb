package org.unipampa.db.conector;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedHashSet;
import java.util.Set;

import org.unipampa.cadastro.htt.Classe;

public class UsuarioCon extends Conector {
	
	public UsuarioCon() throws Exception{
		super();
	}
	
	public boolean validarLogin(String nmusuario, String dssenha) throws Exception{
		
		try{

			String sql = " SELECT ds_password, password(?) " +
					" FROM usuario "+
					" WHERE nm_user = ? ";

			PreparedStatement st = conn.getConn().prepareStatement(sql);

			setaValor(st, 1, dssenha);
			setaValor(st, 2, nmusuario);
			
			ResultSet rs = st.executeQuery();
			
			if (rs.next()){
				if (rs.getString(1).equals(rs.getString(2)) )
					return true;
				else
					return false;
			}
			else
				return false;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}
				
	}


}
