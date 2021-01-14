package org.unipampa.cadastro.htt;

public class Result {
	private int idresult;
	private int idclasse;
	private int idsuperfamily; 
	private int idfamily; 
	private int idorganismlevel;
	private int idorganism; 
	private int idlevel; 
	private int qtevents; 
	private String reference; 
	private int[] methods;
    private String namemethods;
    private String idmethods;
    private int yearpublished;
    private int idorganismrelation;
    private String ncbilink;
    private String repbaselink;
	
	public String getNcbilink() {
		return ncbilink;
	}
	public void setNcbilink(String ncbilink) {
		this.ncbilink = ncbilink;
	}
	public String getRepbaselink() {
		return repbaselink;
	}
	public void setRepbaselink(String repbaselink) {
		this.repbaselink = repbaselink;
	}
	public int getYearpublished() {
		return yearpublished;
	}
	public void setYearpublished(int yearpublished) {
		this.yearpublished = yearpublished;
	}
	public int getIdorganismrelation() {
		return idorganismrelation;
	}
	public void setIdorganismrelation(int idorganismrelation) {
		this.idorganismrelation = idorganismrelation;
	}
	public int getIdclasse() {
		return idclasse;
	}
	public void setIdclasse(int idclasse) {
		this.idclasse = idclasse;
	}
	public int getIdsuperfamily() {
		return idsuperfamily;
	}
	public void setIdsuperfamily(int idsuperfamily) {
		this.idsuperfamily = idsuperfamily;
	}
	public int getIdfamily() {
		return idfamily;
	}
	public void setIdfamily(int idfamily) {
		this.idfamily = idfamily;
	}
	public int getIdorganism() {
		return idorganism;
	}
	public void setIdorganism(int idorganism) {
		this.idorganism = idorganism;
	}
	public int getIdlevel() {
		return idlevel;
	}
	public void setIdlevel(int idlevel) {
		this.idlevel = idlevel;
	}
	public int getQtevents() {
		return qtevents;
	}
	public void setQtevents(int qtevents) {
		this.qtevents = qtevents;
	}
	public String getReference() {
		return reference;
	}
	public void setReference(String reference) {
		this.reference = reference;
	}
	public int[] getMethods() {
		return methods;
	}
	public void setMethods(int[] methods) {
		this.methods = methods;
	}
	public int getIdresult() {
		return idresult;
	}
	public void setIdresult(int idresult) {
		this.idresult = idresult;
	}
	public String getNamemethods() {
		return namemethods;
	}
	public void setNamemethods(String namemethods) {
		this.namemethods = namemethods;
	}
	public String getIdmethods() {
		return idmethods;
	}
	public void setIdmethods(String idmethods) {
		this.idmethods = idmethods;
	}
	public int getIdorganismlevel() {
		return idorganismlevel;
	}
	public void setIdorganismlevel(int idorganismlevel) {
		this.idorganismlevel = idorganismlevel;
	}
	
}
