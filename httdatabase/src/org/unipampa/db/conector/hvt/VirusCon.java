package org.unipampa.db.conector.hvt;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.unipampa.cadastro.Level;
import org.unipampa.cadastro.hvt.Virus;
import org.unipampa.cadastro.hvt.VirusGroup;
import org.unipampa.cadastro.hvt.VirusType;
import org.unipampa.db.DBConn;
import org.unipampa.db.conector.Conector;

public class VirusCon extends Conector {

	public VirusCon() throws Exception {
		super();
	}

	public VirusCon(DBConn conn) throws Exception {
		super(conn);
	}
	
	public Set listarTaxonomy(HashMap filter) throws Exception{
		
		try{

			String sql = "select distinct SPLIT_STRING(';',ds_virus_taxonomy, ?) as dsvirus from virus order by dsvirus";			
			
			PreparedStatement st = conn.getConn().prepareStatement(sql);

			ResultSet rs = null;
			
			Set set = new LinkedHashSet();
			
			String[] nmlevel = {"Order", "Family", "Genus", "Species"};
			int[] idlevel = {5, 6, 7, 8};
			
			ArrayList<String> ar = new ArrayList<String>();
			
			for (int j=0; j < 4; j++){
				
				if (rs != null && !rs.isClosed())
					rs.close();
				
				st.setInt(1, j + 1);
				rs = st.executeQuery();
				
				while (rs.next()){
	
					if (!rs.getString(1).trim().equals("")) {
						Virus virus = new Virus();
						virus.setIdvirus(1);
						virus.setNmvirus(rs.getString(1).trim());
						
						Level lv = new Level();
						lv.setIdlevel(idlevel[j]);
						lv.setNmlevel(nmlevel[j]);
						
						virus.setViruslevel(lv);
						set.add(virus);
						
					}
						
				}
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
	
	public Virus consultar(int idvirus) throws Exception{
		
		try{
			
			String sql = "select v.id_virus, v.id_virus_type, v.nm_virus, v.ds_virus_taxonomy, v.id_virus_level " +
			             "       vg.id_virus_group, vg.ds_virus_group, " + 
					     "       vt.ds_virus_type, "  +
			             "       l.nm_level " + 
			             "  from virus v" + 
					     " inner join level l " + 
			             "         on v.id_virus_level = l.id_level " +
					     "  left join virus_type vt " + 
			             "         on vt.id_virus_type = v.id_virus_type " + 
					     " inner join virus_group vg " + 
			             "         on vt.id_virus_group = vg.id_virus_group " +
			             " where v.id_virus = " + idvirus;

			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();

			Virus virus = null;
			
			if (rs.next()){
				
				virus = new Virus();
				
				virus.setIdvirus(rs.getInt("id_virus"));
				virus.setNmvirus(rs.getString("nm_virus"));
				virus.setDsvirustaxonomy(rs.getString("ds_virus_taxonomy"));
				
				if (rs.getInt("id_virus_type") > 0){				
					VirusType vt = new VirusType();
					vt.setIdvirustype(rs.getInt("id_virus_type"));
					vt.setDsvirustype(rs.getString("ds_virus_type"));
					
					if (rs.getInt("id_virus_group") > 0){				
						VirusGroup vg = new VirusGroup();
						vg.setIdvirusgroup(rs.getInt("id_virus_group"));
						vg.setDsvirusgroup("ds_virus_group");
						
						vt.setVirusgroup(vg);
					}
					
					virus.setVirustype(vt);
				}
				
				if (rs.getInt("id_virus_level") > 0){	
					Level lv = new Level();
					
					lv.setIdlevel(rs.getInt("id_virus_level"));
					lv.setNmlevel(rs.getString("nm_level"));
				
					virus.setViruslevel(lv);
				}
				
			}
			
			return virus;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}
				
	}
	
	
	public void listarVirusTaxonomyJSON(int nivel, String pesq, Object json, String filtrotype) throws Exception{
		
		try{

			Set set = getTaxonomy(nivel, pesq, filtrotype);
			
			Iterator it = set.iterator();

			JSONArray jartemp = new JSONArray();
			
			int[] idlevel = {5, 6, 7, 8};
			
			while (it.hasNext()){
				String nmvirus = (String)it.next();
				
				JSONObject jobj = new JSONObject();
				jobj.put("id", "1|" + (idlevel[nivel - 1]) + "|" + nmvirus);
				jobj.put("text", nmvirus);

				listarVirusTaxonomyJSON(nivel + 1, nmvirus, jobj, filtrotype);

				jartemp.add(jobj);
				
				if (nivel == 1)
					((JSONArray)json).add(jobj);
				else
					((JSONObject)json).put("children", jartemp);

			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}
				
	}	
	
	private Set getTaxonomy(int nivel, String pesq, String filtrotype) throws Exception{
		
		try{
			String sql = "select distinct SPLIT_STRING(';',ds_virus_taxonomy, ?) as dsvirus " + 
					"       from virus " + 
					"      where ds_virus_taxonomy  like '%" + pesq + "%' " + 
	                "    and (id_virus_type in (" + filtrotype + ") or '" + filtrotype + "' in('0', '-1'))" +  
					"      order by dsvirus";			
	
			PreparedStatement st = conn.getConn().prepareStatement(sql);
	
			ResultSet rs = null;
			
			Set set = new LinkedHashSet();
			
			st.setInt(1, nivel);
	
			rs = st.executeQuery();
				
			while (rs.next()){
	
				if (!rs.getString(1).trim().equals("")) {
					
					set.add(rs.getString(1));
					
				}
					
			}
			
			rs.close();
			rs = null;
			
			return set;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}		
	}

}
