/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.ResultSet;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author FPT
 */
@MultipartConfig(fileSizeThreshold=1024*1024*2,//2mb
                     maxFileSize=1024*1024*10,//10mb
                     maxRequestSize=1024*1024*50)//50mb
public class UserProfileController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            UserDAO dao = new UserDAO();
            String service = request.getParameter("service");
            HttpSession session = request.getSession();
            String Realpath = getServletContext().getRealPath("\\dataUser\\");
            User u=(User) session.getAttribute("user");
            if (service == null) {
                service = "showProfile";
            }
            if (service.equals("showProfile")){
                String submit = request.getParameter("submit1");
                if (submit == null) {
                    ResultSet rs = dao.getData("select distinct setting_id, setting_name, setting_group from user join system_setting where setting_id");
                    request.setAttribute("Rs", rs);
                    int id = Integer.parseInt(request.getParameter("uid"));
                    Vector<User> vector = dao.getUser("select * from user where user_id =" + id);
                    request.setAttribute("data", vector);
                    dispth(request, response, "pages/common/profile.jsp");
                } else {
                    Part part = request.getPart("file");
                    String avt = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    File fileSaveDir = new File(Realpath);
                    if (!fileSaveDir.exists()) {
                        fileSaveDir.mkdirs();
                    }
                    if (!avt.equals("")) {
                        part.write(Realpath + File.separator + avt);
                    }
                   
                    String id = request.getParameter("uid");
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String mobile = request.getParameter("phone");
                    String note = request.getParameter("note");

                    int uid = Integer.parseInt(id);
                    int n=0;
                    if(!avt.equals("")){
                    User us = new User();
                    us.setAvatarUrl(avt);
                    us.setUserId(uid);
                    us.setFullName(name);
                    us.setEmail(email);
                    us.setMobile(mobile);
                    us.setNote(note);
                    n = dao.updateProfile(us);                
                    }else{
                    User us = new User();
                    us.setUserId(uid);
                    us.setFullName(name);
                    us.setEmail(email);
                    us.setMobile(mobile);
                    us.setNote(note);
                    n = dao.updateProfile2(us);   
                    }
                    if(n==1){
                        response.sendRedirect("UserProfileController?service=showProfile&uid="+id+"&success=true");
                    }else{
                        response.sendRedirect("UserProfileController?service=showProfile&uid="+id+"&success=false");
                    }
                    
                }
            }
            if (service.equals("changePass")){
                String submit1 = request.getParameter("submit2");
                Pattern passwordPattern = Pattern.compile("^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}\\[\\]:;<>,.?~\\\\-]).{8,}$");

                 // Create a Matcher object for the regular expression.
                if (submit1 == null) {
                    int id = Integer.parseInt(request.getParameter("uid"));
                    dispth(request, response, "pages/common/changepassword.jsp");
                }
                else{
                String oldPass=request.getParameter("oldPass");
                String newPass=request.getParameter("newPass");
                String cfPass=request.getParameter("cfPass");
                String id=request.getParameter("uid");
                int uid=Integer.parseInt(id);
                User us=dao.getUserbyId(uid);
                Matcher matcher = passwordPattern.matcher(newPass);
                if(!BCrypt.checkpw(oldPass, us.getPassword())){
                    String validate= "Your old password doesn't match";
                    request.setAttribute("validate", validate);
                    request.setAttribute("oldPass", oldPass);
                    request.setAttribute("newPass", newPass);
                    request.setAttribute("cfPass", cfPass);
                    request.getRequestDispatcher("pages/common/changepassword.jsp").forward(request, response);
                }else if(!matcher.matches()){
                    String validate= "Your password must have at least 8 characters, one uppercase letter, and one special character";
                    request.setAttribute("validate", validate);
                    request.setAttribute("validate", validate);
                    request.setAttribute("oldPass", oldPass);
                    request.setAttribute("newPass", newPass);
                    request.setAttribute("cfPass", cfPass);
                    request.getRequestDispatcher("pages/common/changepassword.jsp").forward(request, response);
                }
                else if(!newPass.equals(cfPass)){
                    String validate= "Your confirm password doesn't match";
                    request.setAttribute("validate", validate);
                    request.setAttribute("oldPass", oldPass);
                    request.setAttribute("newPass", newPass);
                    request.setAttribute("cfPass", cfPass);
                    request.setAttribute("validate", validate);
                    request.getRequestDispatcher("pages/common/changepassword.jsp").forward(request, response);
                }
                else{
                    String hpass = BCrypt.hashpw(cfPass, BCrypt.gensalt());
                    us.setPassword(hpass);
                    us.setUserId(uid);
                    int n=dao.changePass(us);
                    if(n==1){

                        response.sendRedirect("pages/common/login.jsp?success=true");
                    }else{
                        request.getRequestDispatcher("pages/common/changepassword.jsp").forward(request, response);
                    }
           
                }
                }
            }
            if (service.equals("changeStatus")) {
                int User_id = Integer.parseInt(request.getParameter("id"));
                int User_status = Integer.parseInt(request.getParameter("status"));

                if (User_status == 1) {
                    dao.UserStatusChange(User_id, 0);
                } else if (User_status == 0) {
                    dao.UserStatusChange(User_id, 1);
                }
                response.sendRedirect("pages/common/login.jsp");
            }
        }
    }
    public void dispth(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher dis = request.getRequestDispatcher(page);
        dis.forward(request, response);
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
        processRequest(request, response);
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
