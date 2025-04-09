/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.SubjectManagers;

import dal.SubjectDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Subject;
import model.User;

/**
 *
 * @author hungd
 */
public class SubjectController extends HttpServlet {

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
        SubjectDAO dao = new SubjectDAO();
        HttpSession session = request.getSession();
        String service = request.getParameter("service");
        try ( PrintWriter out = response.getWriter()) {
            User user = (User) session.getAttribute("user");
            int userID = user.getUserId();
            int role = user.getRoleId();
            /* TODO output your page here. You may use following sample code. */
            String indexPage = request.getParameter("index");
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);
            int count = dao.getTotalAccount(userID, role);
            int endPage = count / 10;
            if (count % 10 != 0) {
                endPage++;
            }
            if (service == null) {
                service = "display";
            }
            if (service.equals("display")) {
                List<Subject> list = dao.pagingSubject(index, role, userID);
                request.setAttribute("data", list);
                List<User> listName = dao.getName();
                List<User> list3 = dao.getManager();
                request.setAttribute("data3", list3);
                request.setAttribute("manageN", listName);
                request.setAttribute("endPAdmin", endPage);
                RequestDispatcher dis = request.getRequestDispatcher("pages/admin/Subject/subjectList.jsp");
                dis.forward(request, response);

            }

            if (service.equals("insertSubject")) {
                String submit = request.getParameter("submit");
                ResultSet rsSub = dao.listAll();
                request.setAttribute("rsSub", rsSub);
                ResultSet Rs1 = dao.getData("select distinct user_id, full_name, role_id, is_active from user where role_id = 15 and is_active = 1");
                request.setAttribute("Rs1", Rs1);
                if (submit == null) { // form chua chay--> show jsp
                    //show jsp
                    Vector<Subject> vectorB = dao.getField("manager_id");

                    // set data for view
                    request.setAttribute("dataB", vectorB);

                    dispth(request, response, "/pages/admin/Subject/subjectAdd.jsp");
                } else {// insert

                    String subject_code = request.getParameter("subject_code");
                    String subject_name = request.getParameter("subject_name");
                    String manager = request.getParameter("manager");
                    String description = request.getParameter("description");
                    int isActive = Integer.parseInt(request.getParameter("status"));

                    if (subject_code.length() > 20 ) {
                        request.setAttribute("noti", "Subject Code must be shorter than 20 characters");
                        request.setAttribute("subject_code", subject_code);
                        request.setAttribute("subject_name", subject_name);
                        dispth(request, response, "/pages/admin/Subject/subjectAdd.jsp");

                    }
                    else if (subject_name.length() > 50) {
                        request.setAttribute("noti", "Subject Name must be shorter than 50 characters");
                        request.setAttribute("subject_code", subject_code);
                        request.setAttribute("subject_name", subject_name);
                        dispth(request, response, "/pages/admin/Subject/subjectAdd.jsp");
                    }
                    else if (dao.isSubjectCodeDuplicate(subject_code)) {
                        request.setAttribute("noti", "Subject code existed!");
                        request.setAttribute("subject_code", subject_code);
                        request.setAttribute("subject_name", subject_name);
                        dispth(request, response, "/pages/admin/Subject/subjectAdd.jsp");

                    } else {
                        int managerInt = Integer.parseInt(manager);
                        Subject sub = new Subject();
                        sub.setSubjectCode(subject_code);
                        sub.setSubjectName(subject_name);
                        sub.setManagerID(managerInt);
                        sub.setIsActive(isActive);
                        sub.setDescription(description);
                        int n = dao.insertSubject(sub);
                        if (n == 1) {
                            response.sendRedirect("SubjectController?service=display&success=true1");
                        } else {
                            response.sendRedirect("SubjectController?service=display&success=false1");
                        }
                    }
                }
            }

            if (service.equals("updateSubject")) {
                String submit = request.getParameter("submit");
                if (submit == null) { // form chua chay--> show jsp
                    //show jsp
                    String subjectID = request.getParameter("id");
                    int id = Integer.parseInt(request.getParameter("id"));
                    Subject listSubject = dao.getSubjectDetailsUpdate(subjectID);
                    request.setAttribute("listSubject", listSubject);
                    ResultSet Rs1 = dao.getData("select distinct user_id, full_name, role_id from user ");
                    request.setAttribute("Rs1", Rs1);
                    Vector<Subject> vector = dao.getSubject("select * from subject where subject_id =" + id);
                    // set data for view
                    request.setAttribute("dataS", vector);

                    dispth(request, response, "/pages/admin/Subject/subjectUpdate.jsp");
                } else {// update
                    //code here
                    String subject_id = request.getParameter("subject_id");
                    String subject_code = request.getParameter("subject_code");
                    String subject_name = request.getParameter("subject_name");
                    String manager = request.getParameter("manager");
                    String active = request.getParameter("status");
                    String descrip = request.getParameter("Description");
                    Subject subdb = dao.getSubjectById3(subject_id);
                    if (subdb.getSubjectCode().equals(subject_code)) {
                        int subjectidInt = Integer.parseInt(subject_id);
                        int isActive = Integer.parseInt(active);
                        int managerInt = Integer.parseInt(manager);
                        Subject sub = new Subject();
                        sub.setSubjectId(subjectidInt);
                        sub.setSubjectCode(subject_code);
                        sub.setSubjectName(subject_name);
                        sub.setManagerID(managerInt);
                        sub.setIsActive(isActive);
                        sub.setDescription(descrip);
                        int n = dao.updateSubject(sub);
                        if (n == 1) {
                            response.sendRedirect("SubjectController?service=display&success=true");
                        } else {
                            response.sendRedirect("SubjectController?service=display&success=false");
                        }
                    } else {
                        boolean check = dao.checkDulicate(subject_code);
                        if (check == true) {
                            request.setAttribute("noti", "Subject code are existed!");
                            request.setAttribute("subject_code", subject_code);
                            request.setAttribute("subject_name", subject_name);
                            ResultSet Rs1 = dao.getData("select distinct user_id, full_name, role_id from user ");
                            request.setAttribute("Rs1", Rs1);
                            Vector<Subject> vector = dao.getSubject("select * from subject where subject_id =" + subject_id);
                            request.setAttribute("dataS", vector);
                            dispth(request, response, "/pages/admin/Subject/subjectUpdate.jsp");

                        } else if (subject_code.length() > 20 || subject_name.length() > 50) {
                            request.setAttribute("noti", "Subject Name and Subject Code must be shorter than 50 characters");
                            request.setAttribute("subject_code", subject_code);
                            request.setAttribute("subject_name", subject_name);
                            ResultSet Rs1 = dao.getData("select distinct user_id, full_name, role_id from user ");
                            request.setAttribute("Rs1", Rs1);
                            Vector<Subject> vector = dao.getSubject("select * from subject where subject_id =" + subject_id);
                            request.setAttribute("dataS", vector);
                            dispth(request, response, "/pages/admin/Subject/subjectUpdate.jsp");
                        } else {
                            //check data
                            // convert
                            int subjectidInt = Integer.parseInt(subject_id);
                            int managerInt = Integer.parseInt(manager);
                            Subject sub = new Subject(subjectidInt, subject_code, subject_name, managerInt);
                            int n = dao.updateSubject(sub);
                            if (n == 1) {
                                response.sendRedirect("SubjectController?service=display&success=true");
                            } else {
                                response.sendRedirect("SubjectController?service=display&success=false");
                            }
                        }
                    }

                }
            }
            if (service.equals("SearchSubject_Code")) {
                String name = request.getParameter("search_code");

                // set data for view
                if (name.equals("")) {
                    Vector<Subject> vector = dao.getSubject("select * from subject");
                    request.setAttribute("data", vector);
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    response.sendRedirect("SubjectController");
                } else {
                    Vector<Subject> vector = dao.getSubject("SELECT * FROM subject s INNER JOIN user u ON user_id= manager_id WHERE u.full_name LIKE '%" + name + "%' or s.subject_code like'%" + name + "%' or s.subject_name like '%" + name + "%' or s.update_at like '%" + name + "%'");
                    System.out.println(vector.size());
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    request.setAttribute("data", vector);
                    dispth(request, response, "pages/admin/Subject/subjectList.jsp");
                }
                return;
            }
            if (service.equals("changeStatus")) {

                int Subject_id = Integer.parseInt(request.getParameter("id"));
                int Subject_status = Integer.parseInt(request.getParameter("status"));

                if (Subject_status == 1) {
                    dao.SubjectStatusChange(Subject_id, 0);
                } else if (Subject_status == 0) {
                    dao.SubjectStatusChange(Subject_id, 1);
                }
                response.sendRedirect("SubjectController");
            }
            if (service.equals("checkStatus")) {

                String checkActive = request.getParameter("checkActive");
                if (checkActive.equals("display")) {
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    response.sendRedirect("SubjectController");
                } else {
                    Vector<Subject> vector = dao.getSubject("select * from subject where is_active LIKE '%" + checkActive + "%'");
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    request.setAttribute("data", vector);
                    request.getRequestDispatcher("pages/admin/Subject/subjectList.jsp").forward(request, response);
                }
            }
        }
    }

    public void dispth(HttpServletRequest request,
            HttpServletResponse response, String page)
            throws IOException, ServletException {
        RequestDispatcher dis = request.getRequestDispatcher(page);
        // run
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
