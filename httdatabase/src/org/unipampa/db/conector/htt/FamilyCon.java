package org.unipampa.db.conector.htt;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Set;

import org.dotto.util.Util;
import org.unipampa.cadastro.htt.Family;
import org.unipampa.db.conector.Conector;

public class FamilyCon extends Conector {
	
	public FamilyCon() throws Exception{
		super();
	}
	
	public Set listar(String filtroclasse, String filtrosuperfamily) throws Exception{
		
		try{
			
			if (Util.format(filtroclasse).equals("")) filtroclasse = "0";
			if (Util.format(filtrosuperfamily).equals("")) filtrosuperfamily = "0";
			
			String sql = " select f.id_family, "
					+    "        f.nm_family, "
					+    "        f.id_superfamily, "
					+    "        sf.id_classe, "
					+    "        sf.nm_superfamily"
					+    "   from family f "
					+    "   left join superfamily sf "
					+    "     on sf.id_superfamily = f.id_superfamily "
	                +    "  where (sf.id_classe in (" + filtroclasse + ") or '" + filtroclasse + "' in('0', '-1'))" 
	                +    "    and (f.id_superfamily in (" + filtrosuperfamily+ ") or '" + filtrosuperfamily + "' in('0', '-1'))" 
					+    "  order by sf.id_superfamily, f.nm_family ";

			Statement st = conn.getConn().createStatement();

			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Family fam = new Family();
				fam.setIdfamily(rs.getInt("id_family"));
				fam.setNmfamily(rs.getString("nm_family"));
				fam.setIdsuperfamily(rs.getInt("id_superfamily"));
				fam.setIdclasse(rs.getInt("id_classe"));
				fam.setNmsuperfamily(rs.getString("nm_superfamily"));
				set.add(fam);
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

	public String getGraphicData(int idsuperfamily, int qttotal) throws Exception{
		try {
			
			String sql = " select c.id_classe, nm_classe, sf.id_superfamily, sf.nm_superfamily, f.id_family, f.nm_family, " + 
					    "       (select sum(qt_events) " + 
					    "          from result r " + 
					    "         where r.id_superfamily = sf.id_superfamily " +
					    "           and r.id_family = f.id_family) as qt_events " + 
					    "   from family f " + 
				        "  inner join superfamily sf  " + 
				        "     on sf.id_superfamily = f.id_superfamily " + 
				        "  inner join classe c  " + 
				        "     on sf.id_classe = c.id_classe " + 
				        "  where f.id_superfamily = " + idsuperfamily + 
				        "  group by f.id_family, f.nm_family order by f.nm_family "; 

			Statement st = conn.getConn().createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			HashMap map = new HashMap();
			
			String ret1 = "[";
			int qtfam = 0;
			
			while (rs.next()){
				ret1 = ret1.concat("{\"name\":\"").concat(rs.getString("nm_family").trim()).concat("(").concat(Integer.toString(rs.getInt("qt_events"))).concat(")")
						.concat("\",\"y\":" + Integer.toString(rs.getInt("qt_events")))   
						.concat(", \"url\":\"?class=").concat(Integer.toString(rs.getInt("id_classe"))).concat("&superfamily=").concat(Integer.toString(rs.getInt("id_superfamily"))).concat("&family=").concat(Integer.toString(rs.getInt("id_family"))).concat("\"")
						.concat(",\"id\":" + Integer.toString(rs.getInt("id_family")))   
						.concat("}");
				if (!rs.isLast())
					ret1 = ret1.concat(",");
				
				qtfam = qtfam + rs.getInt("qt_events");
			}
			
			//Adiciona os dados do total, ou a diferença como "Not informed"
			if (qtfam < qttotal){
				if (qtfam > 0)
					ret1 = ret1.concat(",");
				ret1 = ret1.concat("{\"name\":\"Not informed").concat("(").concat(Integer.toString(qttotal - qtfam)).concat(")")
						.concat("\",\"y\":" + Integer.toString(qttotal - qtfam))   
						.concat(",\"id\":-1")   
						.concat("}");
			} 
			
			ret1 = ret1.concat("]");

			
			return ret1;
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
	}
	
	public void incluir (Family fam) throws Exception{
		
		try {
			
			String sql = "insert into family (id_family, id_superfamily, nm_family) "
					+ " values(?,?,?) ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  getMaxId());
			st.setInt(2, fam.getIdsuperfamily());
			setaValor(st, 3, fam.getNmfamily());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void atualizar (Family fam) throws Exception{
		
		try {
			
			String sql = "update family set  "
					+ " nm_family = ?, " 
					+ " id_superfamily = ? "
					+ " where id_family = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			setaValor(st, 1, fam.getNmfamily());
			st.setInt(2,  fam.getIdsuperfamily());
			st.setInt(3,  fam.getIdfamily());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void excluir (int idfamily) throws Exception{
		
		try {
			
			String sql = "delete from family "
					+ " where id_family = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  idfamily);
			
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

        ResultSet rs = st.executeQuery("SELECT ifnull(max(id_family), 0) + 1 FROM family "); 
         
        if (rs.next())   {
        	return rs.getInt(1);
        }
        else return 1;
		
	}	


}
