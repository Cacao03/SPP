<%-- 
    Document   : userUpdate
    Created on : Sep 20, 2023, 11:24:27 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
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
        <%
            String validate = (String) request.getAttribute("validate");
            String oldPass = (String) request.getAttribute("oldPass");
            String newPass = (String) request.getAttribute("newPass");
            String cfPass = (String) request.getAttribute("cfPass");


        %>
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
        
        
        <div class="page-wrapper doctris-theme toggled">
            <!-- Sidebar wrapper -->
            <%@include file="../layout/adminSideBar.jsp" %>

            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light" >
                <!-- HEADER -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End of HEADER -->
                <div class="container-fluid" style="max-width: 850px">
                    <div class="layout-specing">
                        <div class="container mt-4 bg-white shadow" style="border-radius: 10px;" >
                            <a class="p-0 btn btn-icon btn-pills btn-soft-primary btn-md mt-4 ms-2"  style="" type="button" name="back" onclick="history.back()"><i style="font-size: 1.5em" class="ri-arrow-left-s-line"></i>
                            </a>

                            <h2 class="mb-4" style="text-align: center" style="font-size: 2em" >Change Password</h2>
                            <form class="m-2" id="change-password" action="UserProfileController" method="post">
                                <input type="hidden" name="service" value="changePass">
                                <input type ="hidden" name="submit2" value="Change Pass">
                                <input type="hidden" class="form-control" name="uid" value="${sessionScope.user.getUserId()}">
                                <div class="mb-3">
                                    <input type="hidden" class="form-control" id="oldPass1" value="${sessionScope.user.getPassword()}" >
                                    <label for="oldPass" class="form-label">Old Password<span class="text-danger">*</span></label>
                                    <%if (oldPass == null) {%>
                                    <input type="password" class="form-control" id="oldPass" required name="oldPass"  >
                                    <%} else {%>
                                    <input type="password" class="form-control" id="oldPass" required name="oldPass"  value="<%=oldPass%>" >
                                    <%}%>   
                                </div>
                                <div class="mb-3">
                                    <label for="newPass" class="form-label">New Password<span class="text-danger">*</span></label>
                                    <%if (newPass == null) {%>
                                    <input type="password" title="Your password must have at least 8 characters,no white space allowed, one uppercase letter, and one special character" class="form-control" id="newPass" name="newPass" required>
                                    <%} else {%>
                                    <input value="<%=newPass%>" type="password" title="Your password must have at least 8 characters,no white space allowed, one uppercase letter, and one special character" class="form-control" id="newPass" name="newPass" required>
                                    <%}%>  
                                </div>

                                <div class="mb-3">
                                    <div class="col">
                                        <label for="cfPass" class="form-label">Confirm Password<span class="text-danger">*</span></label>
                                        <%if (cfPass == null) {%>
                                        <input type="password" class="form-control" id="cfPass" name="cfPass" required>
                                        <%} else {%>
                                        <input value="<%=cfPass%>" type="password" class="form-control" id="cfPass" name="cfPass" required>
                                        <%}%>  
                                    </div>
                                </div>     
                                    
                                    <span id="error" style="max-width: 200px"></span>
                                    
                                <p style="color: red"><%=validate != null ? validate : ""%></p>

                                <div class="col">
                                    <button id="btn-password" type="submit" class="btn btn-primary mb-3 w-100"  value="">Save Change</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Footer Start -->
                <%@include file ="../layout/footer.jsp" %>
                <!--end footer-->
            </main>
        </div>

        <!-- Footer Start -->
        <!--end footer-->
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