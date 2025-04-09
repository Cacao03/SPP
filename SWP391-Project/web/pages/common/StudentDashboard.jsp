<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="dal.SystemSettingDAO,model.Subject,java.sql.ResultSet,enums.SettingGroup" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Student Project Portal Management</title>

        <!-- favicon -->
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

            <%@include file="../layout/adminSideBar.jsp" %>
            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End of HEADER -->

                <!-- BODY -->
                <% 
                    int numberAssignment =(int)request.getAttribute("numberAssignment");
                    int numberProject =(int)request.getAttribute("numberProject");
                    int assignedClass =(int)request.getAttribute("assignedClass");

                %>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Portal Management System</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="#">Student</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">DASHBOARD</li>
                                </ul>
                            </nav>
                        </div>
                        <div class="row">
                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-book-open h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0"><%=numberAssignment%></h5>
                                            <p class="text-muted mb-0">Numbers of Assignment</p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-gitlab h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0"><%=numberProject%></h5>
                                            <p class="text-muted mb-0"> Assigned Project &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class=" uil uil-estate h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0"><%=assignedClass%></h5>
                                            <p class="text-muted mb-0">Numbers of Assigned Class</p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </div>
                        <div class="row">
                            <div class="col-xl-12 col-lg-12 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class=" text-danger align-items-center mb-0">On-going Assignment</h6>
                                    </div>
                                    <% ResultSet rs=(ResultSet)request.getAttribute("assignmentList");%>

                                    <div class="table-responsive">
                                        <table class="  table  bg-white mb-0 table-hover table-bordered">
                                            <thead class="">
                                                <tr>
                                                    <th class="border-bottom p-3 " style="min-width: 50px;">Assignment name</th>
                                                    <th class="border-bottom p-3" style="min-width: 180px;">Subject code</th>
                                                    <th class="border-bottom p-3">Subject name</th>
                                                    <th class="border-bottom p-3">Weight</th>
                                                    <th class="border-bottom p-3">Due date</th>
                                                    <th class="border-bottom p-3" style="min-width: 100px;">Creator</th>
                                                </tr>
                                            </thead>
                                            <% while(rs.next()){%>
                                            <tbody class="">
                                                <tr>
                                                    <td class="p-3"><%=rs.getString("assign_name")%></td>
                                                    <td class="p-3"><%=rs.getString("subject_code")%></td>
                                                    <td class="p-3"><%=rs.getString("subject_name")%></td>
                                                    <td class="p-3"><%=rs.getString("weight")%>%</td>
                                                    <td class="p-3"><%=rs.getString("due_date")%></td>
                                                    <td class="p-3"><%=rs.getString("created_by_name")%></td>
                                                </tr>

                                            </tbody>
                                            <%}%>
                                        </table>

                                    </div>
                                </div>
                            </div>
                            
                        </div>
                        <div class="row mt-4 m-0">
                            <div class="card shadow border-0 p-4 ">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class=" text-danger align-items-center mb-0">On-going Project</h6>
                                </div>
                                <% ResultSet projectList=(ResultSet)request.getAttribute("projectList");%>
                                <div class="table-responsive">
                                    <table class="  table  bg-white mb-0 table-hover table-bordered">
                                        <thead class="">
                                            <tr>
                                                <th class="border-bottom p-3 " style="min-width: 50px;">Class name</th>
                                                <th class="border-bottom p-3 " style="min-width: 50px;">Subject name</th>
                                                <th class="border-bottom p-3 " style="min-width: 50px;">Project code</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Project Name</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Mentor Name</th>
                                            </tr>
                                        </thead>
                                        <% while(projectList.next()){%>
                                        <tbody class="">
                                            <tr>
                                                <td class="p-3"><%=projectList.getString("class_code")%></td>
                                                <td class="p-3"><%=projectList.getString("subject_name")%></td>
                                                <td class="p-3"><%=projectList.getString("subject_code")%></td>
                                                <td class="p-3"><%=projectList.getString("project_en_name")%></td>
                                                <td class="p-3"><%=projectList.getString("full_name")%></td>
                                            </tr>

                                        </tbody>
                                        <%}%>
                                    </table>

                                </div>
                            </div>
                        </div>
                        <!-- END OF BODY -->

                    </div>
                    <!-- Footer Start -->
                    <%@include file="../layout/footer.jsp" %>
                    <!--end footer-->


            </main>
            <!--End Page-content" -->
        </div>
        <!-- End of page-wrapper -->
    </div>

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