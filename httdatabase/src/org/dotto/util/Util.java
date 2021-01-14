package org.dotto.util;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

//import javax.servlet.http.HttpServletRequest;

public final class Util {
	
	public static String maskTelefone(long nrtelefone){
		if (nrtelefone == 0)
			return "";
		else{
			String nrtel = Long.toString(nrtelefone);
			
			if (nrtel.length() < 10)
				return nrtel;
			else
				return "(" + nrtel.substring( 0,2 ) + ") " + nrtel.substring( 2,6 ) + "-" + nrtel.substring( 6,10 ); 
		}
	}

	public static String maskTelefone(String nrtelefone){
		if (nrtelefone == null || nrtelefone.trim().equals(""))
			return "";
		else{
			if (nrtelefone.length() < 10)
				return nrtelefone;
			else
				return "(" + nrtelefone.substring( 0,2 ) + ") " + nrtelefone.substring( 2,6 ) + "-" + nrtelefone.substring( 6,10 ); 
		}
	}
	
	public static String format(Date obj, String mask){
		if (obj == null){
			return "";
		}
		else{
			DateFormat df= new SimpleDateFormat(mask);
			return df.format(obj);
		}
			
	}
	
	public static String format(Date obj){
		if (obj == null){
			return "";
		}
		else{
			DateFormat df= new SimpleDateFormat("dd/MM/yyyy");
			return df.format(obj);
		}
			
	}
	
	public static String format(int obj){
		if (obj == 0){
			return "";
		}
		else{
			return Integer.toString(obj);
		}
			
	}

	public static String format(long obj){
		if (obj == 0){
			return "";
		}
		else{
			return Long.toString(obj);
		}
			
	}

	public static String format(double obj){
		if (obj == 0){
			return "0,00";
		}
		else{
			NumberFormat nf = new DecimalFormat("###,###,###,##0.00");
			return nf.format(obj);
		}
			
	}

	public static String format(double obj, String format){
		if (obj == 0){
			return "";
		}
		else{
			NumberFormat nf = new DecimalFormat(format);
			return nf.format(obj);
		}
			
	}

	public static String format(String obj){
		if (obj == null){
			return "";
		}
		else{
			return obj;
		}
			
	}

	public static Date getDate(String obj) throws Exception{
		DateFormat df;
		
		if (obj.trim().length() == 8)
			df= new SimpleDateFormat("dd/MM/yy");
		else
			df= new SimpleDateFormat("dd/MM/yyyy");
		
		return df.parse(obj);
	}
	
	public static boolean isnullParm(String parm, HttpServletRequest request){
		if (request.getParameter(parm) != null && 
		    !request.getParameter(parm).equals("null") && 
		    !request.getParameter(parm).equals(""))
		    return false;
	    else
	    	return true;
	}

	public static boolean isonlynullParm(String parm, HttpServletRequest request){
		if (request.getParameter(parm) != null && 
		    !request.getParameter(parm).equals("null") )
		    return false;
	    else
	    	return true;
	}
	
	public static String getDiaSemana(int dia){
		switch (dia) {
		case 1:
			return "Dom";
		case 2:
			return "Seg";
		case 3:
			return "Ter";
		case 4:
			return "Qua";
		case 5:
			return "Qui";
		case 6:
			return "Sex";
		case 7:
			return "Sab";

		default:
			return "";
		}
		
	}
	
	public static String limpamascara(String masc){
		if (masc == null)
			return "";
		else
			return masc.
					replaceAll("[.]", "").
					replaceAll("[,]", "").
					replaceAll("[/]", "").
					replaceAll("[\\\\]", "").
					replaceAll("[-]", "").
					replaceAll("[(]", "").
					replaceAll("[)]", "").
					replaceAll("[ ]", "");
	}
	
	public static Date getUltimoDia(Date dtref) {
		try{
			Calendar c = Calendar.getInstance(); 
			c.setTime(getDate("01/".concat(format(dtref, "MM/yyyy"))) );
			c.add(Calendar.MONTH, 1);
			c.add(Calendar.DAY_OF_MONTH, -1); 
			
			return c.getTime();
			
		}
		catch (Exception e){
			System.out.println("Erro (getUltimodia):" .concat(e.getMessage()));
			return null;
		}
	}

	public static String converterSelectString(String values[]){

		return converterSelectString(values, 0);
		
	}

	public static String converterSelectString(String values[], int pos){

		String ret = "0";

		if (values != null){

			if (values.length == 1 && values[0].trim().equals(""))
				return ret;
			
			ret = "";
			
			for (int i=0; i < values.length; i++ ){
				String[] id=values[i].split("[|]");
				ret = ret.concat(id[pos]);
				
				if (i < (values.length - 1 ))
					ret = ret.concat(",");
			}
		}
		
		return ret;
		
	}

}


