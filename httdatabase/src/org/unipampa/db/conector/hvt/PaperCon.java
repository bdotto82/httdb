package org.unipampa.db.conector.hvt;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;

import org.unipampa.cadastro.hvt.Paper;
import org.unipampa.cadastro.hvt.VirusGroup;
import org.unipampa.db.DBConn;
import org.unipampa.db.conector.Conector;

public class PaperCon extends Conector {
	
	public PaperCon() throws Exception{
		super();
	}

	public PaperCon(DBConn conn) throws Exception{
		super(conn);
	}

	public Set listar(int idhvt) throws Exception{
		
		try{
			String sql = "select id_paper, year_published, ds_link from paper where id_hvt = " + idhvt;
			
			Statement st = conn.getConn().createStatement();
			
			ResultSet rs = st.executeQuery(sql);
			
			Set set = new LinkedHashSet();
			
			while (rs.next()){
				Paper paper = new Paper();

				paper.setIdhvt(idhvt);
				paper.setIdpaper(rs.getInt("id_paper"));
				paper.setDslink(rs.getString("ds_link"));
				paper.setYearpublished(rs.getInt("year_published"));
				
				set.add(paper);
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
	
	public String getDsLinkString(int idhvt) throws Exception{
		String ret = "";
		
		Set<Paper> set = listar(idhvt);
		
		Iterator<Paper> it = set.iterator();
		
		while (it.hasNext()){
			Paper paper = it.next();
			
			ret = ret.concat(paper.getDslink());
			
			if (it.hasNext())
				ret = ret.concat("<BR>");
			
		}
		
		return ret;
		
	}

}
