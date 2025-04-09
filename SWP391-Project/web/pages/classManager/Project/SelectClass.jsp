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
                    <div class="layout-specing">
                        <!--bread crums-->
                        <div class="row">
                            <div class="col-xl-9 col-md-6">
                                <h5 class="mb-0">Project Management</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="">Project Management</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Select Class</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                        </div>   
                        <!-- end of bread crums-->
                        <!--class card-->

                        <div class="row row-cols-md-2 row-cols-lg-5">
                            <%
                                ResultSet rsClass = (ResultSet) request.getAttribute("rsClass");
                                while (rsClass.next()) {
                            %>
                            <div class="col mt-4">
                                <div class="card team border-0 rounded shadow overflow-hidden">  
                                    <div class="card-body content text-center">
                                        <a href="ManageProjectController?service=ProjectList&class_id=<%=rsClass.getString("class_id")%>" class="title text-dark h5 d-block mb-0"><%=rsClass.getString("class_code")%></a>
                                    </div>
                                </div>
                            </div><!--end col-->
                            <%}%>
                        </div>
                        <!--end of class card-->
                    </div>
                </div>

                <!-- END OF BODY -->

                <!-- Footer Start -->
                <%@include file="../../layout/footer.jsp" %>
                <!--end footer-->

        </div>
    </body>


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