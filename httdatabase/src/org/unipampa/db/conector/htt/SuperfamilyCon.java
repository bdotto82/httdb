package org.unipampa.db.conector.htt;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Set;

import org.dotto.util.Util;
import org.unipampa.cadastro.htt.Superfamily;
import org.unipampa.db.DBConn;
import org.unipampa.db.conector.Conector;

public class SuperfamilyCon extends Conector {
	
	public SuperfamilyCon() throws Exception{
		super();
	}
	
	public Set listar(String filtroclasse) throws Exception{
		
		try{
			
			if (Util.format(filtroclasse).equals("")) filtroclasse = "0";
			
			String sql = " select sf.id_superfamily, "
					+ "           sf.nm_superfamily, "
					+ "           sf.id_classe, "
					+ "           c.nm_classe "
					+ "      from superfamily sf " 
					+ "     inner join classe c " 
					+ "        on c.id_classe = sf.id_classe "
		            + "     where (sf.id_classe in (" + filtroclasse + ") or '" + filtroclasse + "' in('0', '-1'))"  
		            +     " order by c.id_classe, nm_superfamily ";
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Superfamily sf = new Superfamily();
				sf.setIdsuperfamily(rs.getInt("id_superfamily"));
				sf.setNmsuperfamily(rs.getString("nm_superfamily"));
				sf.setIdclasse(rs.getInt("id_classe"));
				sf.setNmclasse(rs.getString("nm_classe"));
				
				set.add(sf);
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
	
	public void incluir (Superfamily sf) throws Exception{
		
		try {
			
			String sql = "insert into superfamily (id_superfamily, "
					+ " nm_superfamily,"
					+ " id_classe) "
					+ " values(?,?,?) ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  getMaxId());
			setaValor(st, 2, sf.getNmsuperfamily());
			st.setInt(3,  sf.getIdclasse());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void atualizar (Superfamily sf) throws Exception{
		
		try {
			
			String sql = "update superfamily set  "
					+ " nm_superfamily = ?, " 
					+ " id_classe = ? "
					+ " where id_superfamily = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			setaValor(st, 1, sf.getNmsuperfamily());
			st.setInt(2,  sf.getIdclasse());
			st.setInt(3,  sf.getIdsuperfamily());
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void excluir (int idsuperfamily) throws Exception{
		
		try {
			
			String sql = "delete from superfamily "
					+ " where id_superfamily = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			st.setInt(1,  idsuperfamily);
			
			st.executeUpdate();
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}
	
	public HashMap getGraphicData() throws Exception{
		try {
			
			String sql = " select c.id_classe, nm_classe, " + 
				         "        count(1) as qt, " +
			             "       (select sum(qt_events) from result where id_classe = c.id_classe) as qt_events " + 
				         "   from classe c " + 
				         "  inner join superfamily sf  " + 
				         "     on c.id_classe = sf.id_classe " + 
				         "  group by c.id_classe, nm_classe order by nm_classe "; 

			Statement st = conn.getConn().createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			HashMap map = new HashMap();
			
			String ret1 = "[";
			
			while (rs.next()){
				ret1 = ret1.concat("{name:\"").concat(rs.getString("nm_classe").trim()).concat("(").concat(Integer.toString(rs.getInt("qt_events"))).concat(")")
						.concat("\",y: " + Integer.toString(rs.getInt("qt")) +", color: Highcharts.Color(Highcharts.getOptions().colors[" + rs.getInt("id_classe") + "]).brighten((-2) / 12).get()")
						.concat(", url:\"?class=").concat(Integer.toString(rs.getInt("id_classe"))).concat("\"}");
//				ret1 = ret1.concat("[\"").concat(rs.getString("nm_classe").trim()).concat("\",");
	//			ret1 = ret1.concat().concat("]");
				if (!rs.isLast())
					ret1 = ret1.concat(",");
			}
			
			ret1 = ret1.concat("]");
			map.put("ret1", ret1);
			
			sql =    " select c.id_classe, nm_classe, " + 
			         "        nm_superfamily, id_superfamily, " + 
		             "       (select sum(qt_events) from result where id_superfamily = sf.id_superfamily) as qt_events " + 
			         "   from classe c " + 
			         "  inner join superfamily sf  " + 
			         "     on c.id_classe = sf.id_classe " + 
			         "  order by nm_classe asc, qt_events desc, nm_superfamily, id_superfamily asc"; 

			rs = st.executeQuery(sql);
			
			String ret2 = "[";

			int i=0;
			int idclasse = 0;
			
			while (rs.next()){
				if (rs.getInt("id_classe") != idclasse){
					i = 0;
					idclasse = rs.getInt("id_classe");
				}
				ret2 = ret2.concat("{name:\"").concat(rs.getString("nm_superfamily").trim()).concat("(").concat(Integer.toString(rs.getInt("qt_events"))).concat(")")
						.concat("\",y: 1, color: Highcharts.Color(Highcharts.getOptions().colors[" + rs.getInt("id_classe")   + "]).brighten((" + i + " - 2) / 18).get() ")
						.concat(", url:\"?class=").concat(Integer.toString(rs.getInt("id_classe"))).concat("&superfamily=").concat(Integer.toString(rs.getInt("id_superfamily"))).concat("\"")
						.concat(", id:").concat(Integer.toString(rs.getInt("id_superfamily")))
						.concat(", qt:" + Integer.toString(rs.getInt("qt_events"))) 
						.concat("}");
				if (!rs.isLast())
					ret2 = ret2.concat(",");
				i++;

			}
			
			ret2 = ret2.concat("]");
			
//			System.out.println(ret2);
			
			map.put("ret2", ret2);
			
			return map;
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
	}

	private int getMaxId() throws Exception{
        Statement st = conn.getConn().createStatement();  

        ResultSet rs = st.executeQuery("SELECT ifnull(max(id_superfamily), 0) + 1 FROM superfamily "); 
         
        if (rs.next())   {
        	return rs.getInt(1);
        }
        else return 1;
		
	}	

}
