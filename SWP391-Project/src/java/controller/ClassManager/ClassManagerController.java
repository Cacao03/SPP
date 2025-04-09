/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ClassManager;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AssignClass;
import model.ClassStudent;
import model.IssueSetting;
import model.Milestone;
import model.User;
import util.ExcelHandler;

/**
 *
 * @author Đàm Quang Chiến
 */
@MultipartConfig()
public class ClassManagerController extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ClassManagerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClassManagerController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AssignClass assignClass = new AssignClass();
        Milestone milestone = new Milestone();
        ClassStudent classSt = new ClassStudent();
        IssueSetting classIssue = new IssueSetting();
        User user = (User) session.getAttribute("user");
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        if (request.getParameter("mode") != null) {
            String mode = request.getParameter("mode");
            int classId = Integer.parseInt(request.getParameter("classId"));
            assignClass = assignClass.getClassInfor(classId);
            request.setAttribute("assignClass", assignClass);
            switch (mode) {
                case "classSetting":
                    request.getRequestDispatcher("pages/classManager/assignClassSetting.jsp").forward(request, response);
                    break;
                case "classMilestone":

                    if (request.getParameter("option") != null && request.getParameter("option").equals("changeStatus")) {
                        int mileId = Integer.parseInt(request.getParameter("mileId"));
                        if (request.getParameter("statusMethod") != null) {
                            boolean check = milestone.deleteMilestone(mileId);
                            if (check) {
                                request.setAttribute("success", "Delete successfully");
                            } else {
                                request.setAttribute("fail", "Delete fail");
                            }
                        } else {
                            int status = Integer.parseInt(request.getParameter("status"));
                            boolean result = milestone.changeMilestoneStatus(mileId, status);
                            if (result) {
                                request.setAttribute("success", "Change status successfully");
                            } else {
                                request.setAttribute("fail", "Change status fail");
                            }
                        }
                    }
                    if (request.getParameter("option") != null && request.getParameter("option").equals("update")) {
                        int mileId = Integer.parseInt(request.getParameter("mileId"));
                        milestone = milestone.getMilestoneById(mileId);
                        StringBuilder htmlResponse = new StringBuilder();
                        htmlResponse.append("<div class=\"modal-body\" id=\"modal-update-milestone\"> ");
                        htmlResponse.append("<form id=\"milestoneForm\" action=\"classManager\" method=\"post\">\n");
                        htmlResponse.append("    <input type=\"hidden\" name=\"mileId\" value=\"").append(milestone.getId()).append("\">\n");
                        htmlResponse.append("    <input type=\"hidden\" name=\"classId\" value=\"").append(milestone.getClassId()).append("\">\n");
                        if (milestone.getProjectId() != 0) {
                            htmlResponse.append("<input type=\"hidden\" name=\"projectId\" value=\"").append(milestone.getProjectId()).append("\">\n");
                        } else {
                            htmlResponse.append("<input type=\"hidden\" name=\"projectId\" value=\"").append(0).append("\">\n");
                        }
                        htmlResponse.append("    <div class=\"mb-3\">\n");
                        htmlResponse.append("        <label class=\"form-label\">Title<span class=\"text-danger\"> *</span></label>\n");
                        htmlResponse.append("        <input name=\"milestone-title\" id=\"milestone-title\" type=\"text\" class=\"form-control\" value=\"").append(milestone.getName()).append("\">\n");
                        htmlResponse.append("    </div>\n");
                        htmlResponse.append("    <div class=\"mb-3\">\n");
                        htmlResponse.append("        <label class=\"form-label\">Start Date<span class=\"text-danger\"> *</span></label>\n");
                        htmlResponse.append("        <input name=\"milestone-start-date\" id=\"milestone-start-date\" type=\"date\" class=\"form-control\" value=\"").append(milestone.getStartDate()).append("\">\n");
                        htmlResponse.append("    </div>\n");
                        htmlResponse.append("    <div class=\"mb-3\">\n");
                        htmlResponse.append("        <label class=\"form-label\">Due Date<span class=\"text-danger\"> *</span></label>\n");
                        htmlResponse.append("        <input name=\"milestone-due-date\" id=\"milestone-due-date\" type=\"date\" class=\"form-control\" value=\"").append(milestone.getDueDate()).append("\">\n");
                        htmlResponse.append("    </div>\n");
                        htmlResponse.append("    <div class=\"col-md-12\">\n");
                        htmlResponse.append("        <div class=\"mb-3 d-flex\">\n");
                        htmlResponse.append("            <label class=\"form-label\">Status</label>\n");
                        if (milestone.getIsActive() == 1) {
                            htmlResponse.append(" <div class=\"form-check form-switch\" style=\"margin-left: 12px;\">\n"
                                    + "              <input class=\"form-check-input\" name=\"status\" value=\"1\" type=\"checkbox\" style=\" cursor: pointer\" role=\"switch\" id=\"flexSwitchCheckChecked\" checked>\n"
                                    + "           </div>");
                        } else {

                            htmlResponse.append("<div class=\"form-check form-switch\" style=\"margin-left: 12px;\">\n"
                                    + "              <input class=\"form-check-input\" name=\"status\" value=\"1\" type=\"checkbox\" style=\" cursor: pointer\" role=\"switch\" id=\"flexSwitchCheckChecked\">\n"
                                    + "          </div>");
                        }
                        htmlResponse.append("        </div>\n");
                        htmlResponse.append("    </div>\n");
                        htmlResponse.append("    <div class=\"col-md-12\">\n");
                        htmlResponse.append("        <div class=\"mb-3\">\n");
                        htmlResponse.append("            <label class=\"form-label\">Description</label>\n");
                        htmlResponse.append("            <textarea name=\"descript\" id=\"descript\" rows=\"4\" class=\"form-control\">").append(milestone.getDescript()).append("</textarea>\n");
                        htmlResponse.append("        </div>\n");
                        htmlResponse.append("    </div>\n");
                        htmlResponse.append("</form>\n");
                        htmlResponse.append("</div>");
                        response.getWriter().write(htmlResponse.toString());
                        return;
                    }
                    ;
                    List<Milestone> listMilestone = null;
                    String projectIdParam = request.getParameter("projectId");

                    int projectId = (projectIdParam != null && !projectIdParam.isEmpty()) ? Integer.parseInt(projectIdParam) : 0;

                    int totalClassMilestone = milestone.getTotalClassMileStones(classId);
                    if (request.getParameter("isFilter") != null) {
                        String isFilter = request.getParameter("isFilter");
                        switch (isFilter) {
                            case "status":
                                if (request.getParameter("milstoneStatus").equals("all")) {
                                    listMilestone = milestone.paginateClassMileStone(index, classId, projectId);
                                } else {

                                    int milstoneStatus = Integer.parseInt(request.getParameter("milstoneStatus"));
                                    listMilestone = milestone.filterMilestone(index, classId, "is_active", milstoneStatus);
                                }
                                break;
                            case "search":
                                String searchVal = request.getParameter("searchVal");
                                request.setAttribute("searchVal", searchVal);
                                listMilestone = milestone.searchAndPaginateMilestone(index, classId, searchVal);
                                break;
                        }

                    } else {
                        listMilestone = milestone.paginateClassMileStone(index, classId, projectId);
                    }
                    int endPage = totalClassMilestone / 10;
                    if (totalClassMilestone % 10 != 0) {
                        endPage++;
                    }
                    if (request.getParameter("success") != null) {
                        request.setAttribute("success", request.getParameter("success"));
                    }
                    if (request.getParameter("fail") != null) {
                        request.setAttribute("fail", request.getParameter("fail"));
                    }
                    request.setAttribute("projectId", projectId);

                    String project_id = Integer.toString(projectId);
                    request.setAttribute("project_id", project_id);

                    String class_id = Integer.toString(classId);
                    request.setAttribute("class_id", class_id);
                    request.setAttribute("mode", "mile");
                    request.setAttribute("listMilestone", listMilestone);
                    request.setAttribute("endP", endPage);

                    request.getRequestDispatcher("pages/classManager/assignClassMilestone.jsp").forward(request, response);
                    break;
                case "classStudent":
                    if (request.getParameter("option") != null) {
                        switch (request.getParameter("option")) {
                            case "changeStatus":
                                int classStId = Integer.parseInt(request.getParameter("stId"));
                                int status = Integer.parseInt(request.getParameter("status"));
                                boolean result = classSt.changeStudentStatus(classStId, status);
                                if (result) {
                                    request.setAttribute("success", "Change status successfully");
                                } else {
                                    request.setAttribute("fail", "Change status fail");
                                }
                                break;
                            case "update":
                                classStId = Integer.parseInt(request.getParameter("stId"));
                                projectId = Integer.parseInt(request.getParameter("projectId"));
                                classSt = classSt.getClassStById(classStId, projectId);
                                StringBuilder htmlResponse = new StringBuilder();
                                htmlResponse.append("<div class=\"modal-body\" id=\"modal-update-student\"> ");
                                htmlResponse.append("<form id=\"modalUpdateForm\" action=\"classManager\" method=\"post\">\n");
                                htmlResponse.append("    <input type=\"hidden\" name=\"stId\" value=\"").append(classSt.getId()).append("\">\n");
                                htmlResponse.append("    <input type=\"hidden\" name=\"classId\" value=\"").append(classSt.getClassId()).append("\">\n");
                                htmlResponse.append("    <div class=\"mb-3\">\n");
                                htmlResponse.append("        <label class=\"form-label\">Student:</label>\n");
                                htmlResponse.append("        <input name=\"classStudent\" id=\"classStudent\" type=\"text\" class=\"form-control\" value=\"").append(classSt.getStudentName()).append("\" readonly>\n");
                                htmlResponse.append("    </div>\n");
                                htmlResponse.append("    <div class=\"mb-3\">\n");
                                htmlResponse.append("        <label class=\"form-label\">Group:</label>\n");
                                htmlResponse.append("        <input name=\"classGroup\" id=\"classGroup\" type=\"text\" class=\"form-control\" value=\"").append(classSt.getGroupName() != null ? classSt.getGroupName() : "").append("\" readonly>\n");
                                htmlResponse.append("    </div>\n");
                                htmlResponse.append("    <div class=\"mb-3 d-flex\">\n");
                                htmlResponse.append("        <label class=\"form-label\">Status:</label>\n");
                                htmlResponse.append("        <div class=\"form-check form-switch\" style=\"margin-left: 12px; cursor: pointer\">\n");
                                htmlResponse.append("            <input class=\"form-check-input\" name=\"status\" value=\"1\" type=\"checkbox\" style=\"cursor: pointer\" role=\"switch\" id=\"flexSwitchCheckChecked\"");
                                if (classSt.getIsActive() == 1) {
                                    htmlResponse.append(" checked");
                                }
                                htmlResponse.append(">\n");
                                htmlResponse.append("        </div>\n");
                                htmlResponse.append("    </div>\n");
                                htmlResponse.append("    <div class=\"col-md-12\">\n");
                                htmlResponse.append("        <div class=\"mb-3\">\n");
                                htmlResponse.append("            <label class=\"form-label\">Description:</label>\n");
                                htmlResponse.append("            <textarea name=\"descript\" id=\"descript\" rows=\"4\" class=\"form-control\">");
                                if (classSt.getNote() != null) {
                                    htmlResponse.append(classSt.getNote());
                                }
                                htmlResponse.append("</textarea>\n");
                                htmlResponse.append("        </div>\n");
                                htmlResponse.append("    </div>\n");
                                htmlResponse.append("</form>\n");
                                htmlResponse.append("</div>\n");

                                response.getWriter().write(htmlResponse.toString());
                                return;
                            case "export":
                                List<ClassStudent> listClassSt = classSt.getListClassStudent(classId);
                                ExcelHandler excel = new ExcelHandler();
                                boolean resultExport = excel.exportClassStudentListToExcel(listClassSt, assignClass.getClassCode());
                                if (resultExport == true) {
                                    request.setAttribute("success", "Export class student successfully");
                                } else {
                                    request.setAttribute("fail", "Export class student fail");
                                }
                                break;
                            case "getListStudent":
                                User userDB = new User();
                                StringBuilder htmlResponse1 = new StringBuilder();
                                List<User> listUser = userDB.getListUserNoclass();
                                htmlResponse1.append("<div class=\"modal-body\" id=\"modal-list-student\"> ");
                                htmlResponse1.append("<div class=\"input-group mb-2\">\n"
                                        + "  <input type=\"text\" class=\"form-control rounded-pill \" name=\"searchVal\" value=\"\" id=\"searchKey\" onchange=\"searchStudent(this.value)\" placeholder=\"Search Keywords...\" >\n"
                                        + "   <div class=\"input-group-append\" style=\"margin-left: 8px\">\n"
                                        + "      <button class=\"btn btn-pills btn-soft-success\" onclick=\"searchStudent(document.getElementById('searchKey').value) title=\"Search\">\n"
                                        + "          <i class=\"fas fa-search\"></i>\n"
                                        + "       </button>\n"
                                        + "    </div>\n"
                                        + "   </div>");
                                htmlResponse1.append("<div style='max-height: 400px; overflow-y: auto;'>");
                                htmlResponse1.append("<form id='userForm' action='classManager' method='get'>");
                                htmlResponse1.append("<table id=\"myTable2\" class=\"table table-hover \">");
                                htmlResponse1.append("<thead>");
                                htmlResponse1.append("<tr>");
                                htmlResponse1.append("<th>" + "<input type='checkbox' id='masterCheckbox' />" + "</th>");
                                htmlResponse1.append("<th onclick =\"sortTable2(0)\" style=\" cursor: pointer\">No.<i class=\"fas fa-sort\"></i></th>");
                                htmlResponse1.append("<th onclick =\"sortTable2(1)\" style=\" cursor: pointer\">Name<i class=\"fas fa-sort\"></i></th>");
                                htmlResponse1.append("<th onclick =\"sortTable2(2)\" style=\" cursor: pointer\">Email<i class=\"fas fa-sort\"></i></th>");
                                htmlResponse1.append("<th onclick =\"sortTable2(3)\" style=\" cursor: pointer\">Phone<i class=\"fas fa-sort\"></i></th>");
                                htmlResponse1.append("</tr>");
                                htmlResponse1.append("</thead>");
                                htmlResponse1.append("<input type='hidden' name='classId' value='").append(classId).append("'/>");
                                htmlResponse1.append("<input type='hidden' name='mode' value='classStudent' />");
                                htmlResponse1.append("<input type='hidden' name='option' value='add' />");
                                htmlResponse1.append("<tbody>");

                                int counter = 1;
                                for (User u : listUser) {
                                    htmlResponse1.append("<tr>");
                                    htmlResponse1.append("<td><input type='checkbox' class='userCheckbox mr-2' name='userIds' value='").append(u.getUserId()).append("' />").append("</td>");
                                    htmlResponse1.append("<td>").append(counter++).append("</td>");
                                    htmlResponse1.append("<td>").append(u.getFullName()).append("</td>");
                                    htmlResponse1.append("<td>").append(u.getEmail()).append("</td>");
                                    htmlResponse1.append("<td>").append(u.getMobile()).append("</td>");
                                    htmlResponse1.append("</tr>");
                                }

                                htmlResponse1.append("</tbody>");
                                htmlResponse1.append("</table>");
                                htmlResponse1.append("</form>");
                                htmlResponse1.append("</div>"); // End of scrollable container
                                htmlResponse1.append("</div>");

                                response.getWriter().write(htmlResponse1.toString());
                                return;
                            case "add":
                                String[] selectedUserIds = request.getParameterValues("userIds");
                                if (selectedUserIds != null && selectedUserIds.length > 0) {
                                    for (String userId : selectedUserIds) {
                                        User userAd = new User();
                                        classSt.setStudentId(Integer.parseInt(userId));
                                        classSt.setClassId(classId);
                                        try {
                                            classSt.createNewClassSt();
                                        } catch (SQLException ex) {
                                            Logger.getLogger(ClassManagerController.class.getName()).log(Level.SEVERE, null, ex);
                                        }
                                    }
                                }
                                break;
                            default:
                                throw new AssertionError();
                        }
                    }
                    List<ClassStudent> listClassSt = null;
                    String sortType = (request.getParameter("sortType") == null || request.getParameter("sortType").isEmpty()) ? null : request.getParameter("sortType");
                    String sortValueStr = request.getParameter("sortVal");
                    String sortValueStr1 = request.getParameter("sortVal1");
                    String sortValue = null;
                    String sortValue2 = null;
                    if (sortValueStr != null && !sortValueStr.isEmpty()) {
                        sortValue = sortValueStr;
                    }
                    if (sortValueStr1 != null && !sortValueStr1.isEmpty()) {
                        sortValue2 = sortValueStr1;
                    }
                    if (request.getParameter("isFilter") != null) {
                        String isFilter = request.getParameter("isFilter");
                        switch (isFilter) {
                            case "search":
                                String searchVal = request.getParameter("searchVal");
                                request.setAttribute("searchVal", searchVal);
                                listClassSt = classSt.searchAndPaginateStudent(index, classId, searchVal);
                                break;
                        }

                    } else {
                        listClassSt = classSt.paginateClassStudent(index, classId, sortType, sortValue, sortValue2);
                    }

                    ProjectDAO projectDAO = new ProjectDAO();
                    ResultSet listProjectName = projectDAO.getProjectByClassID(String.valueOf(classId));
                    int totalClassSt = classSt.getTotalClassStudent(classId, sortType, sortValue, sortValue2);
                    endPage = totalClassSt / 10;
                    if (totalClassSt % 10 != 0) {
                        endPage++;
                    }
                    request.setAttribute("listProject", listProjectName);
                    request.setAttribute("sortType", sortType);
                    request.setAttribute("sortValue", sortValue);
                    request.setAttribute("listClassSt", listClassSt);
                    request.setAttribute("endP", endPage);
                    request.getRequestDispatcher("pages/classManager/assignClassStudent.jsp").forward(request, response);
                    break;
                default:
                    throw new AssertionError();
            }
        }

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
        if ("import".equals(request.getParameter("mode"))) {
            try {
                Part filePart = request.getPart("file");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                int classId = Integer.parseInt(request.getParameter("classId"));
                // Assuming the file needs to be saved to a temporary location before processing
                String tempDirectory = request.getServletContext().getRealPath(""); // Adjust this
                File file = new File(tempDirectory + File.separator + fileName);
                try ( InputStream input = filePart.getInputStream()) {
                    Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                ExcelHandler excel = new ExcelHandler();
                // Now you have the file saved, and you can use its path for further processing
                excel.importClassStudentFromExcel(file.getAbsolutePath());
                response.sendRedirect("classManager?mode=classStudent&classId=" + classId);
            } catch (SQLException ex) {
                Logger.getLogger(ClassManagerController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("add".equals(request.getParameter("mode"))) {
            List<String> errors = new ArrayList<>();
            AssignClass assignClass = new AssignClass();
            Milestone milestone = new Milestone();
            String name = request.getParameter("milestone-title");
            int classId = Integer.parseInt(request.getParameter("classId"));
            String startDateStr = request.getParameter("milestone-start-date");
            String dueDateStr = request.getParameter("milestone-due-date");
            String des = request.getParameter("descript").trim();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            try {
                Date startDate = null;
                Date dueDate = null;

                // Check if startDateStr is not empty or null before parsing
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = dateFormat.parse(startDateStr);
                }

                // Check if dueDateStr is not empty or null before parsing
                if (dueDateStr != null && !dueDateStr.isEmpty()) {
                    dueDate = dateFormat.parse(dueDateStr);
                }

                if (name.isEmpty()) {
                    errors.add("Title cannot be empty");
                }

                // Check if both startDate and dueDate are not null before comparing
                if (startDate != null && dueDate != null) {
                    if (dueDate.compareTo(startDate) < 0) {
                        errors.add("Due date must be greater than or equal to start date");
                    }
                }

                if (milestone.checkExisted("milestone_name", name, 0, classId)) {
                    errors.add("Milestone's title must be unique");
                }

                milestone.setDescript(des);
                milestone.setStartDate(startDate);
                milestone.setDueDate(dueDate);
                milestone.setName(name);
                milestone.setClassId(classId);
                milestone.setIsActive(2);
                milestone.setGitlabId("");
                if (!errors.isEmpty()) {
                    request.setAttribute("fail", errors);
                } else {
                    errors.clear();
                    boolean result = milestone.insertMilestone();
                    if (result) {
                        request.setAttribute("success", "Add milestone successfully");
                    } else {
                        request.setAttribute("fail", "Add milestone fail");
                    }
                }

                int totalClassMilestone = milestone.getTotalClassMileStones(classId);
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                List<Milestone> listMilestone = milestone.paginateClassMileStone(1, classId, projectId);
                int endPage = totalClassMilestone / 10;
                if (totalClassMilestone % 10 != 0) {
                    endPage++;
                }
                assignClass = assignClass.getClassInfor(classId);
                request.setAttribute("assignClass", assignClass);
                request.setAttribute("listMilestone", listMilestone);
                request.setAttribute("endP", endPage);
                if (projectId != 0) {
                    response.sendRedirect("classManager?mode=classMilestone&classId=" + assignClass.getClassId() + "&projectId=" + projectId);
                } else {
                    request.getRequestDispatcher("pages/classManager/assignClassMilestone.jsp").forward(request, response);
                }

            } catch (ParseException e) {
                System.out.println(e);
            }
        } else {
            if (request.getParameter("stId") != null) {
                ClassStudent classSt = new ClassStudent();
                String descript = request.getParameter("descript");
                int classId = Integer.parseInt(request.getParameter("classId"));
                int stId = Integer.parseInt(request.getParameter("stId"));
                int status = Integer.parseInt(request.getParameter("status") != null ? request.getParameter("status") : "0");
                boolean result = classSt.updateClassSt(stId, status, descript);
                if (result) {
                    int totalClassSt = classSt.getTotalClassStudent(classId, null, null, null);
                    int endPage = totalClassSt / 10;
                    if (totalClassSt % 10 != 0) {
                        endPage++;
                    }

                    String success = "Update class student successfully";
                    response.sendRedirect("classManager?mode=classStudent&classId=" + classId + "&success=" + success);
                } else {

                    String fail = "Update class student fail";
                    response.sendRedirect("classManager?mode=classStudent&classId=" + classId + "&fail=" + fail);
                }
            } else {
                List<String> errors = new ArrayList<>();
                Milestone milestone = new Milestone();
                AssignClass assignClass = new AssignClass();
                int classId = Integer.parseInt(request.getParameter("classId"));
                int id = Integer.parseInt(request.getParameter("mileId"));
                String name = request.getParameter("milestone-title");
                String startDateStr = request.getParameter("milestone-start-date");
                String dueDateStr = request.getParameter("milestone-due-date");
                int status = Integer.parseInt(request.getParameter("status") != null ? request.getParameter("status") : "0");
                String des = request.getParameter("descript").trim();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                try {
                    Date startDate = null;
                    Date dueDate = null;

                    // Check if startDateStr is not empty or null before parsing
                    if (startDateStr != null && !startDateStr.isEmpty()) {
                        startDate = dateFormat.parse(startDateStr);
                    }

                    // Check if dueDateStr is not empty or null before parsing
                    if (dueDateStr != null && !dueDateStr.isEmpty()) {
                        dueDate = dateFormat.parse(dueDateStr);
                    }

                    if (name.isEmpty()) {
                        errors.add("Title cannot be empty");
                    }

                    // Check if both startDate and dueDate are not null before comparing
                    if (startDate != null && dueDate != null) {
                        if (dueDate.compareTo(startDate) < 0) {
                            errors.add("Due date must be greater than or equal to start date");
                        }
                    }

                    if (milestone.checkExisted("milestone_name", name, id, classId)) {
                        errors.add("Milestone's title must be unique");
                    }
                    int projectId = request.getParameter("projectId") != null || !request.getParameter("projectId").isEmpty() ? Integer.parseInt(request.getParameter("projectId")) : 0;
                    milestone.setId(id);
                    milestone.setDescript(des);
                    milestone.setStartDate(startDate);
                    milestone.setDueDate(dueDate);
                    milestone.setName(name);
                    milestone.setIsActive(status);
                    if (projectId != 0) {
                        milestone.setProjectId(projectId);
                    }
                    if (!errors.isEmpty()) {
                        request.setAttribute("fail", errors);
                    } else {
                        errors.clear();
                        boolean result = milestone.updateMilestone();
                        if (result) {
                            request.setAttribute("success", "Update milestone successfully");
                        } else {
                            request.setAttribute("fail", "Update milestone fail");
                        }
                    }

                    milestone = milestone.getMilestoneById(id);

                    int totalClassMilestone = milestone.getTotalClassMileStones(milestone.getClassId());

                    List<Milestone> listMilestone = milestone.paginateClassMileStone(1, milestone.getClassId(), projectId);
                    int endPage = totalClassMilestone / 10;
                    if (totalClassMilestone % 10 != 0) {
                        endPage++;
                    }
                    assignClass = assignClass.getClassInfor(milestone.getClassId());
                    request.setAttribute("assignClass", assignClass);
                    request.setAttribute("listMilestone", listMilestone);
                    request.setAttribute("endP", endPage);
                    if (projectId != 0) {

                        response.sendRedirect("classManager?mode=classMilestone&classId=" + assignClass.getClassId() + "&projectId=" + projectId);
                    } else {
                        request.getRequestDispatcher("pages/classManager/assignClassMilestone.jsp").forward(request, response);
                    }

                } catch (ParseException e) {
                    System.out.println(e);
                }
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
