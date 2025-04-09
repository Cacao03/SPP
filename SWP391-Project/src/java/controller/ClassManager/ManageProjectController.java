/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ClassManager;

import model.Project;
import dal.ProjectDAO;
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
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import util.ExcelHandler;

/**
 *
 * @author TRAN DUNG
 */
@MultipartConfig()
public class ManageProjectController extends HttpServlet {

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
        String service = request.getParameter("service");
        ProjectDAO dao = new ProjectDAO();
        HttpSession session = request.getSession();

        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            User user = (User) session.getAttribute("user");
            int userID = user.getUserId();
            int role = user.getRoleId();
            if (service == null) {
                //Class manager
                if (role == 16) {
                    service = "SelectClass";
                }
                //Admin 
                if (role == 14) {
                    service = "SelectAllClass";
                }
                //Project mentor
                if (role == 18) {
                    service = "SelectAllClassOfProjectMentor";
                }
                //subject manager
                if (role == 15) {
                    service = "SelectAllClassOfSubject";
                }
            }
            if (service.equals("SelectAllClassOfSubject")) {
                ResultSet rsClass = dao.getAllClassOfSubject(userID);
                request.setAttribute("rsClass", rsClass);
                request.getRequestDispatcher("./pages/classManager/Project/SelectClass.jsp").forward(request, response);
            }
            if (service.equals("SelectAllClassOfProjectMentor")) {
                ResultSet rsClass = dao.getAllClassProjectMentor(userID);
                request.setAttribute("rsClass", rsClass);
                request.getRequestDispatcher("./pages/classManager/Project/SelectClass.jsp").forward(request, response);
            }
            if (service.equals("SelectClass")) {
                ResultSet rsClass = dao.getAllClassClassManager(userID);
                request.setAttribute("rsClass", rsClass);
                request.getRequestDispatcher("./pages/classManager/Project/SelectClass.jsp").forward(request, response);
            }
            if (service.equals("SelectAllClass")) {
                ResultSet rsClass = dao.getAllClassAdmin();
                request.setAttribute("rsClass", rsClass);
                request.getRequestDispatcher("./pages/classManager/Project/SelectClass.jsp").forward(request, response);
            }
            if (service.equals("ProjectList")) {
                String class_id = request.getParameter("class_id");
                ResultSet rsProject = dao.getProjectByClassID(class_id);
                ResultSet rsClassCode = dao.getClassCode(class_id);
                ResultSet rsAllMentorName = dao.getAllMentorName();
                ResultSet rsAllCo_MentorName = dao.getAllMentorName();
                //member//
                ResultSet rsWaitingList = dao.getWaitingList(class_id);
                ResultSet rsProjectForAdd = dao.getProjectByClassID(class_id);
                ResultSet rsProjectForMove = dao.getProjectByClassID(class_id);
                List<Project> lsProject = new ArrayList<>();
                while (rsProjectForMove.next()) {
                    Project pro = new Project();

                    pro.setProject_id(Integer.parseInt(rsProjectForMove.getString(1)));
                    pro.setProject_code(rsProjectForMove.getString(2));
                    lsProject.add(pro);
                }
                // freeze

                request.setAttribute("freezeResult", "0");
                request.setAttribute("lsProject", lsProject);
                request.setAttribute("rsProjectForAdd", rsProjectForAdd);
                request.setAttribute("rsWaitingList", rsWaitingList);
                request.setAttribute("class_id", class_id);
                request.setAttribute("rsAllCo_MentorName", rsAllCo_MentorName);
                request.setAttribute("rsAllMentorName", rsAllMentorName);
                request.setAttribute("rsClassCode", rsClassCode);
                request.setAttribute("rsProject", rsProject);
                request.getRequestDispatcher("./pages/classManager/Project/ProjectList.jsp").forward(request, response);
            }
            if (service.equals("addProject")) {
                String class_id = request.getParameter("class_id");
                String Status = request.getParameter("Status");
                String group_name = request.getParameter("group_name");
                String project_code = request.getParameter("project_code");
                String en_name = request.getParameter("en_name");
                String vi_name = request.getParameter("vi_name");
                String Mentor_id = request.getParameter("Mentor_id");
                String Co_mentor_id = request.getParameter("Co-mentor_id");
                String project_descript = request.getParameter("project_descript");
                //Covert
                int class_id_INT = Integer.parseInt(class_id);
                int Status_INT = Integer.parseInt(Status);
                int Mentor_id_INT = Integer.parseInt(Mentor_id);
                int Co_mentor_id_INT = Integer.parseInt(Co_mentor_id);

                Project pro = new Project();
                pro.setProject_code(project_code);
                pro.setProject_en_name(en_name);
                pro.setProject_vi_name(vi_name);
                pro.setProject_descript(project_descript);
                pro.setStatus(Status_INT);
                pro.setClass_id(class_id_INT);
                pro.setGroup_name(group_name);
                pro.setMentor_id(Status_INT);
                pro.setMentor_id(Mentor_id_INT);
                pro.setCo_mentor_id(Co_mentor_id_INT);

                int result = dao.addProject(pro);
                if (result == 1) {
                    response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id + "&rs=a1");
                } else {
                    response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id + "&rs=a0");
                }

            }
            if (service.equals("updateProject")) {
                String submit = request.getParameter("submit");
                String class_id = request.getParameter("class_id");

                if (submit == null) {
                    String project_id = request.getParameter("project_id");
                    ResultSet rsProject = dao.getProjectByProjectID(project_id);
                    int status = dao.getcurStatusOfProject(project_id);

                    ResultSet rsClassCode = dao.getClassCode(class_id);
                    ResultSet rsAllMentorName = dao.getAllMentorName();
                    ResultSet rsAllCo_MentorName = dao.getAllMentorName();
                    String currentMentorName;
                    String currentCo_MentorName;
                    try {
                        currentMentorName = dao.getMentorNamebyProjectID(project_id);
                        currentCo_MentorName = dao.getCo_MentorNamebyProjectID(project_id);
                        request.setAttribute("status", status);
                        request.setAttribute("class_id", class_id);
                        request.setAttribute("currentMentorName", currentMentorName);
                        request.setAttribute("currentCo_MentorName", currentCo_MentorName);
                        request.setAttribute("rsAllCo_MentorName", rsAllCo_MentorName);
                        request.setAttribute("rsAllMentorName", rsAllMentorName);
                        request.setAttribute("rsClassCode", rsClassCode);
                        request.setAttribute("rsProject", rsProject);
                        request.setAttribute("project_id", project_id);
                        request.setAttribute("mode", "general");
                        request.getRequestDispatcher("./pages/classManager/Project/UpdateProject.jsp").forward(request, response);
                    } catch (SQLException ex) {
                        Logger.getLogger(ManageProjectController.class.getName()).log(Level.SEVERE, null, ex);
                    }

                } else {
                    //get data
                    String project_id = request.getParameter("project_id");
                    String class_id_changed = request.getParameter("class_id");
                    String Status = request.getParameter("Status");
                    String group_name = request.getParameter("group_name"); //length, duplicate
                    String project_code = request.getParameter("project_code"); //length, duplicate
                    String en_name = request.getParameter("en_name");
                    String vi_name = request.getParameter("vi_name");
                    String access_token = request.getParameter("access_token");
                    String url = request.getParameter("url");
                    String Mentor_id = request.getParameter("Mentor_id");
                    String Co_mentor_id = request.getParameter("Co-mentor_id");
                    String project_descript = request.getParameter("project_descript");
                    //validate

                    // convert
                    int project_id_INT = Integer.parseInt(project_id);
                    int class_id_INT = Integer.parseInt(class_id_changed);
                    int Status_INT = Integer.parseInt(Status);
                    int Mentor_id_INT = Integer.parseInt(Mentor_id);
                    int Co_mentor_id_INT = Integer.parseInt(Co_mentor_id);
                    //
                    Project pro = new Project();
                    pro.setProject_id(project_id_INT);
                    pro.setProject_code(project_code);
                    pro.setProject_en_name(en_name);
                    pro.setProject_vi_name(vi_name);
                    pro.setProject_descript(project_descript);
                    pro.setStatus(Status_INT);
                    pro.setClass_id(class_id_INT);
                    pro.setGroup_name(group_name);
                    pro.setMentor_id(Status_INT);
                    pro.setMentor_id(Mentor_id_INT);
                    pro.setCo_mentor_id(Co_mentor_id_INT);
                    pro.setAccess_token(access_token);
                    pro.setUrl(url);
                    //init
                    int result = dao.UpdateProject(pro);
                    if (result == 1) {
                        response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id + "&rs=u1");
                    } else {
                        response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id + "&rs=u0");

                    }

                }
            }
            if (service.equals("deleteProject")) {
                String project_id = request.getParameter("project_id");
                String class_id;
                int curStatus;
                try {
                    class_id = dao.getClassIdByProjectID(project_id);
                    curStatus = dao.getcurStatusOfProject(project_id);
                    if (curStatus == 1) {
                        response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);
                    } else if (curStatus == 0) {
                        dao.deleteProjectByProject_id(project_id);
                        response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);
                    }

                } catch (SQLException ex) {
                    Logger.getLogger(ManageProjectController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (service.equals("setLeader")) {
                String class_id = request.getParameter("class_id");
                String student_id = request.getParameter("student_id");
                String project_id = request.getParameter("project_id");
                dao.setLeader(project_id, student_id, class_id);
                response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);

            }
            if (service.equals("removeMember")) {
                String class_id = request.getParameter("class_id");
                String student_id = request.getParameter("student_id");
                String project_id = request.getParameter("project_id");
                dao.removeMember(project_id, student_id, class_id);
                response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);

            }
            if (service.equals("addMember")) {
                String class_id = request.getParameter("class_id");
                String student_id = request.getParameter("student_id");
                String project_id = request.getParameter("project_id");
                dao.addMemberToProject(student_id, project_id);
                response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);

            }
            if (service.equals("setStatus")) {
                String class_id = request.getParameter("class_id");
                String student_id = request.getParameter("student_id");
                String status = request.getParameter("status");
                dao.setStatus(student_id, status);
                response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);
            }
            if (service.equals("moveMember")) {
                String class_id = request.getParameter("class_id");
                String student_id = request.getParameter("student_id");
                String submit = request.getParameter("submit");
                if (submit == null) {
                    ResultSet rsStudent = dao.getStudentData(student_id);
                    ResultSet rsAllGroup = dao.getProjectByClassID(class_id);
                    request.setAttribute("rsStudent", rsStudent);
                    request.setAttribute("rsAllGroup", rsAllGroup);
                    request.getRequestDispatcher("./pages/classManager/Project/moveMember.jsp").forward(request, response);
                } else {
                    String student_id2 = request.getParameter("student_id2");
                    String project_id = request.getParameter("project_id");
                    int n = dao.moveMemberProject(student_id2, project_id);
                    response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);
                }

            }
            if (service.equals("listMilestones")) {
                String project_id = request.getParameter("project_id");

                ResultSet rsMilstones = dao.getMilestones(project_id);
                String class_id = dao.getClassIdByProjectID(project_id);
                response.sendRedirect("classManager?mode=classMilestone&classId=" + class_id + "&projectId=" + project_id);
            }
            if (service.equals("export")) {
                String class_id = request.getParameter("class_id");
                String class_code = dao.getClassCodeString(class_id);
                List<Project> listProject = dao.getListProject(class_id);
                ExcelHandler excel = new ExcelHandler();
                boolean resultExport = excel.exportClassProjectListToExcel(listProject, class_code);
                response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);
            }
            if (service.equals("getTemplate")) {
                String class_id = request.getParameter("class_id");
                ExcelHandler excel = new ExcelHandler();
                boolean resultExport = excel.exportTemplateProject();
                response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);
            }

            if (service.equals("Freeze")) {
                String class_id = request.getParameter("class_id");
                ResultSet checkNullWaitingList = dao.checkNullWaitingList(class_id);
                if (checkNullWaitingList.next() == false) {
                    int n = dao.activeAllProject(class_id);
                    ResultSet rsProject = dao.getProjectByClassID(class_id);
                    ResultSet rsClassCode = dao.getClassCode(class_id);
                    ResultSet rsAllMentorName = dao.getAllMentorName();
                    ResultSet rsAllCo_MentorName = dao.getAllMentorName();
                    //member//
                    ResultSet rsWaitingList = dao.getWaitingList(class_id);
                    ResultSet rsProjectForAdd = dao.getProjectByClassID(class_id);
                    ResultSet rsProjectForMove = dao.getProjectByClassID(class_id);
                    List<Project> lsProject = new ArrayList<>();
                    while (rsProjectForMove.next()) {
                        Project pro = new Project();
                        pro.setProject_id(Integer.parseInt(rsProjectForMove.getString(1)));
                        pro.setProject_code(rsProjectForMove.getString(2));
                        lsProject.add(pro);
                    }
                    // freeze
                    String freezeResult = "success";
                    request.setAttribute("freezeResult", freezeResult);

                    request.setAttribute("lsProject", lsProject);
                    request.setAttribute("rsProjectForAdd", rsProjectForAdd);
                    request.setAttribute("rsWaitingList", rsWaitingList);
                    request.setAttribute("class_id", class_id);
                    request.setAttribute("rsAllCo_MentorName", rsAllCo_MentorName);
                    request.setAttribute("rsAllMentorName", rsAllMentorName);
                    request.setAttribute("rsClassCode", rsClassCode);
                    request.setAttribute("rsProject", rsProject);
                    request.getRequestDispatcher("./pages/classManager/Project/ProjectList.jsp").forward(request, response);
                } else {
                    ResultSet rsProject = dao.getProjectByClassID(class_id);
                    ResultSet rsClassCode = dao.getClassCode(class_id);
                    ResultSet rsAllMentorName = dao.getAllMentorName();
                    ResultSet rsAllCo_MentorName = dao.getAllMentorName();
                    //member//
                    ResultSet rsWaitingList = dao.getWaitingList(class_id);
                    ResultSet rsProjectForAdd = dao.getProjectByClassID(class_id);
                    ResultSet rsProjectForMove = dao.getProjectByClassID(class_id);
                    List<Project> lsProject = new ArrayList<>();
                    while (rsProjectForMove.next()) {
                        Project pro = new Project();

                        pro.setProject_id(Integer.parseInt(rsProjectForMove.getString(1)));
                        pro.setProject_code(rsProjectForMove.getString(2));
                        lsProject.add(pro);
                    }
                    // freeze
                    String freezeResult = "fail";
                    request.setAttribute("freezeResult", freezeResult);
                    request.setAttribute("lsProject", lsProject);
                    request.setAttribute("rsProjectForAdd", rsProjectForAdd);
                    request.setAttribute("rsWaitingList", rsWaitingList);
                    request.setAttribute("class_id", class_id);
                    request.setAttribute("rsAllCo_MentorName", rsAllCo_MentorName);
                    request.setAttribute("rsAllMentorName", rsAllMentorName);
                    request.setAttribute("rsClassCode", rsClassCode);
                    request.setAttribute("rsProject", rsProject);
                    request.getRequestDispatcher("./pages/classManager/Project/ProjectList.jsp").forward(request, response);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageProjectController.class.getName()).log(Level.SEVERE, null, ex);
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
        String service = request.getParameter("service");
        ProjectDAO dao = new ProjectDAO();
        if (service.equals("import")) {
            try {
                String class_id = request.getParameter("class_id");
                int class_idINT = Integer.parseInt(class_id);
                Part filePart = request.getPart("file");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Assuming the file needs to be saved to a temporary location before processing
                String tempDirectory = request.getServletContext().getRealPath(""); // Adjust this
                File file = new File(tempDirectory + File.separator + fileName);
                try ( InputStream input = filePart.getInputStream()) {
                    Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                ExcelHandler excel = new ExcelHandler();
                // Now you have the file saved, and you can use its path for further processing
                excel.importProjectFromExcel(file.getAbsolutePath(), class_idINT);
                response.sendRedirect("ManageProjectController?service=ProjectList&class_id=" + class_id);
            } catch (SQLException ex) {
                Logger.getLogger(ManageProjectController.class.getName()).log(Level.SEVERE, null, ex);
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
