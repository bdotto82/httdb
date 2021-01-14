package org.unipampa.db;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConn {

	private Connection conn;
		
    private void startConn() throws Exception{
		conn = null;
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/htt");
	
		if (ds == null) throw new Exception("Error: No DataSource");
		if (ds != null) conn = ds.getConnection();
		
    }
	
	public Connection getConn() throws Exception{
		if (conn == null || conn.isClosed()) {
			startConn();
		}
		return conn;
	}
	
	public void close() {
		try {
			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
			
	}
	
}
