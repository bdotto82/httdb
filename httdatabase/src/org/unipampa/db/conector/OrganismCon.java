package org.unipampa.db.conector;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.unipampa.cadastro.Level;
import org.unipampa.cadastro.Organism;
import org.unipampa.cadastro.hvt.Virus;

public class OrganismCon extends Conector {
	
	public OrganismCon() throws Exception{
		super();
	}
	
public Set listar() throws Exception{
		
		try{
			String sql = "select o.id_organism, o.nm_organism, o.id_organism_level, l.nm_level, o.ds_organism_taxonomy "
					+ "     from organism o "
					+ "    inner join level l "
					+ "       on o.id_organism_level = l.id_level "
					+ "    order by l.id_level, o.nm_organism ";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Organism org = new Organism();
				org.setIdorganism(rs.getInt("id_organism"));
				org.setNmorganism(rs.getString("nm_organism"));
				org.setIdorganismlevel(rs.getInt("id_organism_level"));
				org.setNmorganismlevel(rs.getString("nm_level"));
				org.setDsorganismtaxonomy(rs.getString("ds_organism_taxonomy"));
				
				set.add(org);
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

	public String getNmGroup(String nmorganism, int index) throws Exception{
		
		try{
			String sql = "select ds_organism_taxonomy  " +
					 "  from organism o " +
					 " where o.ds_organism_taxonomy like '%;" + nmorganism + "%'";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			String group = "none";
			
			if (rs.next()){
				String[] dsorgtax = rs.getString(1).split("[;]");
				
				group = dsorgtax[index];
				
				if (group.equals("-"))
					group = "none";
				
			}
			
			return group.toUpperCase();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}
				
	}
	
	public Set listarTaxonomy() throws Exception{
		
		try{

			String sql = "select distinct SPLIT_STRING(';',ds_organism_taxonomy, ?) as dsorg from organism order by dsorg";			
			
			PreparedStatement st = conn.getConn().prepareStatement(sql);

			ResultSet rs = null;
			
			Set set = new LinkedHashSet();
			
			String[] nmlevel = {"Superkingdom", "Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species"};
			String[] nmorg = {"", "", "", "", "", "", "", ""};
			
			ArrayList<String> ar = new ArrayList<String>();
			
			for (int j=0; j < 8; j++){
				
				if (rs != null && !rs.isClosed())
					rs.close();
				
				st.setInt(1, j + 1);
				rs = st.executeQuery();
				
				while (rs.next()){
	
					if (!rs.getString(1).trim().equals("")) {
						Organism org = new Organism();
						org.setIdorganism(1);
						org.setNmorganism(rs.getString(1).trim());
						org.setIdorganismlevel(8 - j);
						org.setNmorganismlevel(nmlevel[j]);
						
						set.add(org);
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

	public void incluir (Organism org) throws Exception{
		
		try {
			
			String sql = "insert into organism (id_organism, nm_organism, id_organism_level, ds_organism_taxonomy) "
					+ " values(?,?,?,?) ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  getMaxId());
			setaValor(st, 2, org.getNmorganism());
			setaValor(st, 3, org.getIdorganismlevel());
			setaValor(st, 4, org.getDsorganismtaxonomy());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void atualizar (Organism org) throws Exception{
		
		try {
			
			String sql = "update organism set  "
					+ " nm_organism = ?, id_organism_level = ?, ds_organism_taxonomy = ? " 
					+ " where id_organism = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			setaValor(st, 1, org.getNmorganism());
			setaValor(st, 2, org.getIdorganismlevel());
			setaValor(st, 3, org.getDsorganismtaxonomy());
			st.setInt(4,  org.getIdorganism());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void excluir (int idorganism) throws Exception{
		
		try {
			
			String sql = "delete from organism "
					+ " where id_organism = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  idorganism);
			
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

        ResultSet rs = st.executeQuery("SELECT ifnull(max(id_organism), 0) + 1 FROM organism "); 
         
        if (rs.next())   {
        	return rs.getInt(1);
        }
        else return 1;
		
	}	

	public void listarTaxonomyTree(int nivel, String pesq, Object json) throws Exception{
		
		try{

			Set set = getTaxonomy(nivel, pesq);
			
			Iterator it = set.iterator();

			JSONArray jartemp = new JSONArray();

			while (it.hasNext()){
				String nmorg = (String)it.next();
				
				JSONObject jobj = new JSONObject();
				jobj.put("id", "1|" + (nivel) + "|" + nmorg);
				jobj.put("text", nmorg.split("[|]")[0]);
				jobj.put("state", "closed");
				
				//listarTaxonomyTree(nivel + 1, nmorg, jobj);

				jartemp.add(jobj);
				
				//if (nivel == 1)
					((JSONArray)json).add(jobj);
				//else
				//	((JSONObject)json).put("children", jartemp);

			}
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}
				
	}	
	
	private Set getTaxonomy(int nivel, String pesq) throws Exception{
		
		try{
			String sql = "select distinct SPLIT_STRING(';',ds_organism_taxonomy, ?) as dsorg, substring_index(ds_organism_taxonomy, ';', ?)  from organism where ds_organism_taxonomy like '%" + pesq + "%' order by dsorg";			

	
			PreparedStatement st = conn.getConn().prepareStatement(sql);
	
			ResultSet rs = null;
			
			Set set = new LinkedHashSet();
			
			st.setInt(1, nivel);
			st.setInt(2, nivel);
	
			rs = st.executeQuery();
				
			while (rs.next()){
				
				if (!rs.getString(1).trim().equals("")) {
					
					set.add(rs.getString(1) + "|" + rs.getString(2));
					
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
