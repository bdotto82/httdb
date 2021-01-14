package org.unipampa.db.conector;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

import org.dotto.util.NamedParameterStatement;
import org.dotto.util.Util;
import org.unipampa.cadastro.Organism;
import org.unipampa.cadastro.Parameter;
import org.unipampa.cadastro.htt.Result;
import org.unipampa.db.DBConn;

public class ParameterCon extends Conector {
	
	public ParameterCon() throws Exception{
		super();
	}

	public Parameter consultar() throws Exception{
		try{
			
			String sql = "select server, " + 
						 "       port,  " +
						 "       user,  " +
						 "       password,  " +
						 "       emailto,  " +
						 "       dsmainbanner, " +
						 "       dsciting " +
						 "  from parameter ";
			
			Statement st = conn.getConn().createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			Parameter ret = null;
			
			if (rs.next()) {
				ret = new Parameter();
				ret.setServer(rs.getString("server"));
				ret.setPort(rs.getString("port"));
				ret.setUser(rs.getString("user"));
				ret.setPassword(rs.getString("password"));
				ret.setEmailto(rs.getString("emailto"));
				ret.setDsmainbanner(rs.getString("dsmainbanner"));
				ret.setDsciting(rs.getString("dsciting"));
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
