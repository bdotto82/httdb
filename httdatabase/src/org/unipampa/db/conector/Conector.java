package org.unipampa.db.conector;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.util.Date;

import org.dotto.util.NamedParameterStatement;
import org.unipampa.db.DBConn;

public class Conector {
	protected DBConn conn;
	
	public Conector() throws Exception{
		this.conn = new DBConn();
	}
	
	public Conector(DBConn conn) throws Exception{
		this.conn = conn;
	}
	
	public void setaValor(PreparedStatement st, int indice, Date valor) throws Exception{
		
		if (valor != null )	
			st.setDate(indice, new java.sql.Date(valor.getTime()));
		else 
			st.setNull(indice, java.sql.Types.DATE);
		
	}
	
	public void setaValor(PreparedStatement st, int indice, BigDecimal valor) throws Exception{
		
		if (valor != null)	
			st.setDouble(indice, valor.doubleValue());
		else 
			st.setNull(indice, java.sql.Types.DOUBLE);
		
	}
	
	public void setaValor(PreparedStatement st, int indice, int valor) throws Exception{
		
		if (valor > 0 )	
			st.setInt(indice, valor);
		else 
			st.setNull(indice, java.sql.Types.INTEGER);
		
	}
	
	public void setaValor(PreparedStatement st, int indice, String valor) throws Exception{
		
		if (valor != null && !valor.trim().equals("") )	
			st.setString(indice, valor.trim());
		else 
			st.setString(indice, null);
		
	}
	
	public void setaValor(PreparedStatement st, int indice, double valor) throws Exception{
		
		if (valor > 0 )	
			st.setDouble(indice, valor);
		else 
			st.setNull(indice, java.sql.Types.DOUBLE);
		
	}

	public void setaValor(NamedParameterStatement st, String indice, int valor) throws Exception{
		
		if (valor > 0 )	
			st.setInt(indice, valor);
		else 
			st.setNull(indice, java.sql.Types.INTEGER);
		
	}
	
	public void setaValor(NamedParameterStatement st, String indice, String valor) throws Exception{
		
		if (valor != null && !valor.trim().equals("") )	
			st.setString(indice, valor.trim());
		else 
			st.setString(indice, null);
		
	}
	
	public void setaValor(NamedParameterStatement st, String indice, double valor) throws Exception{
		
		if (valor > 0 )	
			st.setDouble(indice, valor);
		else 
			st.setNull(indice, java.sql.Types.DOUBLE);
		
	}

	public void setaValor(NamedParameterStatement st, String indice, Date valor) throws Exception{
		
		if (valor != null )	
			st.setTimestamp(indice, new java.sql.Timestamp(valor.getTime()));
		else 
			st.setNull(indice, java.sql.Types.DATE);
		
	}

}
