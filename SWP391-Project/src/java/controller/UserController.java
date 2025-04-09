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
import java.security.SecureRandom;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import model.Setting;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import util.SendMailPass;

/**
 *
 * @author FPT
 */
@MultipartConfig()
public class UserController extends HttpServlet {

    private static final String UPPER_CASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWER_CASE = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL_CHARACTERS = "!@#$%^&*()-_+=<>?";
     private final ExecutorService emailExecutor = Executors.newFixedThreadPool(5);

    public String generatePassword() {
        StringBuilder password = new StringBuilder();
        SecureRandom random = new SecureRandom();

        // Add at least one uppercase character
        password.append(UPPER_CASE.charAt(random.nextInt(UPPER_CASE.length())));

        // Add at least one digit
        password.append(DIGITS.charAt(random.nextInt(DIGITS.length())));

        // Add at least one special character
        password.append(SPECIAL_CHARACTERS.charAt(random.nextInt(SPECIAL_CHARACTERS.length())));

        // Add remaining characters
        int remainingLength = 8 - password.length();
        String allCharacters = UPPER_CASE + LOWER_CASE + DIGITS + SPECIAL_CHARACTERS;
        for (int i = 0; i < remainingLength; i++) {
            password.append(allCharacters.charAt(random.nextInt(allCharacters.length())));
        }

        // Shuffle the characters in the password to make it random
        return shuffleString(password.toString());
    }

    private String shuffleString(String input) {
        char[] characters = input.toCharArray();
        SecureRandom random = new SecureRandom();
        for (int i = characters.length - 1; i > 0; i--) {
            int index = random.nextInt(i + 1);
            char temp = characters[index];
            characters[index] = characters[i];
            characters[i] = temp;
        }
        return new String(characters);
    }
    
    public <T> List<T> paginate(List<T> allUsers, int pageNumber, int pageSize) {
        int startIndex = (pageNumber - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, allUsers.size());

        if (startIndex >= allUsers.size()) {
            // If the start index is beyond the list size, return an empty list.
            return new ArrayList<>();
        }

        return allUsers.subList(startIndex, endIndex);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            UserDAO dao = new UserDAO();
            String Realpath = getServletContext().getRealPath("\\dataUser\\");
            HttpSession session = request.getSession();
            String service = request.getParameter("service");
            String submit = request.getParameter("submit1");
            String indexPage =request.getParameter("index");
                    if(indexPage==null){
                    indexPage="1";
                    }
                    int index = Integer.parseInt(indexPage);
              
            if (service == null) {
                service = "listAll";
            }
            if (service.equals("listAll")) { 
                int count=dao.getTotalAccount();
                int endPage =count/10;
                if(count % 10 !=0){
                    endPage++;
                }
                request.setAttribute("listAll", service);
                List<User> list = dao.pagingUser(index);
                request.setAttribute("data", list);
                List<Setting>list1=dao.getName();
                request.setAttribute("data1", list1);
                request.setAttribute("endP", endPage);
                RequestDispatcher dis = request.getRequestDispatcher("pages/admin/user/userList.jsp");
                dis.forward(request, response);
            }
            if (service.equals("addUser")) {

                if (submit == null) {
                    ResultSet rs = dao.getData("select distinct setting_id, setting_name, setting_group from user join system_setting where setting_id not in (14)");
                    request.setAttribute("Rs", rs);
                    Vector<User> vector = dao.getUser("select * from User limit 5");
                    // set data for view
                    request.setAttribute("data", vector);

                    dispth(request, response, "pages/admin/user/newUser.jsp");
                } else {

//                    Part part = request.getPart("file");
//                    String avt = Paths.get(part.getSubmittedFileName()).getFileName().toString();
//                    File fileSaveDir = new File(Realpath);
//                    if (!fileSaveDir.exists()) {
//                        fileSaveDir.mkdirs();
//                    }
//                    if (!avt.equals("")) {
//                        part.write(Realpath + File.separator + avt);
//                    }
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String mobile = request.getParameter("phone");
                    String role = request.getParameter("role");
                    String note = request.getParameter("note");

                    String pass = generatePassword();
                    Runnable emailTask = () -> {
                        SendMailPass send = new SendMailPass();
                        send.sendMail(session, email, pass, "New User Password");
                    };

                    // Submit the task to the ExecutorService for asynchronous execution
                    emailExecutor.submit(emailTask);
                    
                    String hpass = BCrypt.hashpw(pass, BCrypt.gensalt());
                    int roleInt = Integer.parseInt(role);
                    User us = new User(name, email, mobile, hpass, roleInt, note);
                    int n = dao.insertUser(us);
                    if(n==1){
                        response.sendRedirect("UserController?service=listAll&success=true");
                    }else{
                        response.sendRedirect("UserController?service=listAll&success=false");
                    }
                }
            }

            if (service.equals("updateUser")) {
                if (submit == null) {
                    ResultSet rs = dao.getData("select distinct setting_id, setting_name, setting_group from user join system_setting where setting_id not in (14)");
                    request.setAttribute("Rs", rs);
                    int id = Integer.parseInt(request.getParameter("uid"));
                    Vector<User> vector = dao.getUser("select * from user where user_id =" + id);
                    request.setAttribute("data", vector);
                    Vector<User> vector1 = dao.getUser("select * from User limit 5");
                    // set data for view
                    request.setAttribute("data1", vector1);
                    dispth(request, response, "pages/admin/user/userUpdate.jsp");
                } else {
                    String id = request.getParameter("uid");
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String mobile = request.getParameter("phone");
                    String role = request.getParameter("role");
                    String note = request.getParameter("note");

                    int uid = Integer.parseInt(id);
                    int roleInt = Integer.parseInt(role);
                    User us = new User(uid, name, email, mobile, null, roleInt, note);
                    int n = dao.updateUser(us);
                    if(n==1){
                        response.sendRedirect("UserController?service=updateUser&uid="+id+"&success=true");
                    }else{
                        response.sendRedirect("UserController?service=updateUser&uid="+id+"&success=false");
                    }
                }
            }
            if (service.equals("searchName")) {
                String name = request.getParameter("name");
                request.setAttribute("searchName", service);      
                // set data for view
                if (name.equals("")) {
                    int count=dao.getTotalAccount();
                    int endPage =count/10;
                    if(count % 10 !=0){
                        endPage++;
                    }
                    List<User> list = dao.pagingUser(index);
                    request.setAttribute("data", list);
                    List<Setting>list1=dao.getName();
                    request.setAttribute("data1", list1);
                    request.setAttribute("endP", endPage);
                    
                    dispth(request, response, "pages/admin/user/userList.jsp");
                } else {
                    
                    int count=dao.getTotalAccount1(name);
                    int endPage =count/10;
                    if(count % 10 !=0){
                        endPage++;
                    }
                    List<User> list =dao.searchName(index, name);
                    request.setAttribute("data", list);
                    List<Setting>list1=dao.getName();
                    request.setAttribute("name", name);
                    request.setAttribute("data1", list1);
                    request.setAttribute("endP", endPage);
                    
//                    Vector<User> vector = dao.getUser("SELECT * FROM User u INNER JOIN System_setting s "
//                + "ON u.role_id = s.setting_id WHERE u.full_name LIKE '%"+name+"%' or u.user_id like '"+name+"%' or s.setting_name like '%"+name+"%'");
//                    List<User> list = Collections.list(vector.elements());
//                    List<User> list1 = paginate(list, 3, 5);
//                    request.setAttribute("data", list1);
//                    ResultSet rs = dao.getData("select distinct setting_id, setting_name, setting_group from user join system_setting");
//                    request.setAttribute("Rs", rs);
//                    request.setAttribute("data", vector);
                    dispth(request, response, "pages/admin/user/userList.jsp");
                }
                return;
            }
            if (service.equals("changeStatus")) {
                int User_id = Integer.parseInt(request.getParameter("id"));
                int User_status = Integer.parseInt(request.getParameter("status"));

                if (User_status == 1) {
                    dao.UserStatusChange(User_id, 0);
                } else if (User_status == 0) {
                    dao.UserStatusChange(User_id, 1);
                }
                response.sendRedirect("UserController?service=listAll");
            }
            if (service.equals("changeStatus2")) {
                int User_id = Integer.parseInt(request.getParameter("id"));
                int User_status = Integer.parseInt(request.getParameter("status"));

                if (User_status == 1) {
                    dao.UserStatusChange(User_id, 0);
                } else if (User_status == 0) {
                    dao.UserStatusChange(User_id, 1);
                }
                response.sendRedirect("UserController?service=updateUser&uid="+User_id);
            }
            if (service.equals("checkStatus")) {

                String checkActive = request.getParameter("checkActive");
                if (checkActive.equals("display")) {   
                    response.sendRedirect("UserController");
                } else {
                    Vector<User> vector = dao.getUser("select * from user where is_active LIKE '%"+checkActive+"%'");
                    List<Setting> list1 = dao.getName();
                    request.setAttribute("data1", list1);
                    request.setAttribute("data", vector);
                    request.getRequestDispatcher("pages/admin/user/userList.jsp").forward(request, response);
                }
            }
            if (service.equals("filterRole")) {

                String checkRole = request.getParameter("checkRole");
                if (checkRole.equals("display")) {   
                    response.sendRedirect("UserController");
                } else {
                    Vector<User> vector = dao.getUser("select * from user where role_id= '"+checkRole+"'");
                    List<Setting> list1 = dao.getName();
                    request.setAttribute("data1", list1);
                    request.setAttribute("data", vector);
                    request.getRequestDispatcher("pages/admin/user/userList.jsp").forward(request, response);
                }
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
