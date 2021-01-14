package org.unipampa.db.conector.htt;

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
import org.unipampa.cadastro.htt.Result;
import org.unipampa.db.DBConn;
import org.unipampa.db.conector.Conector;

public class ResultCon extends Conector {
	
	public ResultCon() throws Exception{
		super();
	}
	
	private String getSqlOrganismTaxonomy(String organism){
		String org[];
		String sqlorg = "";
		
		if (!organism.equals("0")){
			org = organism.split("[,]");
		
			sqlorg = "and (";
			
			for (int i = 0; i < org.length; i++) {
				if (i > 0) sqlorg = sqlorg.concat(" or ");
				sqlorg = sqlorg.concat("o.ds_organism_taxonomy like '%").concat(org[i].concat("%'"));
			}

			sqlorg = sqlorg.concat(")");
		}

		return sqlorg;
	}

	public Set listartabela(Map parm) throws Exception{
		
		try{
			
			String sqlorg = getSqlOrganismTaxonomy((String)parm.get("id_organism"));
			
			String sql = " select r.id_result, " + 
					"             c.nm_classe, " + 
					"             sf.nm_superfamily, " +  
					"             f.nm_family,  " + 
					"             o.nm_organism,  " + 
					"             ol.nm_level as nm_organism_level,  " + 
					"             l.nm_level,  " + 
					"             r.qt_events, " + 
					"             r.reference, " +
					"             r.year_published, " +
					"             orgr.ds_organism_relation, " +
					"             r.dt_estimates_htt, " +
					"             v.nm_vector, " + 
					"             hi.ds_host_impact, " +
					"             r.ncbi_link, " + 
					"             r.repbase_link " + 
					"        from result r " + 
					"   left join classe c " +  
					"          on c.id_classe = r.id_classe " + 
					"   left join superfamily sf " + 
					"          on sf.id_superfamily = r.id_superfamily " + 
					"   left join family f " + 
					"          on f.id_family = r.id_family " + 
					"   left join organism o " + 
					"          on o.id_organism = r.id_organism " + 
					"   left join level ol " +
					"          on ol.id_level = o.id_organism_level " +
					"   left join level l " + 
					"          on l.id_level = r.id_level " +
					"   left join organism_relation orgr " +  
					"          on orgr.id_organism_relation = r.id_organism_relation " + 
					"   left join vector v " +  
					"          on v.id_vector = r.id_vector " + 
					"   left join host_impact hi " +  
					"          on hi.id_host_impact = r.id_host_impact " + 
					"     where (ifnull(r.id_classe, -1) in (" + (String)parm.get("id_classe") + ") or :id_classe = '0')" +
			        "       and (ifnull(r.id_superfamily, -1) in (" + (String)parm.get("id_superfamily") + ") or :id_superfamily = '0')" +
	                "       and (ifnull(r.id_family, -1) in (" + (String)parm.get("id_family") + ") or :id_family = '0')" +
	                "       and (ifnull(r.id_organism_relation, -1) in (" + (String)parm.get("id_organism_relation") + ") or :id_organism_relation = '0')" +
					sqlorg + 
					"       and (ifnull(r.id_level, -1) in (" + (String)parm.get("id_level") + ") or :id_level = '0')"; 
//					"       and (exists(select 1 from result_method rm where rm.id_result = r.id_result and rm.id_method in (" + (String)parm.get("id_methods") + ")) or :id_methods = '0')";
			
			NamedParameterStatement st = new NamedParameterStatement(conn.getConn(), sql);
			
			st.setString("id_classe", (String)parm.get("id_classe"));
			st.setString("id_superfamily", (String)parm.get("id_superfamily"));
			st.setString("id_family", (String)parm.get("id_family"));
			st.setString("id_level", (String)parm.get("id_level"));
			st.setString("id_organism_relation", (String)parm.get("id_organism_relation"));
			
			ResultSet rs = st.executeQuery();
			ResultSet rs2 = null;
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Map res = new HashMap<>();
				
				res.put("nm_classe",  rs.getString("nm_classe")); 
				res.put("nm_superfamily",  rs.getString("nm_superfamily"));
				res.put("nm_family",  rs.getString("nm_family")); 
				res.put("nm_organism",  rs.getString("nm_organism")); 
				res.put("nm_organism_level",  rs.getString("nm_organism_level")); 
				res.put("nm_level",  rs.getString("nm_level"));
				res.put("qt_events",  rs.getInt("qt_events"));
				res.put("reference",  rs.getString("reference"));
				res.put("referenceHTML", Util.format(rs.getString("reference")).replaceAll("\\r\\n|\\r|\\n", "<BR>"));
				res.put("id_result",  rs.getInt("id_result"));
				res.put("year_published", rs.getInt("year_published"));
				res.put("ds_organism_relation", rs.getString("ds_organism_relation"));
				res.put("dt_estimates_htt", rs.getString("dt_estimates_htt"));
				res.put("nm_vector", rs.getString("nm_vector"));
				res.put("ds_host_impact", rs.getString("ds_host_impact"));

				res.put("ncbi_link", rs.getString("ncbi_link"));
				res.put("ncbiHTML", Util.format(rs.getString("ncbi_link")).replaceAll("\\r\\n|\\r|\\n", "<BR>"));

				res.put("repbase_link", rs.getString("repbase_link"));
				res.put("repbaseHTML", Util.format(rs.getString("repbase_link")).replaceAll("\\r\\n|\\r|\\n", "<BR>"));

				String stringmethods = "";
				
				sql = " select m.id_method, m.nm_method from result_method rm " +
				" inner join method m on rm.id_method = m.id_method " +
				" where rm.id_result = " + rs.getInt("id_result");
				
				rs2 = conn.getConn().createStatement().executeQuery(sql);
				
				while (rs2.next()){
					stringmethods = stringmethods.concat(rs2.getString("nm_method"));
					if (!rs2.isLast()) stringmethods = stringmethods.concat("; ");
				}

				res.put("nm_methods", stringmethods);
				
				set.add(res);
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

	public Set montargrafico(Map parm) throws Exception{
		
		try{
			String sql = "";

			String sqlorg = getSqlOrganismTaxonomy((String)parm.get("id_organism"));

			String[] tipos = ((String)parm.get("tipo")).split("[|]");
			String tipo = tipos[0];
			
			String sqlwhere = "        from result r " + 
							  "   left join classe c " +  
							  "          on c.id_classe = r.id_classe " + 
							  "   left join superfamily sf " + 
							  "          on sf.id_superfamily = r.id_superfamily " + 
							  "   left join family f " + 
							  "          on f.id_family = r.id_family " + 
							  "   left join organism o " + 
							  "          on o.id_organism = r.id_organism " + 
							  "   left join level ol " +
							  "          on ol.id_level = o.id_organism_level " +
							  "   left join level l " + 
							  "          on l.id_level = r.id_level " +
							  "   left join organism_relation orgr " +  
							  "          on orgr.id_organism_relation = r.id_organism_relation " + 
				              "     where (ifnull(r.id_classe, -1) in (" + (String)parm.get("id_classe") + ") or :id_classe = '0')" +
							  "       and (ifnull(r.id_superfamily, -1) in (" + (String)parm.get("id_superfamily") + ") or :id_superfamily = '0')" +
							  "       and (ifnull(r.id_family, -1) in (" + (String)parm.get("id_family") + ") or :id_family = '0')" +
							  sqlorg +
							  "       and (ifnull(r.id_level, -1) in (" + (String)parm.get("id_level") + ") or :id_level = '0')" +
				              "       and (ifnull(r.id_organism_relation, -1) in (" + (String)parm.get("id_organism_relation") + ") or :id_organism_relation = '0')" +
				              "       and (exists(select 1 from result_method rm where rm.id_result = r.id_result and rm.id_method in (" + (String)parm.get("id_methods") + ")) or :id_methods = '0')";
			
			if (tipo.equals("classe"))
				sql = " select r.id_classe, " +
    		          "        ifnull(c.nm_classe, 'Not Informed'), " + 
		              "        sum(qt_events) as qt_events " + 
    		          sqlwhere +
    		          "  group by r.id_classe ";
			else if(tipo.equals("superfamily"))
				sql = " select r.id_superfamily, " +
	    		      "        ifnull(sf.nm_superfamily, 'Not Informed'), " + 
			          "        sum(qt_events) as qt_events " + 
	    		      sqlwhere +
	    		      "  group by r.id_superfamily ";
			else if(tipo.equals("family"))
				sql = " select r.id_family, " +
	    		      "        ifnull(f.nm_family, 'Not Informed'), " + 
			          "        sum(qt_events) as qt_events " + 
	    		      sqlwhere +
	    		      "  group by r.id_family ";
			else if(tipo.equals("level"))
				sql = " select r.id_level, " +
	    		      "        ifnull(l.nm_level, 'Not Informed'), " + 
			          "        sum(qt_events) as qt_events " + 
	    		      sqlwhere +
	    		      "  group by r.id_level ";
			else if(tipo.equals("relation"))
				sql = " select r.id_organism_relation, " +
	    		      "        ifnull(orgr.ds_organism_relation, 'Not Informed'), " + 
			          "        sum(qt_events) as qt_events " + 
	    		      sqlwhere +
	    		      "  group by r.id_organism_relation ";
			else if(tipo.equals("organism"))
				sql = getOrganismChartSQL(tipos, sqlwhere);

			sql = sql + " order by 3 desc";
			
			NamedParameterStatement st = new NamedParameterStatement(conn.getConn(), sql);
			
			st.setString("id_classe", (String)parm.get("id_classe"));
			st.setString("id_superfamily", (String)parm.get("id_superfamily"));
			st.setString("id_family", (String)parm.get("id_family"));
			st.setString("id_level", (String)parm.get("id_level"));
			st.setString("id_methods", (String)parm.get("id_methods"));
			st.setString("id_organism_relation", (String)parm.get("id_organism_relation"));

			ResultSet rs = st.executeQuery();
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Map res = new HashMap<>();
				
				res.put("id",  rs.getInt(1)); 
				res.put("name",  rs.getString(2));
				res.put("qt_events",  rs.getLong(3)); 
				
				set.add(res);
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

	private String getOrganismChartSQL(String[] tipos, String sqlwhere) throws Exception{
		String sql = "";
		String table = "o";
		
		sql = "select @rownum:=@rownum+1 id, " +
				" ifnull(SPLIT_STRING(';', ds_organism_taxonomy, " + tipos[2] + "), 'Not Informed') as ds_organism, " +
				" sum(qt_events) from (" +
				" select " + table + ".ds_organism_taxonomy, " +
				" sum(qt_events) as qt_events " + 
				sqlwhere +
				" and (" + table + ".id_organism_level >= " +tipos[2] + " or " + table + ".id_organism_level is null)" + 
				" group by " + table + ".ds_organism_taxonomy " + 
				") as select_1, (SELECT @rownum:=0) as ct group by ds_organism";
		
		return sql;
		
		
	}
	
	public Result consultar(int idresult) throws Exception{
		try{
			
			String sql = "select r.id_classe, " + 
						 "       r.id_superfamily,  " +
						 "       r.id_family,  " +
						 "       r.id_organism,  " +
						 "       o.id_organism_level,  " +
						 "       r.id_level,  " +
						 "       r.qt_events,  " +
						 "       r.reference,  " +
						 "       r.year_plublished " + 
						 "  from result r " +
						 " left join organism o " + 
						 "    on r.id_organism = o.id_organism " +
						 " where id_result = " + idresult;
			
			Statement st = conn.getConn().createStatement();
			ResultSet rs = st.executeQuery(sql);
			ResultSet rs2 =  null;
			
			Result ret = null;
			
			if (rs.next()) {
				ret = new Result();
				ret.setIdresult(idresult);
				ret.setIdclasse(rs.getInt("id_classe"));
				ret.setIdsuperfamily(rs.getInt("id_superfamily"));
				ret.setIdfamily(rs.getInt("id_family"));
				ret.setIdorganism(rs.getInt("id_organism"));
				ret.setIdorganismlevel(rs.getInt("id_organism_level"));
				ret.setIdlevel(rs.getInt("id_level"));
				ret.setQtevents(rs.getInt("qt_events"));
				ret.setReference(rs.getString("reference"));
				ret.setYearpublished(rs.getInt("year_published"));
				
				String stringmethods = "";
				
				sql = " select m.id_method, m.nm_method from result_method rm " +
				" inner join method m on rm.id_method = m.id_method " +
				" where rm.id_result = " + idresult;
				
				rs2 = conn.getConn().createStatement().executeQuery(sql);
				
				while (rs2.next()){
					stringmethods = stringmethods.concat(rs2.getString("id_method"));
					if (!rs2.isLast()) stringmethods = stringmethods.concat(",");
				}

				ret.setIdmethods(stringmethods);				
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
	
	public void incluir (Result res) throws Exception{
		
		try {
			
			String sql = "insert into result (id_result, id_classe, id_superfamily, id_family, id_organism, id_level, qt_events, reference) "
					+ " values(?,?,?,?,?,?,?,?) ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			
			int idresult = getMaxId() ;
			
			st.setInt(1, idresult );
			setaValor(st, 2, res.getIdclasse());
			setaValor(st, 3, res.getIdsuperfamily());
			setaValor(st, 4, res.getIdfamily());
			setaValor(st, 5, res.getIdorganism());
			setaValor(st, 6, res.getIdlevel());
			setaValor(st, 7, res.getQtevents());
			setaValor(st, 8, res.getReference());
			
			st.executeUpdate();

			sql = "delete from result_method where id_result = " + idresult;
			Statement st2 = conn.getConn().createStatement();
			
			st2.executeUpdate(sql);
			
			if (res.getMethods() != null){
				if (res.getMethods().length > 0){
					
					for (int i = 0; i < res.getMethods().length; i++) {
						if (res.getMethods()[i] > 0){
							sql = "insert into result_method(id_result, id_method) " +
						          " values(" + idresult + ", " + res.getMethods()[i] + ") ";

							st2.executeUpdate(sql);
									
						}
					}
					
				}
			}

		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void atualizar (Result res) throws Exception{
		
		try {
			
			String sql = "update result " + 
			             "   set id_classe = ?, " + 
					     "       id_superfamily = ?, " +
			             "       id_family = ?, " + 
					     "       id_organism = ?, " + 
			             "       id_level = ?, " + 
					     "       qt_events = ?, " + 
			             "       reference = ? " +
					     " where id_result = ? ";
					
			PreparedStatement st = conn.getConn().prepareStatement(sql);
			setaValor(st, 1, res.getIdclasse());
			setaValor(st, 2, res.getIdsuperfamily());
			setaValor(st, 3, res.getIdfamily());
			setaValor(st, 4, res.getIdorganism());
			setaValor(st, 5, res.getIdlevel());
			setaValor(st, 6, res.getQtevents());
			setaValor(st, 7, res.getReference());
			setaValor(st, 8, res.getIdresult());
			
			st.executeUpdate();
			
			sql = "delete from result_method where id_result = " + res.getIdresult();
			Statement st2 = conn.getConn().createStatement();
			
			st2.executeUpdate(sql);
			
			if (res.getMethods() != null){
				if (res.getMethods().length > 0){
					
					for (int i = 0; i < res.getMethods().length; i++) {
						if (res.getMethods()[i] > 0){
							sql = "insert into result_method(id_result, id_method) " +
						          " values(" + res.getIdresult() + ", " + res.getMethods()[i] + ") ";

							st2.executeUpdate(sql);
									
						}
					}
					
				}
			}
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}

	public void excluir (int idresult) throws Exception{
		
		try {
			
			String sql = "delete from result_method where id_result = " + idresult;

			Statement st = conn.getConn().createStatement();
			
			st.executeUpdate(sql);

			sql = "delete from result " + 
					     " where id_result = " +  idresult;
					
			 st = conn.getConn().createStatement();
			
			st.executeUpdate(sql);
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
		
	}
	
	public HashMap getGraphicYear() throws Exception{
		try {
			
			String sql = " select year_published, " +
                         "       (select count(distinct reference) from result r where r.year_published <= r2.year_published) qt " +
                         "   from result r2 " +
                         "  where year_published >=  year(now()) - 10 " +
                         " group by year_published"; 
			
			Statement st = conn.getConn().createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			HashMap map = new HashMap();
			
			String yearlabel = "[";
			String ret1 = "[";
			
			while (rs.next()){
				ret1 = ret1.concat("{name:\"").concat(Integer.toString(rs.getInt("year_published")))
						.concat("\",y: " + Integer.toString(rs.getInt("qt")) +", color: Highcharts.Color(Highcharts.getOptions().colors[" + rs.getInt("year_published") + "]).brighten((-2) / 12).get()")
						.concat("}");
				yearlabel = yearlabel.concat("'").concat(Integer.toString(rs.getInt("year_published"))).concat("'");
				if (!rs.isLast()){
					ret1 = ret1.concat(",");
					yearlabel = yearlabel.concat(",");
				}
			}
			
			ret1 = ret1.concat("]");
			yearlabel = yearlabel.concat("]");
			
			map.put("yearlabel", yearlabel);
			map.put("ret1", ret1);
			
			sql = " select year_published, " +
                    "       (select sum(qt_events) from result r where r.year_published <= r2.year_published) qt " +
                    "   from result r2 " +
                    "  where year_published >=  year(now()) - 10 " +
                    " group by year_published"; 

			rs = st.executeQuery(sql);
			
			String ret2 = "[";

			while (rs.next()){
				ret2 = ret2.concat("{name:\"").concat(Integer.toString(rs.getInt("year_published")))
						.concat("\",y: " + Integer.toString(rs.getInt("qt")) +", color: Highcharts.Color(Highcharts.getOptions().colors[" + rs.getInt("year_published") + "]).brighten((-2) / 12).get()")
						.concat("}");
				if (!rs.isLast())
					ret2 = ret2.concat(",");
			}
			
			ret2 = ret2.concat("]");
			
			map.put("ret2", ret2);
			
			return map;
			
		} catch (Exception e) {
			throw e;
		}
		finally{
			conn.close();
		}
	}
	
	public int getOrganismQtEvents(String nmorg) throws Exception{
		try{
			
			String sql = "select sum(r.qt_events)  " +
						 "  from result r " +
						 " left join organism o " + 
						 "    on r.id_organism = o.id_organism " +
						 " where o.ds_organism_taxonomy like '%" + nmorg + "%'";
			
			Statement st = conn.getConn().createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			int qtevents = 0;
			
			if (rs.next()) {
				qtevents = rs.getInt(1);
			}
			
			return qtevents;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw e;
		}
		finally{
			conn.close();
		}

	}

	private int getMaxId() throws Exception{
        Statement st = conn.getConn().createStatement();  

        ResultSet rs = st.executeQuery("SELECT ifnull(max(id_result), 0) + 1 FROM result "); 
         
        if (rs.next())   {
        	return rs.getInt(1);
        }
        else return 1;
		
	}	

	
}
