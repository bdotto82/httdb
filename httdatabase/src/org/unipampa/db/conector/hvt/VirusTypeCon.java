package org.unipampa.db.conector.hvt;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedHashSet;
import java.util.Set;

import org.unipampa.cadastro.hvt.VirusGroup;
import org.unipampa.cadastro.hvt.VirusType;
import org.unipampa.db.DBConn;
import org.unipampa.db.conector.Conector;

public class VirusTypeCon extends Conector {
	
	public VirusTypeCon() throws Exception{
		super();
	}
	
	public VirusTypeCon(DBConn conn) throws Exception{
		super(conn);
	}
	
	public Set listar() throws Exception{
		
		try{
			VirusGroupCon vgcon = new VirusGroupCon();

			String sql = "select id_virus_type, id_virus_group, ds_virus_type from virus_type order by ds_virus_type ";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();

			while (rs.next()){
				
				VirusType vtype = new VirusType();
				
				vtype.setIdvirustype(rs.getInt("id_virus_type"));
				vtype.setDsvirustype(rs.getString("ds_virus_type"));
				vtype.setVirusgroup(vgcon.consultar(rs.getInt("id_virus_group")));

				set.add(vtype);
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

	public VirusType consultar(int idvirustype) throws Exception{
		
		try{
			String sql = "select id_virus_type, id_virus_group, ds_virus_type from virus_type where id_virus_type = " + idvirustype;
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();

			VirusGroupCon vgcon = new VirusGroupCon(this.conn);
			
			VirusType vtype = null;
			
			if (rs.next()){
				
				vtype = new VirusType();
				
				vtype.setIdvirustype(rs.getInt("id_virus_type"));
				vtype.setDsvirustype(rs.getString("ds_virus_type"));
				vtype.setVirusgroup(vgcon.consultar(rs.getInt("id_virus_group")));

				set.add(vtype);
			}
			
			return vtype;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}
			
				
	}

}
