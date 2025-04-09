<%-- 
    Document   : assignedClassList
    Created on : Oct 7, 2023, 10:45:47 PM
    Author     : Đàm Quang Chiến
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Project Portal Management</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assests/images/logo.png">
        <!-- Bootstrap -->
        <link href="assests/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assests/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            #nav-class-setting {
                background-color: #007bff; /* Change to your desired background color */
                color: #fff !important; /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
            }
        </style>
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

        <div class="page-wrapper doctris-theme toggled">

            <!-- Sidebar wrapper -->
            <%--<%@include file="../layout/classManagerSideBar.jsp" %>--%>
            <%@include file="../layout/adminSideBar.jsp" %>

            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End of HEADER -->


                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Assigned Class Setting</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="classManager">Assigned Classes Management</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Assigned Class Setting</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">

                            <div class="avatar-profile d-flex margin-nagative mt-n5 position-relative ps-3">

                                <div class="mt-4 ms-3 pt-3">
                                    <h3 class="mt-3">${requestScope.assignClass.classCode}</h3>
                                </div>
                            </div>
                            <div>
                                <button class="btn btn-success mb-3" title="Sync" data-bs-toggle="modal" data-bs-target="#syncModal">
                                    <i class="uil uil-sync icons"></i> Sync with GitLab
                                </button>
                            </div>
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="card border-0 rounded-0 p-2">
                                        <%@include file="../layout/assignedClassNavigation.jsp" %>

                                        <div class="tab-content mt-2" id="pills-tabContent">
                                            <div class="tab-pane fade show active" id="pills-overview" role="tabpanel"
                                                 aria-labelledby="overview-tab">
                                                <form class="mt-4">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Class Name</label>
                                                                <input name="name" id="name" type="text"
                                                                       class="form-control"
                                                                       value="${requestScope.assignClass.classCode}" readonly>
                                                            </div>
                                                        </div><!--end col-->

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Git URL:</label>
                                                                <input name="name" id="name2" type="text"
                                                                       class="form-control"
                                                                       value="${assignClass.gitLabId}"
                                                                       placeholder="Last Name :">
                                                            </div>
                                                        </div><!--end col-->
                                                        <div class="col-md-12">
                                                            <div class="mb-3">
                                                                <label class="form-label">Description</label>
                                                                <textarea name="descript" id="comments"
                                                                          rows="4" class="form-control"
                                                                          ></textarea>
                                                            </div>
                                                        </div>
                                                    </div><!--end row-->

                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <input type="submit" id="submit" name="send"
                                                                   class="btn btn-primary"
                                                                   value="Save changes">
                                                        </div><!--end col-->
                                                    </div><!--end row-->
                                                </form><!--end form-->
                                            </div><!--end teb pane-->
                                        </div><!--end tab content-->
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>
                    </div>
                </div><!--end container-->

                <!-- END OF BODY -->


                <!-- Footer Start -->
                <%@include file ="../layout/footer.jsp" %>
                <!--end footer-->


            </main>
            <!--End Page-content" -->
        </div>
        <!-- End of page-wrapper -->


        <!-- javascript -->
        <script src="assests/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assests/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assests/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assests/js/app.js"></script>

    </body>
</html>
