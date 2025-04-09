/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import org.mindrot.jbcrypt.BCrypt;
import enums.UserRole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import java.util.concurrent.Executors;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.concurrent.ExecutorService;
import model.User;
import util.SendMail;

public class RegisterController extends HttpServlet {

    private final ExecutorService emailExecutor = Executors.newFixedThreadPool(5);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Register at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String regisType = request.getParameter("registrationType");
        String name = (request.getParameter("name") != null) ? request.getParameter("name") : "";
        String phone = (request.getParameter("phone") != null) ? request.getParameter("phone") : "";
        String password = request.getParameter("password");
        request.setAttribute("email", email);
        request.setAttribute("regisType", regisType);
        request.setAttribute("name", name);
        request.setAttribute("phone", phone);
        request.setAttribute("password", password);
        request.getRequestDispatcher("pages/common/verification.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String email = request.getParameter("email");
        String name = request.getParameter("name");
        if (request.getParameter("mode") != null) {

            UserRole studentRole = UserRole.STUDENT;

            String phone = request.getParameter("phone");
            if (phone != null && phone.startsWith("84")) {
                phone = "0" + phone.substring(2); // Replace "84" with "0"
            }
            String password = request.getParameter("password");
            int stRole = studentRole.getValue();

            User user = new User(name, email, phone, BCrypt.hashpw(password, BCrypt.gensalt()), stRole, null);

            if (request.getParameter("mode").equals("register")) {

                boolean result = user.createNewUser();
                if (result) {
                    request.setAttribute("success", "Register successfully, please login!");
                    request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
                } else {
                    response.sendRedirect("pages/common/register.jsp");
                }

            } else if (request.getParameter("mode").equals("email-register")) {

                String enteredCode = request.getParameter("verificationCode");
                String verifyCode = String.valueOf(session.getAttribute("verifyCode"));

                if (!enteredCode.equals(verifyCode)) {
                    request.setAttribute("failMsg", "Your verify code is not match, please enter again");
                    request.getRequestDispatcher("pages/common/verification.jsp").forward(request, response);
                } else {
                    boolean result = user.createNewUser();
                    if (result) {
                        request.setAttribute("success", "Register successfully, please login!");
                        request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("pages/common/register.jsp");
                    }
                }

            } else if (request.getParameter("mode").equals("sendVerifyCode")) {
                    
                Runnable emailTask = () -> {
                    SendMail send = new SendMail();
                    send.sendMail(session, email, name, "Email verification");
                };
//                // Submit the task to the ExecutorService for asynchronous execution
                emailExecutor.submit(emailTask);
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
