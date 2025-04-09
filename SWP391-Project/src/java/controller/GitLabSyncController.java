/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.MilestoneDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import util.SyncGitLab;
import model.AssignClass;
import model.Milestone;
import model.User;
import org.gitlab4j.api.GitLabApiException;
/**
 *
 * @author Đàm Quang Chiến
 */
public class GitLabSyncController extends HttpServlet {

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
            out.println("<title>Servlet GitLabSyncController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GitLabSyncController at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        MilestoneDAO milestoneDAO = new MilestoneDAO();
        SyncGitLab syncGit = new SyncGitLab();

        AssignClass assignClass = new AssignClass();
        assignClass = assignClass.getClassInfor(id);

        assignClass = assignClass.getClassInfor(id);
        String subUrl = assignClass.getGitLabId().substring("https://gitlab.com/".length());

        // Setup value for syncGit
        syncGit.setGroupId(subUrl);
        syncGit.setAccessToken(assignClass.getAccessToken());

        try {
            List<Milestone> listClassMilestoneDB = milestoneDAO.getListClassMilestone(id);
            syncGit.syncMilestones(listClassMilestoneDB, id);
            response.sendRedirect("classManager?mode=classMilestone&classId=" + id + "&success=Sync GitLab successfully!");
        } catch (GitLabApiException ex) {
            response.sendRedirect(request.getContextPath() + "/classManager?mode=classMilestone&classId=" + id + "&fail=Sync GitLab fail, please try again!");
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
