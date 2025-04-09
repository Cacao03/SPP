package util;

import jakarta.servlet.http.HttpSession;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import org.apache.catalina.ha.ClusterSession;

public class SendMail {

    private static class MyAuthenticator extends Authenticator {

        private final String username;
        private final String password;

        public MyAuthenticator(String username, String password) {
            this.username = username;
            this.password = password;
        }

        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
        }
    }

    public void sendMail(HttpSession session, String email, String name, String msg) {
        String to = email;
        String from = "swp391@example.com";

        String host = "sandbox.smtp.mailtrap.io";
        //mailtrap chienqhe170223
//        final String username = "72e7b242034aee"; 
//        final String password = "0b6dc1be4bd515"; 

        //mailtrap chiendam120203
        final String username = "239113877caca2";
        final String password = "7782bd6f93aa6c";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "false");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        // Get the Session object.
        Session mailSession = Session.getInstance(props, new MyAuthenticator(username, password));

        long timestamp = System.currentTimeMillis();

        // Remove the last digit
        timestamp /= 10;

        // Extract the last 6 digits
        long lastSixDigits = timestamp % 1000000;

        // Store lastSixDigits in the session
        session.setAttribute("verifyCode", lastSixDigits);
        try {
            // Create a default MimeMessage object.
            Message message = new MimeMessage(mailSession);

            message.setFrom(new InternetAddress(from));

            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

            message.setSubject(msg);

            // Put your HTML content using HTML markup
            message.setContent("<div class=\"container\" style=\"font-family: Arial, sans-serif;\">\n"
                    + "        <div class=\"header\" style=\"background-color: #007bff; color: #fff; padding: 10px;\">\n"
                    + "            <h1>Welcome to Our Website</h1>\n"
                    + "        </div>\n"
                    + "        <p>Hello " + email + ",</p>\n"
                    + "        <p>Thank you for registering on our website! We are excited to have you as a member of our community.</p>\n"
                    + "        <p>Your registration details:</p>\n"
                    + "        <ul>\n"
                    + "            <li><strong>Email:</strong> " + email + "</li>\n"
                    + "        </ul>\n"
                    + "        <div class=\"verification-code\" style=\"background-color: #f2f2f2; padding: 5px;\">\n"
                    + "            Your Verification Code: <span id=\"verification-code\" style=\"font-weight: bold;\">" + lastSixDigits + "</span>\n"
                    + "        </div>\n"
                    + "        <p>Feel free to explore our website and make the most of your membership.</p>\n"
                    + "        <p>If you have any questions or need assistance, please don't hesitate to <a href=\"#\" style=\"color: #007bff; text-decoration: none;\">contact our support team</a>.</p>\n"
                    + "        <p style=\"font-style: italic;\">Best regards,<br> Your Website Team</p>\n"
                    + "        <div class=\"footer\" style=\"background-color: #f2f2f2; color: #666; padding: 10px; text-align: center;\">\n"
                    + "            &copy; 2023 Your Website\n"
                    + "        </div>\n"
                    + "    </div>", "text/html");

            // Send message
            Transport.send(message);

            System.out.println("Sent message successfully....");

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
