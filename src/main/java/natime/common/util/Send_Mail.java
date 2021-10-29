package natime.common.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class Send_Mail {
    String Receiver = "";
    String Content = "";
    String Title = "";

    public Send_Mail(){}

    public Send_Mail(String Receiver, String Content, String Title) {
        this.Receiver = Receiver;
        this.Content = Content;
        this.Title = Title;
    }

    public void Send_pw_mail() {
        Properties properties = new Properties();

        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.socketFactory.port", "465");//465
        properties.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.port", "465");

        Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("", ""); // 개인정보
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("yhn"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(this.Receiver));
            message.setSubject(this.Title);
            message.setText(this.Content);
            message.setHeader("content-Type", "text/html; charset=utf-8");
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
