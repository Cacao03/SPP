<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="dal.ProjectDAO,model.Project,java.sql.ResultSet,enums.SettingGroup" %>

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
    <style>
        .card {
            width: 100%;
            max-width: 700px;
            margin: 0 auto;
        }

        .card-body {
            padding: 1rem;
        }
    </style>
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
            <%--<%@include file="../../layout/classManagerSideBar.jsp" %>--%>
            <%@include file="../../layout/adminSideBar.jsp" %>


            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../../layout/navbar.jsp" %>
                <!-- End of HEADER -->

                <!-- BODY -->
                <div class="container-fluid">
                    <div class="layout-specing ">
                        <div class="card p-4 rounded shadow border-0">
                            <div class="card-body">
                                <%
                                    ResultSet rsStudent = (ResultSet) request.getAttribute("rsStudent");
                                    ResultSet rsAllGroup = (ResultSet) request.getAttribute("rsAllGroup");
                                    while (rsStudent.next()) {
                                %>
                                <form class="m-2" action="ManageProjectController">
                                    <div class="form-group m-2">
                                        <label class="form-label">Move Student: <%=rsStudent.getString("full_name")%></label>
                                    </div>
                                    <div class="form-group m-2">
                                        <label class="form-label">From:</label>
                                        <input  class="form-control" type="text" readonly="" value="<%=rsStudent.getString("project_code")%>">
                                    </div>
                                    <div class="form-group m-2">
                                        <label class="form-label">To:</label>
                                        <select name="project_id" class="form-select">
                                            <option value="" hidden="">Select Group Here</option>
                                            <%while (rsAllGroup.next()) {%>
                                            <option value="<%=rsAllGroup.getString(1)%>"><%=rsAllGroup.getString(2)%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="row mt-5 mb-2 mx-2 ">
                                        <input type="hidden" name="student_id2" value="<%=rsStudent.getString("student_id")%>"></input>
                                        <input type="hidden" name="class_id" value="<%=rsStudent.getString("class_id")%>"></input>
                                        <input type="hidden" name="service" value="moveMember"></input>
                                        <input type="submit" class="btn btn-primary" name="submit" value="Save"></input>
                                    </div>
                                </form>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>


    <!--End Page-content" -->

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



</html>