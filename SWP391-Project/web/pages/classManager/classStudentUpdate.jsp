<%-- 
    Document   : milestoneUpdate
    Created on : Oct 8, 2023, 8:43:23 PM
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assests/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
        <style>
            #nav-class-milestones {
                background-color: #007bff; /* Change to your desired background color */
                color: #fff !important; /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
            }
            .form-check.form-switch {
                width: 40px;  /* Adjust width as needed */
                height: 28px; /* Adjust height as needed */
            }

            .form-check-input {
                width: 30px;  /* Adjust width as needed */
                height: 15px; /* Adjust height as needed */
                transform: scale(1.5);  /* Use the scale property to increase size */
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
                            <h3 class="mb-0">Class Student Details</h3>
                        </div>
                        <c:if test="${not empty requestScope.fail}">
                            <div class="alert alert-warning" role="alert">
                                <span class="p-3">${requestScope.fail}</span>
                            </div>
                        </c:if>
                        <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="card border-0 rounded-0 p-2">

                                        <div class="tab-content mt-2" id="pills-tabContent">
                                            <div class="tab-pane fade show active" id="pills-overview" role="tabpanel"
                                                 aria-labelledby="overview-tab">
                                                <form action="classManager" method="post">
                                                    <input type="hidden" name="stId" value="${requestScope.classSt.id}">
                                                    <input type="hidden" name="classId" value="${requestScope.classSt.classId}">
                                                    <div class="mb-3">
                                                        <label class="form-label">Student:</label>
                                                        <input name="classStudent" id="classStudent" type="text"
                                                               class="form-control" value="${classSt.studentName}"
                                                               readonly>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Group:</label>
                                                        <input name="classGroup" id="classGroup" type="text"
                                                               class="form-control" value="${requestScope.classSt.groupName}"
                                                               readonly>
                                                    </div>
                                                    <div class="mb-3 d-flex">
                                                        <label class="form-label">Status:</label>
                                                        <c:if test="${classSt.isActive == 1}">
                                                            <div class="form-check form-switch" style="margin-left: 12px;">
                                                                <input class="form-check-input" name="status" value="1" type="checkbox" style=" cursor: pointer" role="switch" id="flexSwitchCheckChecked" checked>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${classSt.isActive == 0}">
                                                            <div class="form-check form-switch" style="margin-left: 12px; cursor: pointer">
                                                                <input class="form-check-input" name="status" value="1" type="checkbox" style=" cursor: pointer" role="switch" id="flexSwitchCheckChecked" >
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Description:</label>
                                                            <textarea name="descript" id="descript"
                                                                      rows="4" class="form-control"
                                                                      ><c:if test="${requestScope.classSt.note != null}">
                                                                    ${requestScope.classSt.note}
                                                                </c:if></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <input type="submit" id="submit" name="send"
                                                                   class="btn btn-primary"
                                                                   value="Save changes">
                                                            <input type="submit" id="submit" name="send"
                                                                   class="btn btn-danger"
                                                                   value="Cancel">
                                                        </div><!--end col-->
                                                    </div><!--end row-->
                                                </form>
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