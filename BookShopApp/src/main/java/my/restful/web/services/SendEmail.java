package my.restful.web.services;
import java.io.File;
import java.io.IOException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
public class SendEmail {
	
	
	
	public static String passwordNotification(String password, String email) throws IOException {
		// TODO Auto-generated method stub



//Recipient's email ID:
String toID = email;
//Sender's email ID:
String fromID = "mymobilestore.cc@gmail.com";
//Sender's Email Password:
String logpassword = "zmkkmnvcbnhmfpbd";
//Subject of the Email:
String subject = "RESET PASSWORD";
//Body of the Email:
String bodyText = String.format("Αγαπητέ χρήστη το reset του κωδικού σας πραγματοποιήθηκε. Παρακαλούμε χρησιμοποιείστε τον προσωρινό κωδικό σας για να συνδεθείτε. "
		+"Κωδικός: %s\n"+
		"Σας ευχαριστούμε που χρησιμοποιείτε τα προϊόντα και τις υπηρεσίες μας!"
		+" Eίμαστε στη διαθεσή σας 24 ώρες το 24ωρο! \n"+
		"\nΜε εκτίμηση, \nBookme customer care", password);
//Change the location of the required attachment file, the format can by anything like jpg, png, pdf etc:
String attachmentLocation = "";
// Host is Gmail's SMTP
String host = "smtp.gmail.com";
//Getting system properties
Properties pr = System.getProperties();

//Setting up Email server
pr.put("mail.smtp.host", host);
pr.put("mail.smtp.port", "465");
pr.put("mail.smtp.ssl.enable", "true");
pr.put("mail.smtp.auth", "true");
//pass the Email and password to the session object
Session ss = Session.getInstance(pr, new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(fromID, logpassword);
    }
});
try {
    MimeMessage mm = new MimeMessage(ss);
    //Set the 'From:' header field
    mm.setFrom(new InternetAddress(fromID));
    //Set the 'To:' header field
    mm.addRecipient(Message.RecipientType.TO, new InternetAddress(toID));
    //Set the 'Subject:' header field
    mm.setSubject(subject);
    
   
    
    
    mm.setText(bodyText);
    
    System.out.println("sending the Email...");
    //send the mail:
    Transport.send(mm);
    System.out.println("\nEmail sent successfully!!");
    
} 
catch (MessagingException e) {
	
    e.printStackTrace();
    return "Email not sent successfully";
}


return "Email sent successfully";




	}
	
	
	
	
	
	
	
	
	public static String receiptNotification(String email, String totalAmount, JSONArray tc) throws IOException {
		// TODO Auto-generated method stub

/*for(int i=0; i<tc.length();i++){
	JSONObject productObject = tc.getJSONObject(i);
	 System.out.println(productObject.getString("productID"));
	
}*/

//Recipient's email ID:
String toID = email;
//Sender's email ID:
String fromID = "mymobilestore.cc@gmail.com";
//Sender's Email Password:
String logpassword = "zmkkmnvcbnhmfpbd";
//Subject of the Email:
String subject = "ORDER RECEIPT";

StringBuilder messageBuilder = new StringBuilder();
messageBuilder.append("Αγαπητέ πελάτη, η παραγγελία σας καταχωρήθηκε επιτυχώς. Παρακαλούμε δείτε την απόδειξη αγοράς σας!\n\n");

for (int i = 0; i <tc.length(); i++) {
	JSONObject productObject = tc.getJSONObject(i);

    int quantity =productObject.getInt("qty");

    String productMessage = String.format("Τίτλος: %s, %S, Ποσότητα: %d%n%n",
    		productObject.getString("title"), productObject.getString("price"), quantity);

    messageBuilder.append(productMessage);
  
  
    
    
}

messageBuilder.append(String.format("Σύνολο: %s euro%n%n", totalAmount));
messageBuilder.append("Σας ευχαριστούμε που χρησιμοποιείτε τα προϊόντα και τις υπηρεσίες μας!\n"
        + "Eίμαστε στη διαθεσή σας 24 ώρες το 24ωρο!\n"
        + "Με εκτίμηση, Bookme customer care");

System.out.println(messageBuilder.toString());


//Body of the Email:
String bodyText = messageBuilder.toString();
//Change the location of the required attachment file, the format can by anything like jpg, png, pdf etc:
String attachmentLocation = "";
// Host is Gmail's SMTP
String host = "smtp.gmail.com";
//Getting system properties
Properties pr = System.getProperties();

//Setting up Email server
pr.put("mail.smtp.host", host);
pr.put("mail.smtp.port", "465");
pr.put("mail.smtp.ssl.enable", "true");
pr.put("mail.smtp.auth", "true");
//pass the Email and password to the session object
Session ss = Session.getInstance(pr, new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(fromID, logpassword);
    }
});
try {
    MimeMessage mm = new MimeMessage(ss);
    //Set the 'From:' header field
    mm.setFrom(new InternetAddress(fromID));
    //Set the 'To:' header field
    mm.addRecipient(Message.RecipientType.TO, new InternetAddress(toID));
    //Set the 'Subject:' header field
    mm.setSubject(subject);
    
   
    
    
    mm.setText(bodyText);
    
    System.out.println("sending the Email...");
    //send the mail:
    Transport.send(mm);
    System.out.println("\nEmail sent successfully!!");
    
} 
catch (MessagingException e) {
	
    e.printStackTrace();
    return "Email not sent successfully";
}


return "Email sent successfully";




	}	
	
	
	
	
	
	
	
	
	public static String newsletterNotification(String email, JSONArray ya2) throws IOException {
		// TODO Auto-generated method stub

/*for(int i=0; i<tc.length();i++){
	JSONObject productObject = tc.getJSONObject(i);
	 System.out.println(productObject.getString("productID"));
	
}*/

//Recipient's email ID:
String toID = email;
//Sender's email ID:
String fromID = "mymobilestore.cc@gmail.com";
//Sender's Email Password:
String logpassword = "zmkkmnvcbnhmfpbd";
//Subject of the Email:
String subject = "Newsletter";

StringBuilder messageBuilder = new StringBuilder();
messageBuilder.append("Αγαπητέ πελάτη, δείτε όλα τα προϊόντα μας στο ακόλουθο Newsletter!\n\n");

for (int i = 0; i <ya2.length(); i++) {
	JSONObject productObject = ya2.getJSONObject(i);

   ;

    String productMessage = String.format("Τίτλος: %s, Τιμή: %S, %n%n",
    		productObject.getString("productName"), productObject.getString("productPrice"));

    messageBuilder.append(productMessage);
  
  
    
    
}

//messageBuilder.append(String.format("Σύνολο: %s euro%n%n", totalAmount));
messageBuilder.append("Σας ευχαριστούμε που χρησιμοποιείτε τα προϊόντα και τις υπηρεσίες μας!\n"
        + "Eίμαστε στη διαθεσή σας 24 ώρες το 24ωρο!\n"
        + "Με εκτίμηση, Bookme customer care");

System.out.println(messageBuilder.toString());


//Body of the Email:
String bodyText = messageBuilder.toString();
//Change the location of the required attachment file, the format can by anything like jpg, png, pdf etc:
String attachmentLocation = "";
// Host is Gmail's SMTP
String host = "smtp.gmail.com";
//Getting system properties
Properties pr = System.getProperties();

//Setting up Email server
pr.put("mail.smtp.host", host);
pr.put("mail.smtp.port", "465");
pr.put("mail.smtp.ssl.enable", "true");
pr.put("mail.smtp.auth", "true");
//pass the Email and password to the session object
Session ss = Session.getInstance(pr, new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(fromID, logpassword);
    }
});
try {
    MimeMessage mm = new MimeMessage(ss);
    //Set the 'From:' header field
    mm.setFrom(new InternetAddress(fromID));
    //Set the 'To:' header field
    mm.addRecipient(Message.RecipientType.TO, new InternetAddress(toID));
    //Set the 'Subject:' header field
    mm.setSubject(subject);
    
   
    
    
    mm.setText(bodyText);
    
    System.out.println("sending the Email...");
    //send the mail:
    Transport.send(mm);
    System.out.println("\nEmail sent successfully!!");
    
} 
catch (MessagingException e) {
	
    e.printStackTrace();
    return "Email not sent successfully";
}


return "Email sent successfully";




	}	
	
	
	
	
	
	
	
	
	
	
	
	
}
