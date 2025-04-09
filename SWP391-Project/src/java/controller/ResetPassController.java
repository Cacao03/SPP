package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import java.util.concurrent.Executors;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.concurrent.ExecutorService;
import model.User;
import util.SendMail;

/**
 *
 * @author Đàm Quang Chiến
 */
public class ResetPassController extends HttpServlet {

    private final ExecutorService emailExecutor = Executors.newFixedThreadPool(5);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResetPass</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPass at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("pages/common/resetpass.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String mode = request.getParameter("mode");

        if (mode != null) {
            switch (mode) {
                case "email-reset":
                    String accountEmail = request.getParameter("content");
                    String verifyCode = String.valueOf(session.getAttribute("verifyCode"));
                    String enteredCode = request.getParameter("verificationCode");
                    if (!verifyCode.equals(enteredCode)) {
                        request.setAttribute("failMsg", "Verification code does not match!");
                        request.getRequestDispatcher("pages/common/resetpass.jsp").forward(request, response);
                    } else {
                        request.setAttribute("account", accountEmail);
                        request.getRequestDispatcher("pages/common/changepass.jsp").forward(request, response);
                    }
                    break;

                case "phone-reset":
                    String accountPhone = request.getParameter("content");
                    request.setAttribute("account", accountPhone);
                    request.getRequestDispatcher("pages/common/changepass.jsp").forward(request, response);

                    break;

                case "change-pass":
                    String account = request.getParameter("account");
                    String newPass = request.getParameter("confirm-password");
                    User user = new User();
                    String modeChange = account.contains("@") ? "email" : "mobile";
                    boolean check = true;

                    if (modeChange.equals("email")) {
                        check = user.changePassword(BCrypt.hashpw(newPass, BCrypt.gensalt()), account, "email");

                    } else {
                        check = user.changePassword(BCrypt.hashpw(newPass, BCrypt.gensalt()), account, "mobile");
                    }
                    if (check) {
                        request.setAttribute("success", "Change password successfully");
                        request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("pages/index.html");
                    }
                    break;
            }

        } else {
            String email = request.getParameter("email");

            // Send email asynchronously
            Runnable emailTask = () -> {
                SendMail send = new SendMail();
                send.sendMail(session, email, null, "Reset password verification");
            };

            // Submit the task to the ExecutorService for asynchronous execution
            emailExecutor.submit(emailTask);
            
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
