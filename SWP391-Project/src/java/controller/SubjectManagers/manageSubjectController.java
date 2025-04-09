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
import java.io.Console;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;
import model.Assignment;
import model.IssueSetting;
import model.Subject;
import model.User;

/**
 *
 * @author hungd
 */
public class manageSubjectController extends HttpServlet {

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
        String service = request.getParameter("service");

        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            User user = (User) session.getAttribute("user");
            int userID = user.getUserId();
            int role = user.getRoleId();
            String indexPage = request.getParameter("index");
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);

            if (service == null) {
                service = "display";
            }

            int count = dao.getTotalSubject(role, userID);
            int endPage = count / 10;
            if (count % 10 != 0) {
                endPage++;
            }
//---------------------------------------
//Display List subject manage
            if (service.equals("display")) {
                List<Subject> list = dao.pagingSubject(index, role, userID);
                request.setAttribute("data", list);
                List<User> listName = dao.getName();
                List<User> list3 = dao.getManager();
                request.setAttribute("data3", list3);
                request.setAttribute("manageN", listName);
                request.setAttribute("endPSubManager", endPage);
                RequestDispatcher dis = request.getRequestDispatcher("pages/admin/Subject/subjectList.jsp");
                dis.forward(request, response);

            }
//---------------------------------------
//display detail of subject(general, assignment, setting)
            if (service.equals("displayDetails")) {

                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                List<Subject> listDetails = dao.getSubjectDetails(SubID);
                List<Assignment> pagingAssignment = dao.pagingAssignment(SubID, index);
                List<IssueSetting> listSubjectSetting = dao.getListSubjectSetting(SubID);
                Subject listSubject = dao.getSubjectDetailsUpdate(subject_code);
                request.setAttribute("listSubject", listSubject);
                request.setAttribute("subjectID", subject_code);
                request.setAttribute("listDetails", listDetails);
                request.setAttribute("listAssignment", pagingAssignment);
                request.setAttribute("listSubjectSetting", listSubjectSetting);
                request.getRequestDispatcher("./pages/subjectManager/subjectDetails.jsp").forward(request, response);
            }
            if (service.equals("displayAssignment")) {

                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                List<Subject> listDetails = dao.getSubjectDetails(SubID);
                List<Assignment> pagingAssignment = dao.pagingAssignment(SubID, index);
                Assignment pagingAssignment2 = dao.pagingAssignment2(SubID, index);
                //paging

                int countAssign = dao.getTotalAssignment(SubID);
                int endAssign = countAssign / 10;
                if (countAssign % 10 != 0) {
                    endAssign++;
                }//end paging

                request.setAttribute("endAssign", endAssign);
                request.setAttribute("subjectID", subject_code);
                request.setAttribute("listDetails", listDetails);
                request.setAttribute("listAssignment", pagingAssignment);
                request.setAttribute("pagingAssignment2", pagingAssignment2);
                request.getRequestDispatcher("./pages/subjectManager/assignmentList.jsp").forward(request, response);
            }
            if (service.equals("displaySubjectSetting")) {

                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                List<Subject> listDetails = dao.getSubjectDetails(SubID);
                List<IssueSetting> pagingSubject = dao.pagingSubjectSetting(SubID, index);
                IssueSetting pagingSubject2 = dao.pagingSubjectSetting2(SubID, index);
                //paging
                int countSubSetting = dao.getTotalSubjectSetting(SubID);
                int endSubSetting = count / 10;
                if (countSubSetting % 10 != 0) {
                    endSubSetting++;
                }//end paging
                List<IssueSetting> listType = dao.getAllIssueType(SubID);
                List<IssueSetting> listStatus = dao.getAllIssueStatus(SubID);
                request.setAttribute("listType", listType);
                request.setAttribute("endSubSetting", endSubSetting);
                request.setAttribute("listStatus", listStatus);
                request.setAttribute("subjectID", subject_code);
                request.setAttribute("listDetails", listDetails);
                request.setAttribute("listSubjectSetting", pagingSubject);
                request.setAttribute("pagingSubject2", pagingSubject2);
                request.getRequestDispatcher("./pages/subjectManager/subjectSettingList.jsp").forward(request, response);
            }
            if (service.equals("displayIssueSetting")) {

                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                List<Subject> listDetails = dao.getSubjectDetails(SubID);
                List<IssueSetting> listSubjectSetting = dao.getListSubjectSetting(SubID);
                //paging
                int countAssign = dao.getTotalAssignment(SubID);
                int endAssign = count / 10;
                if (countAssign % 10 != 0) {
                    endAssign++;
                }//end paging
                List<IssueSetting> listType = dao.getAllIssueType(SubID);
                List<IssueSetting> listStatus = dao.getAllIssueStatus(SubID);
                request.setAttribute("listType", listType);
                request.setAttribute("listStatus", listStatus);
                request.setAttribute("subjectID", subject_code);
                request.setAttribute("listDetails", listDetails);
                request.setAttribute("listSubjectSetting", listSubjectSetting);
                request.getRequestDispatcher("./pages/subjectManager/issueSetting.jsp").forward(request, response);
            }

//---------------------------------------
//DELETE function
            if (service.equals("deleteAssignmentByID")) {
                String subject_code = request.getParameter("subjectID");
                Assignment ass = new Assignment();
                int subject_id_INT = Integer.parseInt(subject_code);
                ass.setSubjectID(subject_id_INT);
                int id = Integer.parseInt(request.getParameter("assign_id"));
                int n = dao.deleteAssignmentByID(id);
                response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subject_id_INT);
            }
            if (service.equals("deleteSettingById")) {
                String subject = request.getParameter("subjectID");
                IssueSetting iss = new IssueSetting();
                int subject_id = Integer.parseInt(subject);
                iss.setSubject_id(subject_id);
                int id = Integer.parseInt(request.getParameter("setting_id"));
                int n = dao.deleteSettingById(id);
                response.sendRedirect("manageSubjectController?service=displaySubjectSetting&subjectID=" + subject_id);
            }
//---------------------------------------
//SEARCH function
            if (service.equals("SearchSubject_Code")) {
                String name = request.getParameter("search_code");

                // set data for view
                if (name.equals("")&&role ==14) {
                    Vector<Subject> vector = dao.getSubject("select * from subject");
                    request.setAttribute("data", vector);
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    dispth(request, response, "pages/admin/Subject/subjectList.jsp");
                } else if(name.equals("")&&role ==15){
                     Vector<Subject> vector = dao.getSubject("select * from subject where manager_id ="+userID);
                    request.setAttribute("data", vector);
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    dispth(request, response, "pages/admin/Subject/subjectList.jsp");   
                } else if(role == 14) {
                    Vector<Subject> vector = dao.getSubject("SELECT * FROM subject s INNER JOIN user u ON user_id= manager_id WHERE s.subject_code like'%" + name + "%' or s.subject_name like '%" + name + "%' or s.update_at like '%" + name + "%'");
                    System.out.println(vector.size());
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    request.setAttribute("data", vector);
                    dispth(request, response, "pages/admin/Subject/subjectList.jsp");
                } else if(role ==15 ){
                       Vector<Subject> vector = dao.getSubject("SELECT * FROM subject WHERE manager_id = "+userID+" and (subject_code like '%" + name + "%' or subject_name like '%" + name + "%')");
                    System.out.println(vector.size());
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    request.setAttribute("data", vector);
                    dispth(request, response, "pages/admin/Subject/subjectList.jsp");
                }
                return;
            }
            if (service.equals("searchAssignmentName")) {
                String AssignmentName = request.getParameter("AssignmentName");
                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                // set data for view
                if (AssignmentName.equals("")) {
                    List<Subject> listDetails = dao.getSubjectDetails(SubID);
                    List<Assignment> listAssignment = dao.getSubjectAssignment(SubID);
                    request.setAttribute("listAssignment", listAssignment);
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("listDetails", listDetails);
                    response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + SubID);
                } else {
                    List<Subject> listDetails = dao.getSubjectDetails(SubID);
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("listDetails", listDetails);
                    List<Assignment> listAssignment = dao.getListSubjectAssignment("SELECT * FROM assignment WHERE assign_name like'%" + AssignmentName + "%' and subject_id like '" + SubID + "'");
                    request.setAttribute("listAssignment", listAssignment);
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("listDetails", listDetails);
                    dispth(request, response, "./pages/subjectManager/assignmentList.jsp");
                }
                return;
            }
            if (service.equals("searchSubjectSetting")) {
                String settingName = request.getParameter("settingName");
                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                // set data for view
                if (settingName.equals("")) {
                    List<Subject> listDetails = dao.getSubjectDetails(SubID);
                    List<IssueSetting> listSubjectSetting = dao.getListSubjectSetting(SubID);
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("listDetails", listDetails);
                    request.setAttribute("listSubjectSetting", listSubjectSetting);
                    response.sendRedirect("manageSubjectController?service=displaySubjectSetting&subjectID=" + SubID);
                } else {
                    List<Subject> listDetails = dao.getSubjectDetails(SubID);
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("listDetails", listDetails);
                    List<IssueSetting> listSubjectSetting = dao.listSubjectSettingSearch("SELECT * FROM issue_setting WHERE (title like '%" + settingName + "%' or status like '%" + settingName + "%') and subject_id like '" + SubID + "'");
                    request.setAttribute("listAssignment", listSubjectSetting);
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("listDetails", listDetails);
                    request.setAttribute("listSubjectSetting", listSubjectSetting);
                    dispth(request, response, "./pages/subjectManager/subjectSettingList.jsp");
                }
                return;
            }

//---------------------------------------
//ADD (INSERT) function
            if (service.equals("addAssignment")) {
                String subject_code = request.getParameter("subjectID");
                String AssignmentName = request.getParameter("AssignmentName");
                String Part = request.getParameter("Part");
                String Weight = request.getParameter("Weight");
                String DueDate = request.getParameter("DueDate");
                String Description = request.getParameter("Description");

                Assignment ass = new Assignment();
                int subject_id_INT = Integer.parseInt(subject_code);
                ass.setSubjectID(subject_id_INT);
                ass.setAssign_name(AssignmentName);
                ass.setAssign_descript(Description);
                ass.setPart(Part);
                ass.setWeight(Weight);
                ass.setDue_date(DueDate);
                int n = dao.addAssignment(ass);
                if (n == 1) {
                    response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subject_id_INT + "&success=true1");
                } else {
                    response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subject_id_INT + "&success=false1");
                }
            }
            if (service.equals("addSubjectSetting")) {
                String subject_id = request.getParameter("subject_id");
                String issueType = request.getParameter("issueType");
                String issueStatus = request.getParameter("issueStatus");
                String description = request.getParameter("description");

                IssueSetting iss = new IssueSetting();
                int subject_id_INT = Integer.parseInt(subject_id);
                iss.setSubject_id(subject_id_INT);
                iss.setTitle(issueType);
                iss.setStatus(issueStatus);
                iss.setDescription(description);
                int n = dao.addSubjectSetting(iss);
                if (n == 1) {
                    response.sendRedirect("manageSubjectController?service=displaySubjectSetting&subjectID=" + subject_id_INT + "&success=true1");
                } else {
                    response.sendRedirect("manageSubjectController?service=displaySubjectSetting&subjectID=" + subject_id_INT + "&success=false1");
                }
            }
//---------------------------------------
//UPDATE function
            if (service.equals("assignmentUpdate")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    String assignment = request.getParameter("assign_id");
                    int assignmentID = Integer.parseInt(assignment);
                    String subject_code = request.getParameter("subjectID");
                    List<Assignment> listAssignment = dao.getAssignmentDetails(assignmentID);
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("listAssignment", listAssignment);
                    request.getRequestDispatcher("./pages/subjectManager/assignmentDetails.jsp").forward(request, response);
                } else {
                    //get data
                    String assignment = request.getParameter("ass_id");
                    String subject_id = request.getParameter("subject_id");
                    String AssignmentName = request.getParameter("ass_name");
                    String Part = request.getParameter("part");
                    String Weight = request.getParameter("weight");
                    String DueDate = request.getParameter("dueDate");
                    String isActive = request.getParameter("status");
                    String Description = request.getParameter("Description");
                    //convert
                    int subject_id_INT = Integer.parseInt(subject_id);
                    int assignmentID = Integer.parseInt(assignment);
                    int status = Integer.parseInt(isActive);
                    Assignment ass = new Assignment();
                    ass.setAssign_id(assignmentID);
                    ass.setAssign_name(AssignmentName);
                    ass.setAssign_descript(Description);
                    ass.setPart(Part);
                    ass.setWeight(Weight);
                    ass.setIs_active(status);
                    ass.setDue_date(DueDate);
                    int n = dao.updateAssignment(ass);
                    if (n == 1) {
                        response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subject_id + "&success=true");
                    } else {
                        response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subject_id + "&success=false");
                    }
                }
            }
            if (service.equals("subjectDetailUpdate")) {
                String submit = request.getParameter("submit");

                if (submit == null) {
                    String subjectID = request.getParameter("subjectID");
                    int subjectIdInt = Integer.parseInt(subjectID);
                    Subject listSubject = dao.getSubjectDetailsUpdate(subjectID);

                    request.setAttribute("listSubject", listSubject);
                    request.setAttribute("subjectID", subjectIdInt);

                    request.getRequestDispatcher("./pages/subjectManager/subjectDetails.jsp").forward(request, response);
                } else {
                    //get data
                    String subjectID = request.getParameter("subjectID");
                    String subjectName = request.getParameter("subjectName");
                    String subjectCode = request.getParameter("subjectCode");
                    String timeAllocation = request.getParameter("timeAllocation");
                    String minGrade = request.getParameter("minGrade");
                    String isActive = request.getParameter("status");
                    String description = request.getParameter("description");
                    //convert
                    int subjectIdInt = Integer.parseInt(subjectID);
                    int gradeMin = Integer.parseInt(minGrade);
                    int status = Integer.parseInt(isActive);

                    Subject sub = new Subject();
                    sub.setSubjectId(subjectIdInt);
                    sub.setSubjectName(subjectName);
                    sub.setSubjectCode(subjectCode);
                    sub.setTimeAllocation(timeAllocation);
                    sub.setPassGrade(gradeMin);
                    sub.setIsActive(status);
                    sub.setDescription(description);
                    int n = dao.updateSubjectIter2(sub);
                    if (n == 1) {
                        response.sendRedirect("manageSubjectController?service=displayDetails&subjectID=" + subjectIdInt + "&success=true");
                    } else {
                        response.sendRedirect("manageSubjectController?service=displayDetails&subjectID=" + subjectIdInt + "&success=false");
                    }
                }
            }
            if (service.equals("subjectSettingUpdate")) {
                String submit = request.getParameter("submit");
                if (submit == null) {
                    String setting = request.getParameter("setting_id");
                    int setting_id = Integer.parseInt(setting);
                    String subject_code = request.getParameter("subjectID");
                    IssueSetting subjectSetting = dao.getSubjectSetting(setting_id);
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("subjectSetting", subjectSetting);
                    request.getRequestDispatcher("./pages/subjectManager/subjectSettingDetails.jsp").forward(request, response);
                } else {
                    //get data
                    String setting = request.getParameter("setting_id");
                    String subject = request.getParameter("subject_id");
                    String type = request.getParameter("type");
                    String status = request.getParameter("status");
                    String description = request.getParameter("Description");
                    //convert
                    int setting_id = Integer.parseInt(setting);
                    int subject_id = Integer.parseInt(subject);

                    IssueSetting iss = new IssueSetting();
                    iss.setSetting_id(setting_id);
                    iss.setSubject_id(subject_id);
                    iss.setTitle(type);
                    iss.setStatus(status);
                    iss.setDescription(description);

                    int n = dao.updateSubjectSetting(iss);
                    if (n == 1) {
                        response.sendRedirect("manageSubjectController?service=displaySubjectSetting&subjectID=" + subject + "&success=true");
                    } else {
                        response.sendRedirect("manageSubjectController?service=displaySubjectSetting&subjectID=" + subject + "&success=false");
                    }
                }
            }
//---------------------------------------               
// ACTION
            if (service.equals("changeStatus")) {
                String subjectID = request.getParameter("subjectID");
                String assign_id = request.getParameter("assign_id");
                String isActive = request.getParameter("isActive");
                if (isActive.equals("1")) {
                    int n = dao.AssignmentStatusChange(Integer.parseInt(assign_id), 0);
                    response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subjectID);

                } else {
                    int n = dao.AssignmentStatusChange(Integer.parseInt(assign_id), 1);
                    response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subjectID);

                }
            }
            if (service.equals("checkStatus")) {

                String checkActive = request.getParameter("checkActive");
                if (checkActive.equals("display")) {
                    List<User> listName = dao.getName();
                    List<User> list3 = dao.getManager();
                    request.setAttribute("data3", list3);
                    request.setAttribute("manageN", listName);
                    response.sendRedirect("manageSubjectController");
                } else {
                    if (role == 15) {
                        Vector<Subject> vector = dao.getSubject("select * from subject where is_active LIKE '%" + checkActive + "%' and manager_id = " + userID + "");
                        List<User> listName = dao.getName();
                        List<User> list3 = dao.getManager();
                        request.setAttribute("data3", list3);
                        request.setAttribute("manageN", listName);
                        request.setAttribute("data", vector);
                        request.getRequestDispatcher("pages/admin/Subject/subjectList.jsp").forward(request, response);
                    } else if (role == 14) {
                        Vector<Subject> vector = dao.getSubject("select * from subject where is_active LIKE '%" + checkActive + "%'");
                        List<User> listName = dao.getName();
                        List<User> list3 = dao.getManager();
                        request.setAttribute("data3", list3);
                        request.setAttribute("manageN", listName);
                        request.setAttribute("data", vector);
                        request.getRequestDispatcher("pages/admin/Subject/subjectList.jsp").forward(request, response);
                    }
                }
            }
//---------------------------------------               
// Filter            
            if (service.equals("filterStatusAssignment")) {

                String checkActive = request.getParameter("checkActive");
                if (checkActive.equals("display")) {
                    String subject_code = request.getParameter("subjectID");
                    int SubID = Integer.parseInt(subject_code);
                    List<Assignment> listAssignment = dao.getSubjectAssignment(SubID);
                    request.setAttribute("listAssignment", listAssignment);
                    response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subject_code);
                } else {
                    String subject_code = request.getParameter("subjectID");
                    int SubID = Integer.parseInt(subject_code);

                    List<Subject> listDetails = dao.getSubjectDetails(SubID);
                    List<Assignment> listAssignment = dao.getSubjectAssignment(SubID);
                    List<Assignment> listAssignment2 = dao.getListSubjectAssignment("select * from assignment where subject_id = '" + SubID + "' and is_active= '" + checkActive + "'");
                    request.setAttribute("subjectID", subject_code);
                    request.setAttribute("listDetails", listDetails);
                    request.setAttribute("listAssignment", listAssignment);
                    request.setAttribute("listAssignment", listAssignment2);
                    request.getRequestDispatcher("pages/subjectManager/assignmentList.jsp").forward(request, response);
                    //response.sendRedirect("manageSubjectController?service=displayAssignment&subjectID=" + subject_code);
                    //fix duong truyen 
                }
            }
            if (service.equals("filterManager")) {

                String checkManager = request.getParameter("checkManager");
                if (checkManager.equals("display")) {
                    List<User> listName = dao.getName();
                    request.setAttribute("manageN", listName);
                    response.sendRedirect("SubjectController");
                } else if (role == 14) {
                    Vector<Subject> vector = dao.getSubject("select * from subject where manager_id =" + checkManager);
                    List<User> listName = dao.getName();
                    List<User> list3 = dao.getManager();
                    request.setAttribute("data3", list3);
                    request.setAttribute("manageN", listName);
                    request.setAttribute("data", vector);
                    request.getRequestDispatcher("pages/admin/Subject/subjectList.jsp").forward(request, response);
                }
            }
            if (service.equals("filterIssueType")) {
                String issueType = request.getParameter("issueType");
                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                List<Subject> listDetails = dao.getSubjectDetails(SubID);
                List<IssueSetting> resultType = null;
                if (issueType.equals("display")) {
                    List<IssueSetting> listType = dao.getAllIssueType(SubID);
                    List<IssueSetting> listStatus = dao.getAllIssueStatus(SubID);
                    resultType = dao.listSubjectSettingSearch("select * from issue_setting where subject_id = " + SubID);
                    request.setAttribute("listType", listType);
                    request.setAttribute("listStatus", listStatus);
                } else {
                    List<IssueSetting> listType = dao.getAllIssueType(SubID);
                    List<IssueSetting> listStatus = dao.getAllIssueStatus(SubID);
                    resultType = dao.listSubjectSettingSearch("select * from issue_setting where subject_id = " + SubID + " and title = '" + issueType + "'");
                    request.setAttribute("listType", listType);
                    request.setAttribute("listStatus", listStatus);
                }
                //request
                List<IssueSetting> listType = dao.getAllIssueType(SubID);
                request.setAttribute("listType", listType);
                request.setAttribute("subjectID", subject_code);
                request.setAttribute("listDetails", listDetails);
                request.setAttribute("listSubjectSetting", resultType);
                request.getRequestDispatcher("pages/subjectManager/subjectSettingList.jsp").forward(request, response);
            }

            if (service.equals("filterIssueStatus")) {
                String issueStatus = request.getParameter("issueStatus");
                String subject_code = request.getParameter("subjectID");
                int SubID = Integer.parseInt(subject_code);
                List<Subject> listDetails = dao.getSubjectDetails(SubID);
                List<IssueSetting> resultStatus = null;
                if (issueStatus.equals("display")) {
                    List<IssueSetting> listType = dao.getAllIssueType(SubID);
                    List<IssueSetting> listStatus = dao.getAllIssueStatus(SubID);
                    resultStatus = dao.listSubjectSettingSearch("select * from issue_setting where subject_id = " + SubID);
                    request.setAttribute("listType", listType);
                    request.setAttribute("listStatus", listStatus);
                } else {
                    List<IssueSetting> listType = dao.getAllIssueType(SubID);
                    List<IssueSetting> listStatus = dao.getAllIssueStatus(SubID);
                    resultStatus = dao.listSubjectSettingSearch("select * from issue_setting where subject_id = " + SubID + " and status = '" + issueStatus + "'");
                    request.setAttribute("listType", listType);
                    request.setAttribute("listStatus", listStatus);
                }
                //request
                List<IssueSetting> listStatus = dao.getAllIssueStatus(SubID);
                request.setAttribute("listStatus", listStatus);
                request.setAttribute("subjectID", subject_code);
                request.setAttribute("listDetails", listDetails);
                request.setAttribute("listSubjectSetting", resultStatus);
                request.getRequestDispatcher("pages/subjectManager/subjectSettingList.jsp").forward(request, response);
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
