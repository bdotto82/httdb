package org.unipampa.db.conector.hvt;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedHashSet;
import java.util.Set;

import org.unipampa.cadastro.Level;
import org.unipampa.cadastro.hvt.VirusGroup;
import org.unipampa.db.DBConn;
import org.unipampa.db.conector.Conector;

public class VirusGroupCon extends Conector {
	
	public VirusGroupCon() throws Exception{
		super();
	}

	public VirusGroupCon(DBConn conn) throws Exception{
		super(conn);
	}

	public Set listar() throws Exception{
		
		try{
			String sql = "select id_virus_group, ds_virus_group from virus_group order by ds_virus_group ";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				VirusGroup virg  = new VirusGroup();
				virg.setIdvirusgroup(rs.getInt("id_virus_group"));
				virg.setDsvirusgroup(rs.getString("ds_virus_group"));
				
				set.add(virg);
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

	public VirusGroup consultar(int idvirusgroup) throws Exception{
		
		try{
			String sql = "select id_virus_group, ds_virus_group from virus_group where id_virus_group = " + idvirusgroup;
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			VirusGroup virg = null;
			
			if (rs.next()){
				virg  = new VirusGroup();
				virg.setIdvirusgroup(rs.getInt("id_virus_group"));
				virg.setDsvirusgroup(rs.getString("ds_virus_group"));
			}
			
			return virg;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}
				
	}

}
