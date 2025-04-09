/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.SubjectManagers;

import dal.ClassDAO;
import model.Class;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;
import model.AssignClass;
import model.Setting;
import model.Subject;
import model.User;

/**
 *
 * @author FPT
 */
public class ClassController extends HttpServlet {

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
//        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ClassDAO dao = new ClassDAO();
            HttpSession session = request.getSession();
            User u=(User) session.getAttribute("user");
            String service = request.getParameter("service");
            String submit = request.getParameter("submit1");
            String indexPage = request.getParameter("index");
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);

            if (service == null) {
                service = "listAll";
            }
            if (service.equals("listAll")) {
                int count = dao.getTotalAccount(u.getRoleId(),u.getUserId());
                int endPage = count / 10;
                if (count % 10 != 0) {
                    endPage++;
                }
                request.setAttribute("listAll", service);
                List<Class> list = dao.pagingClass(index,u.getRoleId(),u.getUserId());
                request.setAttribute("data", list);
                List<Setting> list1 = dao.getSemester1(u.getRoleId(),u.getUserId());
                request.setAttribute("data1", list1);
                List<Subject> list2 = dao.getSubject1(u.getRoleId(),u.getUserId());
                request.setAttribute("data2", list2);
                List<User> list3 = dao.getManager1(u.getRoleId(),u.getUserId());
                request.setAttribute("data3", list3);
                List<Setting> list4 = dao.getSemester();
                request.setAttribute("data4", list4);
                List<Subject> list5 = dao.getSubject();
                request.setAttribute("data5", list5);
                List<User> list6 = dao.getManager();
                request.setAttribute("data6", list6);
//                List<Setting>list1=dao.getName();
//                request.setAttribute("data1", list1);
                request.setAttribute("endP", endPage);
                RequestDispatcher dis = request.getRequestDispatcher("pages/subjectManager/classList.jsp");
                dis.forward(request, response);
            }
            if (service.equals("showDetails")) {
                
                RequestDispatcher dis = request.getRequestDispatcher("pages/subjectManager/classDetails.jsp");
                dis.forward(request, response);
            }
            if (service.equals("addClass")) {
                String submit2 = request.getParameter("submit2");
                Class cl_check=dao.getClassCode();
                int n=0;
                if (submit2 == null) {
                    List<Setting> list4 = dao.getSemester();
                    request.setAttribute("data4", list4);
                    List<Subject> list5 = dao.getSubject();
                    request.setAttribute("data5", list5);
                    List<User> list6 = dao.getManager();
                    request.setAttribute("data6", list6);
                    dispth(request, response, "pages/subjectManager/classList.jsp");
                } else {
                    String code = request.getParameter("code");
                    String semester = request.getParameter("semester");
                    String subject = request.getParameter("subject");
                    String manager = request.getParameter("manager");
                    String status = request.getParameter("status");
                    String gitlab = request.getParameter("gitlab");
                    

                    int semesterInt = Integer.parseInt(semester);
                    int subjectInt = Integer.parseInt(subject);
                    int managerInt = Integer.parseInt(manager);
                    int statusInt = Integer.parseInt(status);

                    Class cl = new Class();
                    cl.setClassCode(code);
                    cl.setSemesterId(semesterInt);
                    cl.setSubjectId(subjectInt);
                    cl.setManagerId(managerInt);
                    cl.setStatus(statusInt);
                    cl.setGitlabId(gitlab);
                    
                    if(cl_check.getClassCode().equals(code)){
                        n=0;
                    }else{
                        n = dao.insertClass(cl);
                    }
                    if(n==1){
                        session.setAttribute("successMessage", "Class added successfully!");
                        response.sendRedirect("ClassController?service=listAll&&success=true");
                    }
                    else{
                        session.setAttribute("errorMessage", "Failed to add class!");
                        response.sendRedirect("ClassController?service=listAll&success=false");
                    }

                }
            }
            if (service.equals("updateClass")) {
                String submit3= request.getParameter("submit3");            
                int n=0;
                if (submit3 == null) {
                    ResultSet rs1 = dao.getData("select distinct setting_id, setting_name, setting_group from class join system_setting where setting_group in (1) and is_active in (1)");
                    request.setAttribute("Rs", rs1);
                    ResultSet rs2 = dao.getData("select distinct user_id, full_name from class join user where user.role_id in (16) and is_active in (1)");
                    request.setAttribute("Rs2", rs2);
                    if(u.getRoleId()==14 || u.getRoleId()==16){
                    ResultSet rs3 = dao.getData("select distinct subject.subject_id, subject_name from class join subject where is_active in (1)");
                    request.setAttribute("Rs3", rs3); 
                    }else if(u.getRoleId()==15){
                    ResultSet rs3 = dao.getData("select distinct subject.subject_id, subject_name from class join subject where is_active in (1) and subject.manager_id="+u.getUserId());
                    request.setAttribute("Rs3", rs3);
                    }
                    int id = Integer.parseInt(request.getParameter("cid"));
                    AssignClass assignClass = dao.getClassInfor(id);
                    Vector<Class> vector = dao.getClass("select * from class where class_id =" + id);
                    request.setAttribute("data2", vector);
                    request.setAttribute("assignClass", assignClass);
                    dispth(request, response, "pages/subjectManager/classDetails.jsp");
                } else {
                    String id = request.getParameter("cid");
                    String code = request.getParameter("code");
                    String semester = request.getParameter("semester");
                    String subject = request.getParameter("subject");
                    String manager = request.getParameter("manager");
                    String status = request.getParameter("status");
                    String gitlab = request.getParameter("gitlab");
                    String details = request.getParameter("details");
                    String acctoken = request.getParameter("acctoken");
                            
                    int cid = Integer.parseInt(id);
                    int semesterInt = Integer.parseInt(semester);
                    int subjectInt = Integer.parseInt(subject);
                    int managerInt = Integer.parseInt(manager);
                    int statusInt = Integer.parseInt(status);
                    
                    
                    Class cl_checkCode = dao.getClassCodeById(cid);
                    Class cl_checkDuplicate = dao.getClassCode();
                    if(cl_checkCode.getClassCode().equals(code)){
                        Class cl = new Class(cid, code, details, semesterInt, subjectInt, managerInt, statusInt, gitlab,acctoken);
                        n = dao.updateClass(cl);
                    }else{
                        if(cl_checkDuplicate.getClassCode().equals(code)){
                            response.sendRedirect("ClassController?service=updateClass&cid="+cid+"&success=false");
                        }else{
                            Class cl = new Class(cid, code, details, semesterInt, subjectInt, managerInt, statusInt, gitlab,acctoken);
                            n = dao.updateClass(cl);
                        }
                    }
                    
                    if(n==1){
                        response.sendRedirect("ClassController?service=updateClass&cid="+cid+"&success=true");
                    }
                    else{
                        
                        response.sendRedirect("ClassController?service=updateClass&cid="+cid+"&success=false");
                    }
                }
            }
            if (service.equals("changeStatus")) {
                int Class_id = Integer.parseInt(request.getParameter("id"));
                int Class_status = Integer.parseInt(request.getParameter("status"));

                if (Class_status == 1) {
                    dao.ClassStatusChange(Class_id, 2);
                } else if (Class_status == 0) {
                    dao.ClassStatusChange(Class_id, 1);
                }
                response.sendRedirect("ClassController");
            }
            if (service.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                int n = dao.delete(id);
                response.sendRedirect("ClassController");
            }
            if (service.equals("searchName")) {
                String name = request.getParameter("name");
                // set data for view
                if (name.equals("")) {
                    int count = dao.getTotalAccount(u.getRoleId(),u.getUserId());
                    int endPage = count / 10;
                    if (count % 10 != 0) {
                        endPage++;
                    }

                    List<Class> list = dao.pagingClass(index,u.getRoleId(),u.getUserId());
                    request.setAttribute("data", list);
                    List<Setting> list1 = dao.getSemester1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data1", list1);
                    List<Subject> list2 = dao.getSubject1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data2", list2);
                    List<User> list3 = dao.getManager1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data3", list3);
                    request.setAttribute("endP", endPage);
                    dispth(request, response, "pages/subjectManager/classList.jsp");

                } else {

                    List<Class> list = dao.search(u.getRoleId(),u.getUserId(),name);
                    request.setAttribute("data", list);
                    List<Setting> list1 = dao.getSemester1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data1", list1);
                    List<Subject> list2 = dao.getSubject1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data2", list2);
                    List<User> list3 = dao.getManager1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data3", list3);
                    request.setAttribute("name", name);
                    dispth(request, response, "pages/subjectManager/classList.jsp");
                }
                return;
            }
            if (service.equals("filterStatus")) {

                String checkStatus = request.getParameter("checkStatus");
                if (checkStatus.equals("display")) {
                    response.sendRedirect("ClassController");
                } else {
                    List<Class> list = dao.filter(u.getRoleId(),u.getUserId(),"status",Integer.parseInt(checkStatus));
                    List<Setting> list1 = dao.getSemester1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data1", list1);
                    List<Subject> list2 = dao.getSubject1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data2", list2);
                    List<User> list3 = dao.getManager1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data3", list3);
                    request.setAttribute("data", list);
                    request.getRequestDispatcher("pages/subjectManager/classList.jsp").forward(request, response);
                }
            }
            if (service.equals("filterSubject")) {

                String checkSubject = request.getParameter("checkSubject");
                if (checkSubject.equals("display")) {
                    response.sendRedirect("ClassController");
                } else {
                    List<Class> list = dao.filter(u.getRoleId(),u.getUserId(),"subject_id",Integer.parseInt(checkSubject));
                    List<Setting> list1 = dao.getSemester1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data1", list1);
                    List<Subject> list2 = dao.getSubject1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data2", list2);
                    List<User> list3 = dao.getManager1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data3", list3);
                    request.setAttribute("data", list);
                    request.getRequestDispatcher("pages/subjectManager/classList.jsp").forward(request, response);
                }
            }
            if (service.equals("filterTeacher")) {

                String checkTeacher = request.getParameter("checkTeacher");
                if (checkTeacher.equals("display")) {
                    response.sendRedirect("ClassController");
                } else {
                    List<Class> list = dao.filter(u.getRoleId(),u.getUserId(),"manager_id",Integer.parseInt(checkTeacher));
                    List<Setting> list1 = dao.getSemester1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data1", list1);
                    List<Subject> list2 = dao.getSubject1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data2", list2);
                    List<User> list3 = dao.getManager1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data3", list3);
                    request.setAttribute("data", list);
                    request.getRequestDispatcher("pages/subjectManager/classList.jsp").forward(request, response);
                }
            }
            if (service.equals("filterSemester")) {

                String checkSemester = request.getParameter("checkSemester");
                if (checkSemester.equals("display")) {
                    response.sendRedirect("ClassController");
                } else {
                    List<Class> list = dao.filter(u.getRoleId(),u.getUserId(),"semester_id",Integer.parseInt(checkSemester));
                    List<Setting> list1 = dao.getSemester1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data1", list1);
                    List<Subject> list2 = dao.getSubject1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data2", list2);
                    List<User> list3 = dao.getManager1(u.getRoleId(),u.getUserId());
                    request.setAttribute("data3", list3);
                    request.setAttribute("data", list);
                    request.getRequestDispatcher("pages/subjectManager/classList.jsp").forward(request, response);
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

