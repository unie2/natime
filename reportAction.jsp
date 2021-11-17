<%@ page language="java" contentType="text/html; charset+UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="util.Gmail" %>
<%@ page import="java.io.PrintWriter" %>

<%


request.setCharacterEncoding("UTF-8");
String reportTitle = null;
String reportContent = null;
if(request.getParameter("reportTitle") != null) {
    reportTitle = request.getParameter("reportContent");
}
if(reportTitle == null || reportContent == null) {
PrintWriter scrpt = response.getWriter();
script.printIn("<script>");
script.printIn("alert('입력이 안 된 사람이 있습니다. ');");
script.printIn("history.back();");
script.printIn("</script>");
script.close();
return;
}

String host = "http://localhost:8000/Lecure_Evaluation/";
String from = "gnlsk99@gmail.com";
String to = "mk123ok@naver.com";
String subject = "강의평가 사이트에서 접수된 신고 메일입니다.";
String content = "신고자: " + userID +
                      "<br>제목: " + reportTitle +
                      "<br>내용: " + reportContent;

Properties p new Properties();
p.put("mail.smtp.user", from);
p.put("mail.smtp.host", "smtp.googlemail.com");
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");

try {
Authenticator auth = new Gmail();
Session ses = Session.getInstance(p, auth);
ses.setDebug(true);
MimeMessage msg = new MimeMessage(ses);
msg.setDebug(true);
Address fromAddr = new InternetAddress(from);
msg.setFrom(fromAddr)
Address toAddr = new InternetAddress(to);
msg.addRecipient(Message.RecipientType.TO, toAddr);
msg.setContent(content, "text/html;charset=UTF8");
Transport.send(msg);
} catch (Exception e ) {
e.printStackTrace();
PrintWriter script = response.getWriter();
script.printIn("<script>");
script.printIn("alert('오류가 발생했습니다.. ');");
script.printIn("history.back();");
script.printIn("</script>");
script.close();
return;
}
PrintWriter script = response.getWriter();
script.printIn("<script>");
script.printIn("alert('정상적으로 신고되었습니다. ');");
script.printIn("history.back();");
script.printIn("</script>");
script.close();
%>
