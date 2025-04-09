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
                    <div class="layout-specing">
                        <div class="row mb-3">
                            <div class="col-xl-9 col-md-6">
                                <h5 class="mb-0">Project Management</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="">Project Management</a></li>
                                        <li class="breadcrumb-item"><a href="ManageProjectController">Select Class</a></li>
                                        <li class="breadcrumb-item " ><a href="ManageProjectController?service=ProjectList&class_id=${class_id}">Project List</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Project Details</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                        </div> 


                        <%
                            ResultSet rsMilstones = (ResultSet) request.getAttribute("rsMilstones");
                        %>
                        <div class="bg-white component-wrapper border-0 rounded shadow">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0"> Project details </h5>
                            </div>
                            <div class="p-4">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded" id="pills-tab" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link rounded" href="javascript:history.back()" role="tab" aria-controls="pills-smart" aria-selected="false">
                                                    <div class="text-center pt-1 pb-1">
                                                        <h4 class="title font-weight-normal mb-0">General</h4>
                                                    </div>
                                                </a><!--end nav link-->
                                            </li><!--end nav item-->

                                            <li class="nav-item">
                                                <a class="nav-link rounded active" id="pills-cloud-tab" data-bs-toggle="pill" href="#pills-cloud" role="tab" aria-controls="pills-cloud" aria-selected="false">
                                                    <div class="text-center pt-1 pb-1">
                                                        <h4 class="title font-weight-normal mb-0">Milestone</h4>
                                                    </div>
                                                </a><!--end nav link-->
                                            </li><!--end nav item-->

                                            <li class="nav-item">
                                                <a class="nav-link rounded" role="tab" aria-controls="pills-smart" aria-selected="false">
                                                    <div class="text-center pt-1 pb-1">
                                                        <h4 class="title font-weight-normal mb-0">Settings</h4>
                                                    </div>
                                                </a><!--end nav link-->
                                            </li><!--end nav item-->
                                              <li class="nav-item">
                                                    <a class="nav-link rounded"  href="IssueSettingController?service=ListProjectIssue" role="tab" aria-controls="pills-apps" aria-selected="true">
                                                        <div class="text-center pt-1 pb-1">
                                                            <h4 class="title font-weight-normal mb-0">Issue</h4>
                                                        </div>
                                                    </a><!--end nav link-->
                                                </li><!--end nav item-->
                                        </ul><!--end nav pills-->
                                    </div><!--end col-->
                                </div><!--end row-->

                                <div class="row pt-2">
                                    <div class="col-12">
                                        <div class="tab-content" id="pills-tabContent">
                                            <div class="table-responsive m-0">
                                                <table class="  table  bg-white mb-0 table-hover table-bordered" id="myTable">
                                                    <thead class="">
                                                        <tr>
                                                            <th class="border-bottom p-3 "style="min-width: 50px;">Issue ID</th>
                                                            <th class="border-bottom p-3" style="min-width: 180px;">Project ID</th>
                                                            <th class="border-bottom p-3" >Start date</th>
                                                            <th class="border-bottom p-3" >Due date</th>
                                                            <th class="border-bottom p-3">Description</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody class="">
                                                        
                                                        <tr>
                                                            <td class="p-3"><%=rsMilstones.getInt("milestone_id")%></td>
                                                            <td class="p-3"><%=rsMilstones.getString("milestone_name")%></td>
                                                            <td class="p-3"><%=rsMilstones.getString("start_date")%></td>
                                                            <td class="p-3"><%=rsMilstones.getString("due_date")%></td>
                                                            <td class="p-3"><%=rsMilstones.getString("description")%></td>
                                                        </tr>
                                                        
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div><!--end tab content-->
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div>
                        </div>




                    </div>

                    <!-- END OF BODY -->

                    <!-- Footer Start -->
                    <%@include file="../../layout/footer.jsp" %>
                    <!--end footer-->
                </div>
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