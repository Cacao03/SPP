<%-- 
    Document   : assignClassMilestone
    Created on : Oct 8, 2023, 5:21:47 PM
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
        <style>
            #nav-class-issues {
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
                                    <li class="breadcrumb-item active" aria-current="page">Class Issues</li>
                                </ul>
                            </nav>
                        </div>
                        <c:if test="${not empty requestScope.fail}">
                            <div class="alert alert-warning" role="alert">
                                <span class="p-3">${requestScope.fail}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty requestScope.success}">
                            <div class="alert alert-success" role="alert">
                                <span class="p-3">${requestScope.success}</span>
                            </div>
                        </c:if>

                        <c:if test="${not empty sessionScope.fail}">
                            <div class="alert alert-warning" role="alert">
                                <span class="p-3">${sessionScope.fail}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty sessionScope.success}">
                            <div class="alert alert-success" role="alert">
                                <span class="p-3">${sessionScope.success}</span>
                            </div>
                        </c:if>
                        <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">

                            <div class="avatar-profile d-flex margin-nagative mt-n5 position-relative ps-3">

                                <div class="mt-4 ms-3 pt-3">
                                    <h3 class="mt-3">${requestScope.assignClass.classCode}</h3>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="card border-0 rounded-0 p-2">

                                        <%@include file="../layout/assignedClassNavigation.jsp" %>
                                        <div class="tab-content mt-2" id="pills-tabContent">

                                            <button class="btn btn-success mb-3" title="Sync" data-bs-toggle="modal" data-bs-target="#syncModal">
                                                <i class="uil uil-sync icons"></i> Sync with GitLab
                                            </button>
                                            <button class="btn btn-primary mb-3" title="Add" data-bs-toggle="modal" data-bs-target="#addIssueModal">
                                                Add New Issue
                                            </button>
                                            <div class="tab-pane fade show active" id="pills-overview" role="tabpanel"
                                                 aria-labelledby="overview-tab">
                                                <table id="myTable" class="table mb-0 table-hover table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <th onclick ="sortTable(1)" class="border-bottom p-3" style=" cursor: pointer">
                                                                No.</th>                                               
                                                            <th onclick ="sortTable(1)" class="border-bottom p-3" style="min-width: 180px; cursor: pointer">
                                                                Title</th>   
                                                            <th onclick ="sortTable(3)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer">
                                                                Status</th>
                                                            <th class="border-bottom p-3"style="min-width: 100px;">Actions</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${requestScope.listClassIssues}" var="issue" varStatus="status">
                                                            <tr>
                                                                <td class="p-3">
                                                                    ${status.index + 1}
                                                                </td>
                                                                <td class="p-3">
                                                                    ${issue.title}
                                                                </td>
                                                                <td class="p-3">
                                                                    ${issue.status}
                                                                </td>
                                                                <c:if test="${issue.isActive == 1}">
                                                                    <td class="p-3 text-success">Open</td>
                                                                </c:if>
                                                                <c:if test="${issue.isActive == 0}">
                                                                    <td class="p-3 text-danger">Closed</td>
                                                                </c:if>
                                                                <td>
                                                                    <a href="classManager?mode=classIssues&option=update&classId=${assignClass.classId}&mileId=${issue.id}"
                                                                       class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-eye"></i></a>  
                                                                        <c:choose>
                                                                            <c:when test="${milestone.isActive == 1}">
                                                                            <a href="classManager?mode=classIssues&option=changeStatus&classId=${assignClass.classId}&issueId=${issue.id}&status=0" class="btn btn-icon btn-pills btn-soft-danger" title="Inactive"  data-bs-toggle="modal" data-bs-target="#confirmationModal">
                                                                                <i class="uil uil-times icons"></i>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="classManager?mode=classIssues&option=changeStatus&classId=${assignClass.classId}&issueId=${issue.id}&status=1" class="btn btn-icon btn-pills btn-soft-success" title="Active" data-bs-toggle="modal" data-bs-target="#confirmationModal">
                                                                                <i class="uil uil-check icons"></i>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>

                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>

                                                <div class="row text-center">
                                                    <div class="col-12 mt-4">
                                                        <div class="d-md-flex align-items-center text-center justify-content-between">
                                                            <span class="text-muted me-3"></span>
                                                            <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                                                <c:forEach begin="1" end="${endP}" var="i">
                                                                    <li class="page-item"><a class="page-link" href="classManager?mode=classIssues&classId=${assignClass.classId}&index=${i}">${i}</a></li>         
                                                                    </c:forEach>
                                                            </ul>
                                                        </div>
                                                    </div><!--end col-->
                                                </div>	
                                            </div><!--end teb pane-->
                                        </div><!--end tab content-->
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>
                    </div>
                </div><!--end container-->
                <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-labelledby="confirmationModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmationModalLabel">Confirmation</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to save changes?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" id="confirmAction">Confirm</button>
                            </div>
                        </div>
                    </div>
                </div>

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
        <script>
                                                                document.getElementById("SyncAction").addEventListener("click", function () {
                                                                    document.getElementById("preloader").style.display = "block";
                                                                    document.getElementById("syncForm").submit();
                                                                });
                                                                document.addEventListener('DOMContentLoaded', function () {
                                                                    $('#confirmationModal').on('show.bs.modal', function (event) {
                                                                        var button = $(event.relatedTarget); // Button that triggered the modal
                                                                        var modal = $(this);

                                                                        // Set the "Confirm" button's click event
                                                                        modal.find('#confirmAction').on('click', function () {
                                                                            // Perform the action here, e.g., submit a form
                                                                            // Replace the following line with your action
                                                                            window.location.href = button.attr('href');
                                                                        });
                                                                    });
                                                                });

        </script>
    </body>
</html>
