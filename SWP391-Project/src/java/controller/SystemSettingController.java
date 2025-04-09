/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.RequestDispatcher;
import dal.SystemSettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import model.Setting;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author TRAN DUNG
 */
public class SystemSettingController extends HttpServlet {

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
        SystemSettingDAO dao = new SystemSettingDAO();
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);

        int count = dao.getTotalSystemSetting();
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        try ( PrintWriter out = response.getWriter()) {
            if (service == null) {
                service = "display";
            }
            if (service.equals("display")) {
                //pagingation
                List<Setting> list = dao.pagingSetting(index);
                request.setAttribute("data", list);
                request.setAttribute("endP", endPage);
                //

                request.getRequestDispatcher("pages/admin/System/systemSetting.jsp").forward(request, response);

            }
            if (service.equals("addSystemSetting")) {
                String submit = request.getParameter("submit");
                String validate;
                String Setting_Name;
                if (submit == null) {
                    request.setAttribute("Setting_Name", null);
                    request.setAttribute("validate", null);
                    request.getRequestDispatcher("pages/admin/System/systemSettingAdd.jsp").forward(request, response);
                } else {
                    //get
                    String Setting_Group = request.getParameter("Setting_Group");
                    Setting_Name = request.getParameter("Setting_Name");
                    String Description = request.getParameter("Description");
                    //check duplicate
                    boolean check = dao.checkDuplicate(Setting_Name);
                    //if existed -> re-enter
                    if (check == true) {
                        validate = "Setting name are existed";
                        request.setAttribute("Setting_Name", Setting_Name);
                        request.setAttribute("validate", validate);
                        request.getRequestDispatcher("pages/admin/System/systemSettingAdd.jsp").forward(request, response);
                    } else if (Setting_Name.length() >= 50) {
                        validate = "Setting name can't larger 50 character";
                        request.setAttribute("Setting_Name", Setting_Name);
                        request.setAttribute("validate", validate);
                        request.getRequestDispatcher("pages/admin/System/systemSettingAdd.jsp").forward(request, response);
                    } else {
                        Setting setting = new Setting(Setting_Group, Setting_Name, Description);
                        int n = dao.addSystemSetting(setting);

                        response.sendRedirect("SystemSettingController");
                    }
                }
            }
            if (service.equals("updateSystemSetting")) {
                String submit = request.getParameter("submit");

                if (submit == null) {
                    int Setting_ID = Integer.parseInt(request.getParameter("id"));
                    Setting setting = dao.getSettingbyID(Setting_ID);
                    request.setAttribute("setting", setting);
                    request.getRequestDispatcher("pages/admin/System/systemSettingUpdate.jsp").forward(request, response);
                } else {
                    //get
                    String validate;
                    String Setting_ID = request.getParameter("Setting_ID");
                    String Setting_Group = request.getParameter("Setting_Group");
                    String Setting_Name = request.getParameter("Setting_Name");
                    String Description = request.getParameter("Description");
                    // convert
                    int Setting_ID_INT = Integer.parseInt(Setting_ID);
                    //validate
                    Setting setting_check = dao.getSettingbyID(Setting_ID_INT);
                    //if update not change setting_name ( compare name of setting on db with name are inputed)
                    if (setting_check.getSettingName().equals(Setting_Name)) {
                        Setting setting = new Setting(Setting_ID_INT, Setting_Group, Setting_Name, Description);
                        int n = dao.updateSystemSetting(setting);
                        response.sendRedirect("SystemSettingController");
                    } else {
                        //check duplicate setting_name 
                        boolean check = dao.checkDuplicate(Setting_Name);
                        //if existed -> re-enter
                        if (check == true) {
                            Setting setting = dao.getSettingbyID(Setting_ID_INT);
                            request.setAttribute("setting", setting);
                            validate = "Setting name are existed";
                            request.setAttribute("validate", validate);
                            request.getRequestDispatcher("pages/admin/System/systemSettingUpdate.jsp").forward(request, response);
                        } else if (Setting_Name.length() >= 50) {
                            Setting setting = dao.getSettingbyID(Setting_ID_INT);
                            request.setAttribute("setting", setting);
                            validate = "Setting name can't larger 50 character";
                            request.setAttribute("validate", validate);
                            request.getRequestDispatcher("pages/admin/System/systemSettingUpdate.jsp").forward(request, response);
                        } else {
                            Setting setting = new Setting(Setting_ID_INT, Setting_Group, Setting_Name, Description);
                            int n = dao.updateSystemSetting(setting);
                            response.sendRedirect("SystemSettingController");
                        }
                    }

                    //init
                }
            }
            if (service.equals("changeStatus")) {
                String submit = request.getParameter("submit");
                int Setting_ID = Integer.parseInt(request.getParameter("id"));
                int Status_ID = Integer.parseInt(request.getParameter("status"));

                if (Status_ID == 1) {
                    dao.changeStatusbyID(Setting_ID, 0);
                } else if (Status_ID == 0) {
                    dao.changeStatusbyID(Setting_ID, 1);
                }
                response.sendRedirect("SystemSettingController");
            }
            if (service.equals("findSysyemSettingbyGroup")) {
                String Setting_Group = request.getParameter("Setting_Group");
                //select "All"
                if (Setting_Group.equals("display")) {
                    List<Setting> list = dao.pagingSetting(index);
                    request.setAttribute("data", list);
                    request.setAttribute("endP", endPage);
                    request.getRequestDispatcher("pages/admin/System/systemSetting.jsp").forward(request, response);
                } else {
                    List<Setting> list = dao.pagingSettingByGroup(Setting_Group, index);
                    request.setAttribute("data", list);
                    request.setAttribute("endP", endPage);
                    request.getRequestDispatcher("pages/admin/System/systemSetting.jsp").forward(request, response);
                }
            }
            if (service.equals("findSysyemSettingbyStatus")) {
                String Status = request.getParameter("Status");
                //select "All"
                if (Status.equals("display")) {
                    List<Setting> list = dao.pagingSetting(index);
                    request.setAttribute("data", list);
                    request.setAttribute("endP", endPage);
                    request.getRequestDispatcher("pages/admin/System/systemSetting.jsp").forward(request, response);
                } else {
                    List<Setting> list = dao.pagingSettingByStatus(Status, index);
                    request.setAttribute("data", list);
                    request.setAttribute("endP", endPage);
                    request.getRequestDispatcher("pages/admin/System/systemSetting.jsp").forward(request, response);
                }
            }
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
