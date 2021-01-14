package org.unipampa.db.conector.hvt;

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

public class HVTResultCon extends Conector {
	
	public HVTResultCon() throws Exception{
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
				sqlorg = sqlorg.concat("org.ds_organism_taxonomy like '%").concat(org[i].concat("%'"));
			}

			sqlorg = sqlorg.concat(")");
		}

		return sqlorg;
	}
	
	private String getSqlVirusTaxonomy(String virus){
		String vir[];
		String sqlvirus = "";
		
		if (!virus.equals("0")){
			vir = virus.split("[,]");
		
			sqlvirus = "and (";
			
			for (int i = 0; i < vir.length; i++) {
				if (i > 0) sqlvirus = sqlvirus.concat(" or ");
				sqlvirus = sqlvirus.concat("v.ds_virus_taxonomy like '%").concat(vir[i].concat("%'"));
			}

			sqlvirus = sqlvirus.concat(")");
		}

		return sqlvirus;
	}

	public Set listartabela(Map parm) throws Exception{
		
		try{
			
			String sqlorg = getSqlOrganismTaxonomy((String)parm.get("id_organism"));
			String sqlvir = getSqlVirusTaxonomy((String)parm.get("id_virus"));
			
			String sql = " select hvt.id_hvt, " +
					"             vg.id_virus_group, " +
					"             vg.ds_virus_group, " +
					"             vt.id_virus_type, " +
					"             vt.ds_virus_type, " +
					"             orgl.id_level as id_organism_level, " +
					"             orgl.nm_level as nm_organism_level, " +
					"             org.nm_organism, " +
					"             vl.id_level as id_virus_level, " +
					"             vl.nm_level as nm_virus_level, " +
					"             v.nm_virus, " +
					"             hvt.qt_events, " + 
					"             hvt.dt_estimates, " +
					"             hvt.ds_eve " +
					"        from hvt  " +
					"       inner join organism org " +
					"          on hvt.id_organism = org.id_organism " +
					"       inner join virus v " +
					"          on hvt.id_virus = v.id_virus " +
					"       inner join level orgl " +
					"          on org.id_organism_level = orgl.id_level " +
					"       inner join level vl " +
					"          on v.id_virus_level = vl.id_level " +
					"       inner join virus_type vt " +
					"          on v.id_virus_type = vt.id_virus_type " +
					"       inner join virus_group vg " +
					"          on vt.id_virus_group = vg.id_virus_group " + 
					"       where (v.id_virus_type in (" + (String)parm.get("id_virus_type") + ") or :id_virus_type = '0')" +
					"         and (vg.id_virus_group in (" + (String)parm.get("id_virus_group") + ") or :id_virus_group = '0')" +
					sqlorg + 
					sqlvir;
			
			NamedParameterStatement st = new NamedParameterStatement(conn.getConn(), sql);
			
			st.setString("id_virus_type", (String)parm.get("id_virus_type"));
			st.setString("id_virus_group", (String)parm.get("id_virus_group"));
			
			ResultSet rs = st.executeQuery();
//			ResultSet rs2 = null;
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Map res = new HashMap<>();
				
				res.put("id_hvt", rs.getInt("id_hvt"));
				res.put("id_virus_group", rs.getInt("id_virus_group"));
				res.put("ds_virus_group", rs.getString("ds_virus_group"));
				res.put("id_virus_type", rs.getInt("id_virus_type"));
				res.put("ds_virus_type", rs.getString("ds_virus_type"));
				res.put("id_organism_level", rs.getInt("id_organism_level"));
				res.put("nm_organism_level", rs.getString("nm_organism_level"));
				res.put("nm_organism", rs.getString("nm_organism"));
				res.put("id_virus_level", rs.getInt("id_virus_level"));
				res.put("nm_virus_level", rs.getString("nm_virus_level"));
				res.put("nm_virus", rs.getString("nm_virus"));
				res.put("qt_events", rs.getInt("qt_events"));
				res.put("dt_estimates", rs.getString("dt_estimates"));
				res.put("ds_eve", rs.getString("ds_eve"));

				PaperCon papercon = new PaperCon();
				res.put("referenceHTML", papercon.getDsLinkString(rs.getInt("id_hvt")));
				
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
			String sqlvir = getSqlVirusTaxonomy((String)parm.get("id_virus"));

			String[] tipos = ((String)parm.get("tipo")).split("[|]");
			String tipo = tipos[0];
			
			String sqlwhere = "        from hvt  " +
					"       inner join organism org " +
					"          on hvt.id_organism = org.id_organism " +
					"       inner join virus v " +
					"          on hvt.id_virus = v.id_virus " +
					"       inner join level orgl " +
					"          on org.id_organism_level = orgl.id_level " +
					"       inner join level vl " +
					"          on v.id_virus_level = vl.id_level " +
					"       inner join virus_type vt " +
					"          on v.id_virus_type = vt.id_virus_type " +
					"       inner join virus_group vg " +
					"          on vt.id_virus_group = vg.id_virus_group " + 
					"       where (v.id_virus_type in (" + (String)parm.get("id_virus_type") + ") or :id_virus_type = '0')" +
					"         and (vg.id_virus_group in (" + (String)parm.get("id_virus_group") + ") or :id_virus_group = '0')" +
					sqlorg + 
					sqlvir;
			
			if (tipo.equals("virusgroup"))
				sql = " select vg.id_virus_group, " +
    		          "        ifnull(vg.ds_virus_group, 'Not Informed'), " + 
		              "        sum(hvt.qt_events) as qt_events " + 
    		          sqlwhere +
    		          "  group by vg.id_virus_group ";
			else if(tipo.equals("virustype"))
				sql = " select vt.id_virus_type, " +
	    		      "        ifnull(vt.ds_virus_type, 'Not Informed'), " + 
			          "        sum(hvt.qt_events) as qt_events " + 
	    		      sqlwhere +
	    		      "  group by vt.id_virus_type ";
			else if(tipo.equals("organism"))
				sql = getOrganismChartSQL(tipos, sqlwhere);
			else if(tipo.equals("virus"))
				sql = getVirusChartSQL(tipos, sqlwhere);
			
			sql = sql + " order by 3 desc";
			
			NamedParameterStatement st = new NamedParameterStatement(conn.getConn(), sql);
			
			st.setString("id_virus_type", (String)parm.get("id_virus_type"));
			st.setString("id_virus_group", (String)parm.get("id_virus_group"));

			ResultSet rs = st.executeQuery();
			
			System.out.println(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Map res = new HashMap<>();
				
				res.put("id",  rs.getInt(1)); 
				
				if (rs.getString(2).trim().equals("") || rs.getString(2).trim().equals("-") || rs.getString(2).trim().toLowerCase().equals("unassigned"))
					res.put("name",  "Not informed");
				else
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
		String table = "org";
		
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

	private String getVirusChartSQL(String[] tipos, String sqlwhere) throws Exception{
		String sql = "";
		String table = "v";
		
		//Corrige o nivel do virus, que começa em ordem
		String viruslevel = Integer.toString(Integer.parseInt(tipos[2]) - 4);
		
		sql = "select @rownum:=@rownum+1 id, " +
				" ifnull(SPLIT_STRING(';', ds_virus_taxonomy, " + viruslevel + "), 'Not Informed') as ds_virus, " +
				" sum(qt_events) from (" +
				" select " + table + ".ds_virus_taxonomy, " +
				" sum(qt_events) as qt_events " + 
				sqlwhere +
				" and (" + table + ".id_virus_level >= " + tipos[2]+ " or " + table + ".id_virus_level is null)" + 
				" group by " + table + ".ds_virus_taxonomy " + 
				") as select_1, (SELECT @rownum:=0) as ct group by ds_virus";
		
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
	

	
	public HashMap getGraphicYear() throws Exception{
		try {
			
			String sql = " select year_published,  " + 
    	 	 			 " (select count(distinct ds_link) from paper p where p.year_published <= p2.year_published) qt " +  
						 " from paper p2  " + 
						 " where year_published >=  year(now()) - 10 " +  
						 " group by year_published "; 
			
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
				  " (select sum(qt_events) from hvt_year r where r.year_published <= r2.year_published) qt " +  
				  " from hvt_year r2  " + 
				  " where year_published >=  year(now()) - 10 " +  
				  " group by year_published  " ; 

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
						 "  from hvt r " +
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


	
}
