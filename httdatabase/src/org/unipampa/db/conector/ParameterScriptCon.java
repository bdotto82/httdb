package org.unipampa.db.conector;

import java.sql.ResultSet;
import java.sql.Statement;

import org.unipampa.cadastro.ParameterScript;

public class ParameterScriptCon extends Conector {
	
	public ParameterScriptCon() throws Exception{
		super();
	}

	public ParameterScript consultar(int idscript) throws Exception{
		try{
			
			String sql = "select id_script, " + 
						 "       nm_script,  " +
						 "       dir_location,  " +
						 "       script_command,  " +
						 "       result_filename  " +
						 "  from parameter_script where id_script = " + idscript;
			
			Statement st = conn.getConn().createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			ParameterScript ret = null;
			
			if (rs.next()) {
				ret = new ParameterScript();
				ret.setIdscript(rs.getInt("id_script"));
				ret.setNmscript(rs.getString("nm_script"));
				ret.setDirlocation(rs.getString("dir_location"));
				ret.setScriptcommand(rs.getString("script_command"));
				ret.setResultfilename(rs.getString("result_filename"));
			}
			
			return ret;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}

	}
		
}
