package org.unipampa.cadastro.hvt;

import org.unipampa.cadastro.Level;

public class Virus {
	
	private int idvirus;
	private VirusType virustype;
	private String nmvirus;
	private String dsvirustaxonomy;
	private Level viruslevel;
	
	public int getIdvirus() {
		return idvirus;
	}
	public void setIdvirus(int idvirus) {
		this.idvirus = idvirus;
	}
	public VirusType getVirustype() {
		return virustype;
	}
	public void setVirustype(VirusType virustype) {
		this.virustype = virustype;
	}
	public String getNmvirus() {
		return nmvirus;
	}
	public void setNmvirus(String nmvirus) {
		this.nmvirus = nmvirus;
	}
	public String getDsvirustaxonomy() {
		return dsvirustaxonomy;
	}
	public void setDsvirustaxonomy(String dsvirustaxonomy) {
		this.dsvirustaxonomy = dsvirustaxonomy;
	}
	public Level getViruslevel() {
		return viruslevel;
	}
	public void setViruslevel(Level viruslevel) {
		this.viruslevel = viruslevel;
	}
	
	
}
