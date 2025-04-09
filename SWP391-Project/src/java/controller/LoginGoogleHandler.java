package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import enums.Constants;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.UserDAO;
import enums.SettingGroup;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.UserGoogleDto;
import model.Setting;
import model.User;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;

public class LoginGoogleHandler extends HttpServlet {

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

        String code = request.getParameter("code");
        String accessToken = getToken(code);
        UserGoogleDto userGG = getUserInfo(accessToken);

        HttpSession session = request.getSession();

        // Check if the user's email domain is allowed
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmailOrPhone("email", userGG.getEmail());
        Setting sysSetting = new Setting();
        SettingGroup permitEmail = SettingGroup.PERMITTED_EMAIL;

        int permitEmailValue = permitEmail.getValue();
        List<Setting> listDomain = sysSetting.getListGroupSetting(permitEmailValue);
        String userEmail = user.getEmail();
        String domain = userEmail.split("@")[1];

        //check user email domain are regit or not
        boolean check = false;
        for (Setting permit : listDomain) {
            if (domain.equals(permit.getSettingName())) {
                check = true;
            }
        }
        // redirect user to coresspone dashboard
        if (check) {
            session.setAttribute("user", user);
            int userRole = sysSetting.getSettingByID(user.getRoleId()).getSettingId();
            int isRoleActive = sysSetting.checkSettingActive(userRole);
            if (user.getIsActive() == 1 && isRoleActive == 1) {
                session.setAttribute("user", user);
                switch (userRole) {
                    case 14:
                        response.sendRedirect("UserController?service=listAll");
                        break;
                    case 16:
                        response.sendRedirect("ClassController");
                        break;
                    case 15:
                        response.sendRedirect("manageSubjectController?service=display");
                        break;
                    case 18:
                        response.sendRedirect("ManageProjectController");
                        break;
                    case 19:
                        response.sendRedirect("Dashboard");
                        break;
                }
            } else {
                request.setAttribute("msg", "You are not allow to access our system!");
                request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("msg", "Your email is not allowed to access!");
            request.getRequestDispatcher("pages/common/login.jsp").forward(request, response);
        }
        session.setAttribute("request", request);
        session.setAttribute("response", response);

    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);

        return googlePojo;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the +
    // sign on the left to edit the code.">
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
