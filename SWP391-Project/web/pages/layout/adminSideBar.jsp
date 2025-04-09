

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!-- Sidebar wrapper -->
    <nav id="sidebar" class="sidebar-wrapper">
        <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
            <div class="sidebar-brand  ">
                <a href="" class="d-flex justify-content-center">
                    <img src="assests/images/logo.png" width="140" height="60" class="logo-light-mode" alt="">
                </a>
            </div>
            <%
                User user = (User) session.getAttribute("user");
                int role = user.getRoleId();
            %>
            <%if (role == 14) {%>
            <ul class="sidebar-menu pt-3">

                <li><a href="UserController?service=listAll"><i class="uil uil-user me-2 d-inline-block"></i>User Management</a></li>
                <li><a href="SubjectController"><i class="uil uil-book-alt me-2 d-inline-block"></i>Subject Management</a></li>
                <li><a href="ClassController"><i class="uil uil-users-alt me-2 d-inline-block"></i>Class Management</a></li>
                <li><a href="ManageProjectController"><i class="uil uil-clipboard-notes me-2 d-inline-block"></i>Project Management</a></li>
                <li><a href="SystemSettingController"><i class="uil uil-setting me-2 d-inline-block"></i>Setup System Settings</a></li>
            </ul>
            <%} else if (role == 15) {%>
            <ul class="sidebar-menu pt-3">
                <li><a href="manageSubjectController"><i class="uil uil-book-alt me-2 d-inline-block"></i>Subject Management</a></li>
                <li><a href="ClassController"><i class="uil uil-users-alt me-2 d-inline-block"></i>Class Management</a></li>
                <li><a href="ManageProjectController"><i class="uil uil-clipboard-notes me-2 d-inline-block"></i>Project Management</a></li>
            </ul>
            <%} else if (role == 16) {%>
            <ul class="sidebar-menu pt-3">
                <li><a href="ClassController"><i class="uil uil-users-alt me-2 d-inline-block"></i>Class Management</a></li>
                <li><a href="ManageProjectController"><i class="uil uil-clipboard-notes me-2 d-inline-block"></i>Project Management</a></li>
            </ul> 
            <%} else if (role == 18) {%>
            <ul class="sidebar-menu pt-3">
                <li><a href="ManageProjectController"><i class="uil uil-clipboard-notes me-2 d-inline-block"></i>Project Management</a></li>
            </ul>
            <%} else if (role == 19) {%>
            <ul class="sidebar-menu pt-3">
                <li><a href="Dashboard"><i class="uil uil-clipboard-notes me-2 d-inline-block"></i>Dashboard</a></li>
                
            </ul>
            <%}%>
        </div>
        <div class="sidebar-footer" ">
            <%if (role == 14) {%>
            Login as Admin
            <%} else if (role == 16) {%>
            Login as Class Manager
            <%} else if (role == 15) {%>
            Login as Subject Manager
            <%} else if (role == 18) {%>
            Login as Project Mentor
            <%} else if (role == 19) {%>
            Login as Student
            <%}%>
        </div>
    </nav>
</html>
