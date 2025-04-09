/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Setting;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Đàm Quang Chiến
 */
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        User user = new User();

        if (account.contains("@")) {
            user = user.getUserByEmailOrPhone("email", account);
            if (user != null) {
                if (BCrypt.checkpw(password, user.getPassword())) {
                    Setting sysSetting = new Setting();
                    int userRole = sysSetting.getSettingByID(user.getRoleId()).getSettingId();
                    int isRoleActive = sysSetting.checkSettingActive(userRole);
                    if (user.getIsActive() == 1 && isRoleActive == 1) {
                        session.setAttribute("user", user);
                        switch (userRole) {
                            case 14:
                                response.sendRedirect("UserController?service=listAll");
                                break;
                            case 16:
                                response.sendRedirect("ClassController");
                                break;
                            case 15:
                                response.sendRedirect("manageSubjectController?service=display");
                                break;
                            case 18: 
                                response.sendRedirect("ManageProjectController");
                                break;
                            case 19:
                                response.sendRedirect("Dashboard");
                                break;
                        }
                    } else {
                        request.setAttribute("msg", "You are not allow to access our system!");
                        request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("msg", "Your password is not correct");
                    request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "Your email/phone is not correct");
                request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
            }

        } else {
            user = user.getUserByEmailOrPhone("mobile", account);
            if (user != null) {
                if (BCrypt.checkpw(password, user.getPassword())) {
                    session.setAttribute("user", user);
                    Setting sysSetting = new Setting();
                    int userRole = sysSetting.getSettingByID(user.getRoleId()).getSettingId();
                    int isRoleActive = sysSetting.checkSettingActive(userRole);
                    if (user.getIsActive() == 1 && isRoleActive == 1) {
                        session.setAttribute("user", user);
                        switch (userRole) {
                            case 14:
                                response.sendRedirect("UserController?service=listAll");
                                break;
                            case 16:
                                response.sendRedirect("ClassController");
                                break;
                            case 15:
                                response.sendRedirect("manageSubjectController?service=display");
                                break;
                            case 19:
                                response.sendRedirect("Dashboard");
                                break;
                            case 18:
                                response.sendRedirect("ManageProjectController");
                                break;
                        }
                    } else {
                        request.setAttribute("msg", "You are not allow to access our system!");
                        request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("msg", "Your password is not correct");
                    request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "Your email/phone is not correct");
                request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
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
