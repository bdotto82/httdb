package org.dotto.util;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.http.Part;

public class Email {
	
	public void sendMailTLS(String strfrom, String strto, String strsub, String strmessage, Map parm) throws Exception{
		
		final String username = (String)parm.get("user");
		final String password = (String)parm.get("password");

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", parm.get("server"));
		props.put("mail.smtp.port", parm.get("port"));

		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		//config. da mensagem
		Message mailMessage = new MimeMessage(session);

		//remetente
		mailMessage.setFrom(new InternetAddress(strfrom));

		//destinatario
		mailMessage.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(strto));		

		//mensagem que vai no corpo do email
		MimeBodyPart mbpMensagem = new MimeBodyPart();
		mbpMensagem.setContent(strmessage, "text/html; charset=utf-8");
		
		//partes do email
		Multipart mp = new MimeMultipart();
		
		mp.addBodyPart(mbpMensagem);
		
		//assunto do email
		mailMessage.setSubject(MimeUtility.encodeText(strsub, "utf-8", "B") );
		
		//seleciona o conteudo
		mailMessage.setContent(mp);

		//envia o email
		Transport.send(mailMessage);

	}
	
	public void sendMailTLS(String strfrom, String strto, String strsub, String strmessage, Set files, Map parm) throws Exception{

		final String username = (String)parm.get("user");
		final String password = (String)parm.get("password");

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", (String)parm.get("server"));
		props.put("mail.smtp.port", (String)parm.get("port"));

		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		//config. da mensagem
		Message mailMessage = new MimeMessage(session);

		//remetente
		mailMessage.setFrom(new InternetAddress(strfrom));

		//destinatario
		mailMessage.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(strto));		

		//mensagem que vai no corpo do email
		MimeBodyPart mbpMensagem = new MimeBodyPart();
		mbpMensagem.setContent(strmessage, "text/html; charset=utf-8");

		//partes do email
		Multipart mp = new MimeMultipart();
		mp.addBodyPart(mbpMensagem);
		

		//setando o anexo
        //DataSource source = new FileDataSource((String)parm.get("filename"));
 
		Iterator it = files.iterator();
		
		while (it.hasNext()){
			
			HashMap mapfile = (HashMap)it.next();
			
			MimeBodyPart mbpAnexo = new MimeBodyPart();
			mbpAnexo.setDataHandler(new DataHandler(new ByteArrayDataSource((InputStream)mapfile.get("filestream"), "application/octet-stream")));		
			//mbpAnexo.setDataHandler(new DataHandler(source));
			mbpAnexo.setFileName((String)mapfile.get("filename"));
			mp.addBodyPart(mbpAnexo);
			
		}
		

		//assunto do email
		mailMessage.setSubject(MimeUtility.encodeText(strsub, "utf-8", "B") );
		
		//seleciona o conteudo
		mailMessage.setContent(mp);

		//envia o email
		Transport.send(mailMessage);

	}
	
	

}

