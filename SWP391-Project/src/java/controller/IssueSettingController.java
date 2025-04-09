    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.IssueSettingDAO;
import dal.ProjectDAO;
import dal.SubjectDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.Console;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AssignClass;
import model.Assignment;
import model.IssueSetting;
import model.Project;
import model.Subject;
import model.User;
import util.ExcelHandler;

/**
 *
 * @author hungd
 */
public class IssueSettingController extends HttpServlet {

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
        HttpSession session = request.getSession();
        SubjectDAO dao = new SubjectDAO();
        ProjectDAO daoPro = new ProjectDAO();
        IssueSettingDAO daoIssue = new IssueSettingDAO();
        String service = request.getParameter("service");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String indexPage = request.getParameter("index");
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);

            if (service == null) {
                service = "display";
            }

//---------------------------------------
//display detail of subject(general, assignment, setting)
            if (service.equals("displayIssueSetting")) {

                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                String mode = request.getParameter("mode");
                List<IssueSetting> listSubjectSetting = daoIssue.getListSubjectSetting(SubID);
                Vector<model.Subject> vector = daoIssue.getSubject("select * from subject where subject_id =" + SubID);
                request.setAttribute("subjectData", vector);

                List<IssueSetting> listType = dao.getAllIssueType(SubID);
                List<IssueSetting> listStatus = dao.getAllIssueStatus(SubID);
                request.setAttribute("listType", listType);
                request.setAttribute("listStatus", listStatus);

                request.setAttribute("mode", mode);
                request.setAttribute("listSubjectSetting", listSubjectSetting);
                request.getRequestDispatcher("./pages/subjectManager/issueSetting.jsp").forward(request, response);
            }
            if (service.equals("displayClassSetting")) {

                int classId = Integer.parseInt(request.getParameter("classId"));
                int subjectId = Integer.parseInt(request.getParameter("subjectID"));
                List<IssueSetting> listSubjectSetting = daoIssue.getListClassSetting(subjectId, classId);
                int countClassIsue = daoIssue.getTotalClassIssueSetting(subjectId, classId);
                Vector<model.Class> vector = daoIssue.getClass("select * from class where class_id =" + classId);
                Vector<model.Subject> vector1 = daoIssue.getSubject("select * from subject where subject_id =" + subjectId);
                request.setAttribute("subjectData", vector1);
                request.setAttribute("classData", vector);

                int id = Integer.parseInt(request.getParameter("classId"));
                AssignClass assignClass = daoIssue.getClassInfor(id);
                String mode = request.getParameter("mode");
                //paging
                String indexClass = request.getParameter("indexClass");
                if (indexClass == null) {
                    indexClass = "1";
                }

                int endAssign = countClassIsue / 10;
                if (countClassIsue % 10 != 0) {
                    endAssign++;
                }//end paging
                List<IssueSetting> listType = daoIssue.getAllClassIssueType(subjectId, classId);
                List<IssueSetting> listStatus = daoIssue.getAllClassIssueStatus(subjectId, classId);
                request.setAttribute("listType", listType);
                request.setAttribute("listStatus", listStatus);
                request.setAttribute("subjectID", subjectId);
                request.setAttribute("mode", mode);
                request.setAttribute("endPage", endAssign);
                request.setAttribute("assignClass", assignClass);
                request.setAttribute("listSubjectSetting", listSubjectSetting);
                request.getRequestDispatcher("./pages/subjectManager/issueSetting.jsp").forward(request, response);
            }
            if (service.equals("displayProjectSetting")) {
                String projectIDs = request.getParameter("projectID");
                String classID = daoPro.getClassIdByProjectID(projectIDs);
                int projectID = Integer.parseInt(request.getParameter("projectID"));
                ResultSet rsProject = daoIssue.getProjectByProjectID(projectID);
                Vector<model.Class> vector = daoIssue.getClass("select * from class where class_id =" + classID);

                String mode = request.getParameter("mode");
                List<IssueSetting> listSubjectSetting = daoIssue.getListProjectSetting(projectID);
                List<IssueSetting> listType = daoIssue.getAllProjectIssueType(projectID);
                List<IssueSetting> listStatus = daoIssue.getAllProjectIssueStatus(projectID);

                request.setAttribute("classData", vector);
                request.setAttribute("listType", listType);
                request.setAttribute("listStatus", listStatus);
                request.setAttribute("rsProject", rsProject);
                request.setAttribute("classID", classID);
                request.setAttribute("projectID", projectIDs);
                request.setAttribute("mode", mode);
                request.setAttribute("listSubjectSetting", listSubjectSetting);
                request.getRequestDispatcher("./pages/subjectManager/issueSetting.jsp").forward(request, response);
            }
            if (service.equals("ListProjectIssue")) {

            }
//---------------------------------------
//SEARCH function
            if (service.equals("searchSubjectSetting")) {
                String titleNstatus = request.getParameter("titleNstatus");

                int subjectId = Integer.parseInt(request.getParameter("subjectID"));
                Vector<model.Subject> vector1 = daoIssue.getSubject("select * from subject where subject_id =" + subjectId);
                String mode = request.getParameter("mode");
                List<IssueSetting> listType = dao.getAllIssueType(subjectId);
                List<IssueSetting> listStatus = dao.getAllIssueStatus(subjectId);
                
                // set data for view
                if (titleNstatus.equals("")) {
                    List<IssueSetting> listSetting = daoIssue.getListSubjectSetting(subjectId);
                    request.setAttribute("listSubjectSetting", listSetting);
                    response.sendRedirect("IssueSettingController?service=displayIssueSetting&subjectID=" + subjectId + "&mode=subject");
                } else {

                    List<IssueSetting> listSetting = daoIssue.listSettingSearch("SELECT * FROM issue_setting WHERE (title like '%" + titleNstatus + "%' or status like '%" + titleNstatus + "%') and subject_id like '" + subjectId + "'");
                    request.setAttribute("listSubjectSetting", listSetting);
                    request.setAttribute("listType", listType);
                    request.setAttribute("listStatus", listStatus);
                    request.setAttribute("subjectData", vector1);
                    request.setAttribute("mode", mode);
                    dispth(request, response, "./pages/subjectManager/issueSetting.jsp");
                }
                return;
            }
            if (service.equals("searchClassSetting")) {
                String titleNstatus = request.getParameter("titleNstatus");

                int classId = Integer.parseInt(request.getParameter("classId"));
                AssignClass assignClass = daoIssue.getClassInfor(classId);
                int subjectId = Integer.parseInt(request.getParameter("subjectID"));
                Vector<model.Class> vector = daoIssue.getClass("select * from class where class_id =" + classId);
                Vector<model.Subject> vector1 = daoIssue.getSubject("select * from subject where subject_id =" + subjectId);
                String mode = request.getParameter("mode");
                request.setAttribute("subjectData", vector1);
                request.setAttribute("classData", vector);
                request.setAttribute("mode", mode);
                request.setAttribute("assignClass", assignClass);
                // set data for view
                if (titleNstatus.equals("")) {
                    List<IssueSetting> listSetting = daoIssue.getListClassSetting(subjectId, classId);
                    request.setAttribute("listSubjectSetting", listSetting);
                    request.setAttribute("assignClass", assignClass);

                    response.sendRedirect("IssueSettingController?service=displayClassSetting&classId=" + classId + "&subjectID=" + subjectId + "&mode=class");
                } else {

                    List<IssueSetting> listSetting = daoIssue.listSettingSearch("SELECT * FROM issue_setting WHERE (title like '%" + titleNstatus + "%' or status like '%" + titleNstatus + "%') and subject_id like '" + subjectId + "' and class_id like '" + classId + "'");
                    request.setAttribute("listSubjectSetting", listSetting);
                    request.setAttribute("assignClass", assignClass);

                    dispth(request, response, "./pages/subjectManager/issueSetting.jsp");
                }
                return;
            }
            if (service.equals("searchProjectSetting")) {
                String titleNstatus = request.getParameter("titleNstatus");

                int projectID = Integer.parseInt(request.getParameter("projectID"));
                ResultSet rsProject = daoIssue.getProjectByProjectID(projectID);
                String mode = request.getParameter("mode");
                request.setAttribute("mode", mode);

                // set data for view
                if (titleNstatus.equals("")) {
                    List<IssueSetting> listSetting = daoIssue.getListProjectSetting(projectID);
                    request.setAttribute("listSubjectSetting", listSetting);
                    response.sendRedirect("IssueSettingController?service=displayProjectSetting&projectID=" + projectID + "&mode=project");
                } else {
                    request.setAttribute("rsProject", rsProject);
                    List<IssueSetting> listSetting = daoIssue.ProjectSettingSearch("SELECT * FROM issue_setting WHERE (title like '%" + titleNstatus + "%' or status like '%" + titleNstatus + "%') and project_id like '" + projectID + "'");
                    request.setAttribute("listSubjectSetting", listSetting);
                    dispth(request, response, "./pages/subjectManager/issueSetting.jsp");
                }
                return;
            }

//---------------------------------------
//ADD (INSERT) function
            if (service.equals("addSubjectSetting")) {

                String issueType = request.getParameter("issueType");
                String issueStatus = request.getParameter("issueStatus");
                String description = request.getParameter("description");

                IssueSetting iss = new IssueSetting();
                int subjectId = Integer.parseInt(request.getParameter("subject_id"));
                iss.setSubject_id(subjectId);
                iss.setTitle(issueType);
                iss.setStatus(issueStatus);
                iss.setDescription(description);
                int n = daoIssue.addSubjectSetting(iss);
                if (n == 1) {
                    response.sendRedirect("IssueSettingController?service=displayIssueSetting&subjectID=" + subjectId + "&success=true1&mode=subject");
                } else {
                    response.sendRedirect("IssueSettingController?service=displayIssueSetting&subjectID=" + subjectId + "&success=false1&mode=subject");
                }
            }
            if (service.equals("addClassSetting")) {
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                int classId = Integer.parseInt(request.getParameter("classId"));
                String issueType = request.getParameter("issueType");
                String issueStatus = request.getParameter("issueStatus");
                String description = request.getParameter("description");

                IssueSetting iss = new IssueSetting();
                iss.setSubject_id(subjectId);
                iss.setClass_id(classId);
                iss.setTitle(issueType);
                iss.setStatus(issueStatus);
                iss.setDescription(description);
                int n = daoIssue.addClassSetting(iss);
                if (n == 1) {
                    response.sendRedirect("IssueSettingController?service=displayClassSetting&classId=" + classId + "&subjectID=" + subjectId + "&success=true1&mode=class");
                } else {
                    response.sendRedirect("IssueSettingController?service=displayClassSetting&classId=" + classId + "&subjectID=" + subjectId + "&success=false1&mode=class");
                }
            }
            if (service.equals("addProjectSetting")) {
                int projectID = Integer.parseInt(request.getParameter("projectID"));
                String issueType = request.getParameter("issueType");
                String issueStatus = request.getParameter("issueStatus");
                String description = request.getParameter("description");

                IssueSetting iss = new IssueSetting();
                iss.setProject_id(projectID);
                iss.setTitle(issueType);
                iss.setStatus(issueStatus);
                iss.setDescription(description);
                int n = daoIssue.addProjectSetting(iss);
                if (n == 1) {
                    response.sendRedirect("IssueSettingController?service=displayProjectSetting&projectID=" + projectID + "&success=true1&mode=project");
                } else {
                    response.sendRedirect("IssueSettingController?service=displayProjectSetting&projectID=" + projectID + "&success=false1&mode=project");
                }
            }
//---------------------------------------
//UPDATE function
            if (service.equals("subjectSettingUpdate")) {
                String submit = request.getParameter("submit");
                String mode = request.getParameter("mode");
                request.setAttribute("mode", mode);
                if (submit == null) {
                    int settingId = Integer.parseInt(request.getParameter("setting_id"));
                    String subjectId = request.getParameter("subjectID");
                    IssueSetting subjectSetting = dao.getSubjectSetting(settingId);
                    request.setAttribute("subjectID", subjectId);
                    request.setAttribute("subjectSetting", subjectSetting);
                    request.getRequestDispatcher("./pages/subjectManager/subjectSettingDetails.jsp").forward(request, response);
                } else {
                    //get data
                    int settingId = Integer.parseInt(request.getParameter("setting_id"));
                    int subjectId = Integer.parseInt(request.getParameter("subject_id"));

                    String type = request.getParameter("type");
                    String status = request.getParameter("status");
                    String description = request.getParameter("Description");

                    //convert
                    IssueSetting iss = new IssueSetting();
                    iss.setSetting_id(settingId);
                    iss.setSubject_id(subjectId);
                    iss.setTitle(type);
                    iss.setStatus(status);
                    iss.setDescription(description);

                    int n = daoIssue.updateSubjectSetting(iss);
                    if (n == 1) {
                        response.sendRedirect("IssueSettingController?service=displayIssueSetting&subjectID=" + subjectId + "&mode=subject&success=true");
                    } else {
                        response.sendRedirect("IssueSettingController?service=displayIssueSetting&subjectID=" + subjectId + "&mode=subject&success=false");
                    }
                }
            }
            if (service.equals("classSettingUpdate")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    int settingId = Integer.parseInt(request.getParameter("setting_id"));
                    int subjectId = Integer.parseInt(request.getParameter("subjectID"));
                    int classId = Integer.parseInt(request.getParameter("classId"));

                    IssueSetting classSetting = daoIssue.getClassSetting(settingId, classId);
                    String mode = request.getParameter("mode");
                    request.setAttribute("mode", mode);
                    request.setAttribute("subjectID", subjectId);
                    request.setAttribute("classID", classId);
                    request.setAttribute("classSetting", classSetting);
                    request.getRequestDispatcher("./pages/subjectManager/subjectSettingDetails.jsp").forward(request, response);
                } else {
                    //get data
                    int settingId = Integer.parseInt(request.getParameter("setting_id"));
                    int subjectId = Integer.parseInt(request.getParameter("subjectID"));
                    int classId = Integer.parseInt(request.getParameter("classID"));
                    String type = request.getParameter("type");
                    String status = request.getParameter("status");
                    String description = request.getParameter("Description");

                    IssueSetting iss = new IssueSetting();
                    iss.setSetting_id(settingId);
                    iss.setSubject_id(subjectId);
                    iss.setClass_id(classId);
                    iss.setTitle(type);
                    iss.setStatus(status);
                    iss.setDescription(description);

                    int n = daoIssue.updateSubjectSetting(iss);
                    if (n == 1) {
                        response.sendRedirect("IssueSettingController?service=displayClassSetting&subjectID=" + subjectId + "&classId=" + classId + "&success=true&mode=class");
                    } else {
                        response.sendRedirect("IssueSettingController?service=displayClassSetting&subjectID=" + subjectId + "&classId=" + classId + "&success=false&mode=class");
                    }
                }
            }
            if (service.equals("projectSettingUpdate")) {
                String submit = request.getParameter("submit");
                String mode = request.getParameter("mode");
                request.setAttribute("mode", mode);
                if (submit == null) {
                    int settingId = Integer.parseInt(request.getParameter("setting_id"));
                    int projectID = Integer.parseInt(request.getParameter("projectID"));
                    IssueSetting projectSetting = daoIssue.getProjectSetting(settingId, projectID);
                    request.setAttribute("projectID", projectID);
                    request.setAttribute("projectSetting", projectSetting);
                    request.getRequestDispatcher("./pages/subjectManager/subjectSettingDetails.jsp").forward(request, response);
                } else {
                    //get data
                    int settingId = Integer.parseInt(request.getParameter("setting_id"));
                    int projectID = Integer.parseInt(request.getParameter("projectID"));
                    String type = request.getParameter("type");
                    String status = request.getParameter("status");
                    String description = request.getParameter("Description");

                    //convert
                    IssueSetting iss = new IssueSetting();
                    iss.setSetting_id(settingId);
                    iss.setProject_id(projectID);
                    iss.setTitle(type);
                    iss.setStatus(status);
                    iss.setDescription(description);

                    int n = daoIssue.updateSubjectSetting(iss);
                    if (n == 1) {
                        response.sendRedirect("IssueSettingController?service=displayProjectSetting&projectID=" + projectID + "&mode=project&success=true");
                    } else {
                        response.sendRedirect("IssueSettingController?service=displayProjectSetting&projectID=" + projectID + "&mode=project&success=false");
                    }
                }
            }
//---------------------------------------               
// ACTION
            if (service.equals("changeStatus")) {
                int settingId = Integer.parseInt(request.getParameter("settingId"));
                int subjectId = Integer.parseInt(request.getParameter("subjectID"));
                String isActive = request.getParameter("isActive");
                if (isActive.equals("1")) {
                    int n = daoIssue.StatusChange(settingId, 0);
                    response.sendRedirect("IssueSettingController?service=displayIssueSetting&subjectID=" + subjectId + "&mode=subject");

                } else {
                    int n = daoIssue.StatusChange(settingId, 1);
                    response.sendRedirect("IssueSettingController?service=displayIssueSetting&subjectID=" + subjectId + "&mode=subject");
                }
            }
            if (service.equals("changeClassSettingStatus")) {
                int settingId = Integer.parseInt(request.getParameter("settingId"));
                int subjectId = Integer.parseInt(request.getParameter("subjectID"));
                int classId = Integer.parseInt(request.getParameter("classID"));
                String isActive = request.getParameter("isActive");
                if (isActive.equals("1")) {
                    int n = daoIssue.StatusChange(settingId, 0);
                    response.sendRedirect("IssueSettingController?service=displayClassSetting&subjectID=" + subjectId + "&classId=" + classId + "&mode=class");

                } else {
                    int n = daoIssue.StatusChange(settingId, 1);
                    response.sendRedirect("IssueSettingController?service=displayClassSetting&subjectID=" + subjectId + "&classId=" + classId + "&mode=class");

                }
            }
            if (service.equals("changeProjectSettingStatus")) {
                int settingId = Integer.parseInt(request.getParameter("settingId"));
                int projectID = Integer.parseInt(request.getParameter("projectID"));
                String isActive = request.getParameter("isActive");
                if (isActive.equals("1")) {
                    int n = daoIssue.StatusChange(settingId, 0);
                    response.sendRedirect("IssueSettingController?service=displayProjectSetting&projectID=" + projectID + "&mode=project");

                } else {
                    int n = daoIssue.StatusChange(settingId, 1);
                    response.sendRedirect("IssueSettingController?service=displayProjectSetting&projectID=" + projectID + "&mode=project");

                }
            }

//---------------------------------------               
// Filter            
            if (service.equals("filterIssueSubject")) {
                String issueStatus = request.getParameter("issueStatus");
                String issueType = request.getParameter("issueType");
                int subjectID = Integer.parseInt(request.getParameter("subjectID"));
                Vector<model.Subject> vector = daoIssue.getSubject("select * from subject where subject_id = " + subjectID);
                String mode = request.getParameter("mode");
                List<IssueSetting> listSubjectSetting = new ArrayList<>(); // Create a common list

                if ("display".equals(issueType) || "display".equals(issueStatus)) {
                    List<IssueSetting> listType = dao.getAllIssueType(subjectID);
                    List<IssueSetting> listStatus = dao.getAllIssueStatus(subjectID);
                    listSubjectSetting.addAll(daoIssue.searchNFilterSubject("select setting_id, subject_id, title, status, create_at, is_active from issue_setting where subject_id = " + subjectID));
                    request.setAttribute("listType", listType);
                    request.setAttribute("listStatus", listStatus);
                    
                } else {
                    if (!"display".equals(issueType)) {
                        List<IssueSetting> listType = dao.getAllIssueType(subjectID);
                        listSubjectSetting.addAll(daoIssue.searchNFilterSubject("select setting_id, subject_id, title, status, create_at, is_active from issue_setting where subject_id = " + subjectID + " and title = '" + issueType + "'"));
                        request.setAttribute("listType", listType);
                    }
                    if (!"display".equals(issueStatus)) {
                        List<IssueSetting> listStatus = dao.getAllIssueStatus(subjectID);
                        listSubjectSetting.addAll(daoIssue.searchNFilterSubject("select setting_id, subject_id, title, status, create_at, is_active from issue_setting where subject_id = " + subjectID + " and status = '" + issueStatus + "'"));
                        request.setAttribute("listStatus", listStatus);
                    }
                }
                request.setAttribute("listSubjectSetting", listSubjectSetting);
                List<IssueSetting> listType = dao.getAllIssueType(subjectID);
                request.setAttribute("listType", listType);
                request.setAttribute("subjectID", subjectID);
                request.setAttribute("subjectData", vector);
                request.setAttribute("mode", mode);
                request.getRequestDispatcher("pages/subjectManager/issueSetting.jsp").forward(request, response);
            }
            if (service.equals("filterIssueClass")) {
                String issueStatus = request.getParameter("issueStatus");
                String issueType = request.getParameter("issueType");
                int subjectID = Integer.parseInt(request.getParameter("subjectID"));
                int classID = Integer.parseInt(request.getParameter("classID"));
                Vector<model.Class> vector = daoIssue.getClass("select * from class where class_id =" + classID);
                Vector<model.Subject> vector1 = daoIssue.getSubject("select * from subject where subject_id = " + subjectID);
                String mode = request.getParameter("mode");
                AssignClass assignClass = daoIssue.getClassInfor(classID);
                List<IssueSetting> listSubjectSetting = new ArrayList<>(); // Create a common list

                if ("display".equals(issueType) || "display".equals(issueStatus)) {
                    List<IssueSetting> listType = daoIssue.getAllClassIssueType(subjectID, classID);
                    List<IssueSetting> listStatus = daoIssue.getAllClassIssueStatus(subjectID, classID);
                    request.setAttribute("assignClass", assignClass);
                    listSubjectSetting.addAll(daoIssue.searchNFilterClass("select setting_id, subject_id, class_id, title, status, create_at, is_active from issue_setting where subject_id = " + subjectID + " and class_id = " + classID + ""));
                    request.setAttribute("listType", listType);
                    request.setAttribute("listStatus", listStatus);
                } else {
                    if (!"display".equals(issueType)) {
                        List<IssueSetting> listType = daoIssue.getAllClassIssueType(subjectID, classID);
                        listSubjectSetting.addAll(daoIssue.searchNFilterClass("select setting_id, subject_id, class_id, title, status, create_at, is_active from issue_setting where subject_id = " + subjectID + " and class_id=" + classID + " and title = '" + issueType + "'"));
                        request.setAttribute("listType", listType);
                        request.setAttribute("assignClass", assignClass);

                    }
                    if (!"display".equals(issueStatus)) {
                        List<IssueSetting> listStatus = daoIssue.getAllClassIssueStatus(subjectID, classID);
                        listSubjectSetting.addAll(daoIssue.searchNFilterClass("select setting_id, subject_id, class_id, title, status, create_at, is_active from issue_setting where subject_id = " + subjectID + " and class_id=" + classID + " and status = '" + issueStatus + "'"));
                        request.setAttribute("listStatus", listStatus);
                        request.setAttribute("assignClass", assignClass);

                    }
                }

                request.setAttribute("listSubjectSetting", listSubjectSetting);
                List<IssueSetting> listType = daoIssue.getAllClassIssueType(subjectID, classID);
                List<IssueSetting> listStatus = daoIssue.getAllClassIssueStatus(subjectID, classID);
                request.setAttribute("listStatus", listStatus);
                request.setAttribute("listType", listType);
                request.setAttribute("subjectID", subjectID);
                request.setAttribute("classData", vector);
                request.setAttribute("subjectData", vector1);
                request.setAttribute("mode", mode);
                request.setAttribute("assignClass", assignClass);
                request.getRequestDispatcher("pages/subjectManager/issueSetting.jsp").forward(request, response);
            }

            if (service.equals("filterIssueProject")) {
                String issueStatus = request.getParameter("issueStatus");
                String issueType = request.getParameter("issueType");
                int projectID = Integer.parseInt(request.getParameter("projectID"));
                ResultSet rsProject = daoIssue.getProjectByProjectID(projectID);

                String mode = request.getParameter("mode");
                List<IssueSetting> listSubjectSetting = new ArrayList<>(); // Create a common list

                if ("display".equals(issueType) || "display".equals(issueStatus)) {
                    List<IssueSetting> listType = daoIssue.getAllProjectIssueType(projectID);
                    List<IssueSetting> listStatus = daoIssue.getAllProjectIssueStatus(projectID);
                    listSubjectSetting.addAll(daoIssue.searchNFilterProject("select setting_id, project_id, title, status, create_at, is_active from issue_setting where project_id = " + projectID + ""));
                    request.setAttribute("rsProject", rsProject);
                    request.setAttribute("listType", listType);
                    request.setAttribute("listStatus", listStatus);
                } else {
                    if (!"display".equals(issueType)) {
                        List<IssueSetting> listType = daoIssue.getAllProjectIssueType(projectID);
                        listSubjectSetting.addAll(daoIssue.searchNFilterProject("select setting_id, project_id, title, status, create_at, is_active from issue_setting where project_id = " + projectID + " and title = '" + issueType + "'"));
                        request.setAttribute("rsProject", rsProject);
                        request.setAttribute("listType", listType);
                    }
                    if (!"display".equals(issueStatus)) {
                        List<IssueSetting> listStatus = daoIssue.getAllProjectIssueStatus(projectID);
                        listSubjectSetting.addAll(daoIssue.searchNFilterProject("select setting_id, project_id, title, status, create_at, is_active from issue_setting where project_id = " + projectID + " and status = '" + issueStatus + "'"));
                        request.setAttribute("rsProject", rsProject);
                        request.setAttribute("listStatus", listStatus);
                    }
                }

                request.setAttribute("listSubjectSetting", listSubjectSetting);
                List<IssueSetting> listType = daoIssue.getAllProjectIssueType(projectID);
                request.setAttribute("listType", listType);
                request.setAttribute("mode", mode);
                request.setAttribute("rsProject", rsProject);
                request.getRequestDispatcher("pages/subjectManager/issueSetting.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(IssueSettingController.class.getName()).log(Level.SEVERE, null, ex);
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
