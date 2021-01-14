package org.unipampa.db.conector;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedHashSet;
import java.util.Set;

import org.unipampa.cadastro.OrganismRelation;
import org.unipampa.cadastro.htt.Classe;

public class OrganismRelationCon extends Conector {
	
	public OrganismRelationCon() throws Exception{
		super();
	}
	
	public Set listar() throws Exception{
		
		try{
			String sql = "select id_organism_relation, ds_organism_relation from organism_relation order by ds_organism_relation ";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				OrganismRelation orgrel = new OrganismRelation();
				orgrel.setIdorganismrelation(rs.getInt("id_organism_relation"));
				orgrel.setDsorganismrelation(rs.getString("ds_organism_relation"));
				
				set.add(orgrel);
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

	public void incluir (OrganismRelation or) throws Exception{
		
		try {
			
			String sql = "insert into organism_relation (id_organism_relation, "
					+ " ds_organism_relation) "
					+ " values(?,?) ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  getMaxId());
			setaValor(st, 2, or.getDsorganismrelation());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void atualizar (OrganismRelation or) throws Exception{
		
		try {
			
			String sql = "update organism_relation set  "
					+ " ds_organism_relation = ? "
					+ " where id_organism_relation = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			setaValor(st, 1, or.getDsorganismrelation());
			st.setInt(2,  or.getIdorganismrelation());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void excluir (int idorgrelation) throws Exception{
		
		try {
			
			String sql = "delete from organism_relation "
					+ " where id_organism_relation = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  idorgrelation);
			
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

        ResultSet rs = st.executeQuery("SELECT ifnull(max(id_organism_relation), 0) + 1 FROM organism_relation"); 
         
        if (rs.next())   {
        	return rs.getInt(1);
        }
        else return 1;
		
	}	

}
