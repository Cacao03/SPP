<%-- 
    Document   : SystemSettingAdd
    Created on : Sep 20, 2023, 8:09:24 PM
    Author     : TRAN DUNG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Setting,java.sql.ResultSet,enums.SettingGroup"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Project Portal Management</title>
        <link rel="shortcut icon" href="assests/images/logo.png">
        <!-- Bootstrap -->
        <link href="assests/css/bootstrap5.0.min.css" rel="stylesheet"  />
        <!-- simplebar -->
        <link href="assests/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="assests/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="assests/css/flatpickr.min.css">
        <link href="assests/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assests/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assests/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="assests/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>
    <body>

        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <!-- page-wrapper -->
        <div class="page-wrapper doctris-theme toggled">

            <!-- Sidebar wrapper -->
            <%@include file="../../layout/adminSideBar.jsp" %>
            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../../layout/navbar.jsp" %>
                <!-- End of HEADER -->

                <!-- BODY -->
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row mb-3">
                            <div class="col-xl-9 col-md-6">
                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="SystemSettingController">Manage System Setting</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">System Setting Details </li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                        </div> 
                        <div class="row">
                            <div class="bg-white component-wrapper border-0 rounded shadow" >
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0"> System Setting Details</h5>
                                </div>
                                <div class="p-4">
                                    <div class="row">
                                        <% 
            Setting setting =(Setting)request.getAttribute("setting");
            String validate=(String)request.getAttribute("validate");  
                                        %>

                                        <%if(validate != null){%>
                                        <div class="alert alert-danger" role="alert">
                                            <%=validate%>
                                        </div>
                                        <%}%>
                                        <form action="SystemSettingController" onsubmit="return confirm('Are you sure you want to save changes?')" >
                                            <input type="hidden" name="service" value="updateSystemSetting">
                                            <div class="row mb-3">
                                                <div class="col"> 
                                                    <label for="Setting_Group" class="form-label">Setting ID:</label>
                                                    <input type="text" readonly class="form-control" id="Setting_Group" name="Setting_ID" value="<%=setting.getSettingId()%>" required>                       
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col"> 
                                                    <label for="Setting_Group" class="form-label">Setting Group:</label>
                                                    <%
                                                        SettingGroup SEMESTER = SettingGroup.SEMESTER;
                                                        SettingGroup USER_ROLE = SettingGroup.USER_ROLE;
                                                        SettingGroup PERMITTED_EMAIL = SettingGroup.PERMITTED_EMAIL;
                                                        int setting_group = Integer.parseInt(setting.getSettingGroup());
                                                        if(setting_group == SEMESTER.getValue()){
                                                    %>
                                                    <input type="text" class="form-control"  value="Semester" disabled="">   
                                                    <%}else if(setting_group == USER_ROLE.getValue()){%>
                                                    <input type="text" class="form-control"  value="User Role" disabled >
                                                    <%}else if(setting_group == PERMITTED_EMAIL.getValue()){%>
                                                    <input type="text"  class="form-control" value="Permitted Email" disabled > 
                                                    <%}%>
                                                    <input type="hidden" class="form-control" id="Setting_Group" name="Setting_Group" value="<%=setting.getSettingGroup()%>">     
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <div class="col">
                                                    <label for="Setting_Name" class="form-label">Setting Name:</label>

                                                    <input type="text" class="form-control" id="Setting_Name" name="Setting_Name" value="<%=setting.getSettingName()%>" required>
                                                </div>
                                            </div>


                                            <div class="row mb-3">
                                                <div class="col">
                                                    <label for="Description">Description:</label>
                                                    <textarea class="form-control" id="Description" name="Description"><%=setting.getDescription()%></textarea>
                                                </div>
                                            </div>
                                            <button type="submit" name="submit" value="submit" class="btn btn-primary">Save change</button>
                                        </form>


                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- Footer Start -->
                <%@include file="../../layout/footer.jsp" %>
                <!--end footer-->


            </main>
            <!--End Page-content" -->
        </div>
        <!-- End of page-wrapper -->


        <!-- javascript -->
        <script src="assests/js/jquery.min.js"></script>
        <script src="assests/js/bootstrap5.0.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assests/js/simplebar.min.js"></script>
        <!-- Select2 -->
        <script src="assests/js/select2.min.js"></script>
        <script src="assests/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="assests/js/flatpickr.min.js"></script>
        <script src="assests/js/flatpickr.init.js"></script>
        <!-- Datepicker -->
        <script src="assests/js/jquery.timepicker.min.js"></script>
        <script src="assests/js/timepicker.init.js"></script>
        <!-- Icons -->
        <script src="assests/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assests/js/app.js"></script>

    </body>
</html>
