<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dal.SubjectDAO,model.Subject, model.User, model.IssueSetting, java.sql.ResultSet" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
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
        <!-- Icons -->
        <link href="assests/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assests/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="assests/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            .table-detail {
                border-collapse: collapse;
                width: 100%;
            }

            .table-detail th,
            .table-detail td {
                border: 1px solid #000;
                /* Thêm viền cho từng cột */
                padding: 8px;
                text-align: left;
            }

            .table-detail th:last-child,
            .table-detail td:last-child {
                text-align: left;
                /* Đặt chú ý cho cột cuối cùng */
            }

            .card {
                width: 100%;
                max-width: 1500px;
                margin: 0 auto;
            }

            .card-body {
                padding: 1rem;
            }
            #nav-subject-general {
                background-color: #007bff; /* Change to your desired background color */
                color: #fff !important; /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
            }
            #toast {
                display: none;
                position: fixed;
                top: 150px;
                right: 60px;
                background-color: #4CAF50;
                color: #fff;
                padding: 15px;
                border-radius: 5px;
                text-align: center;
            }
            .horizontal-radio {
                display: inline-block;
                margin-right: 20px; /* Thay đổi khoảng cách giữa hai ô radio nếu cần */
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

        <!-- page-wrapper -->
        <div class="page-wrapper doctris-theme toggled">

            <!-- sidebar-wrapper  -->
            <%--<%@include file="../layout/subjectManagerSideBar.jsp" %>--%>
            <%@include file="../layout/adminSideBar.jsp" %>

            <!-- Start Main -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End of HEADER -->

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Subject Details</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="ClassController">Subject
                                            List</a></li>
                                    <li class="breadcrumb-item active"><a href="#">Subject
                                            Details</a></li>
                                </ul>
                            </nav>
                        </div>


                        <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">

                            <div class="ms-3 pt-3">
                                <c:forEach items="${listDetails}" var="sd">
                                    <h3 class="mb-0">${sd.subjectCode} </h3>
                                </c:forEach>
                            </div>
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="card border-0 rounded-0 p-4">


                                        <!--Tab list-->
                                        <%@include file="../layout/subjectDetailNavigation.jsp"
                                                   %>
                                        <!-- End Tab List -->
                                        <% String successMessage=(String)
                                            session.getAttribute("successMessage"); if
                                            (successMessage !=null) {
                                            request.setAttribute("successMessage",
                                            successMessage);
                                            session.removeAttribute("successMessage"); } %>

                                        <!--Tab Content-->
                                        <div class="tab-content p-4"
                                             id="pills-tabContent">
                                            <!--Tab 1-->
                                            <div class="tab-pane fade show active"
                                                 id="pills-overview" role="tabpanel"
                                                 aria-labelledby="overview-tab">
                                                <!--Tab 1 content-->
                                                <!-- JavaScript function to display toast -->
                                                <script type="text/javascript">
                                                    function displayToast(message, isSuccess) {
                                                        var toast = document.getElementById("toast");
                                                        toast.innerHTML = message;
                                                        if (isSuccess) {
                                                            toast.style.backgroundColor = "#4CAF50";  // Green color for success
                                                        } else {
                                                            toast.style.backgroundColor = "#F44336";  // Red color for failure
                                                        }
                                                        toast.style.display = "block";
                                                        setTimeout(function () {
                                                            toast.style.display = "none";
                                                        }, 3000);  // Display the toast for 3 seconds
                                                    }
                                                </script>

                                                <!-- HTML element for the toast -->
                                                <div id="toast"></div>


                                                <%-- JavaScript code to check URL
                                                    parameters and display the toast
                                                    message --%>
                                                <script type="text/javascript">
                                                    document.addEventListener("DOMContentLoaded", function () {
                                                        var urlParams = new URLSearchParams(window.location.search);
                                                        var isSuccess = urlParams.get("success");

                                                        if (isSuccess === "true") {
                                                            displayToast("updated successfully!", true);
                                                        } else if (isSuccess === "false") {
                                                            displayToast("Failed to update!", false);
                                                        }
                                                    });
                                                </script>
                                                <form class="mt-4">
                                                    <div class="row">
                                                        <input name="subjectID" type="hidden" class="form-control" value="${listSubject.subjectId}">

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Subject Name</label>
                                                                <input pattern=".{3,20}" title="must be 3 to 20 characters" name="subjectName" id="part" type="text" class="form-control" value="${listSubject.subjectName}" required="">
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Subject Code</label>
                                                                <input pattern=".{3,20}" title="must be 3 to 20 characters" name="subjectCode" id="weight" type="text" class="form-control" placeholder="" value="${listSubject.subjectCode}">
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Min grade to pass</label>
                                                                <input name="minGrade" id="weight" type="text" class="form-control" placeholder="" value="${listSubject.passGrade}">
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="mb-3">

                                                                <label class="form-label">Status:</label><br>
                                                                <%if(role==15){%>
                                                                <c:choose>
                                                                    <c:when test="${listSubject.isActive==1}">
                                                                        <div class="form-check horizontal-radio">
                                                                            <label class="form-check-label">
                                                                                Active
                                                                            </label>
                                                                            <input  <%if(role==15){%> disabled="" <%}%>class="form-check-input" type="radio" value="1" checked>
                                                                            <input class="form-check-input" type="hidden" name="status" value="1" checked>
                                                                        </div>
                                                                        <div class="form-check horizontal-radio">
                                                                            <label class="form-check-label">
                                                                                Inactive
                                                                            </label>
                                                                            <input <%if(role==15){%> disabled="" <%}%> class="form-check-input" type="radio" value="0">
                                                                            <input class="form-check-input" type="hidden" name="status" value="0">
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="form-check horizontal-radio">
                                                                            <label class="form-check-label">
                                                                                Active
                                                                            </label>
                                                                            <input <%if(role==15){%> disabled="" <%}%> class="form-check-input" type="radio" value="1">
                                                                            <input class="form-check-input" type="hidden" name="status" value="1">

                                                                        </div>
                                                                        <div class="form-check horizontal-radio">
                                                                            <label class="form-check-label">
                                                                                Inactive
                                                                            </label>
                                                                            <input <%if(role==15){%> disabled="" <%}%> class="form-check-input" type="radio" value="0" checked>
                                                                            <input class="form-check-input" type="hidden" name="status" value="0">
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <%}%>
                                                                <%if(role ==14){%>
                                                                <c:choose>
                                                                    <c:when test="${listSubject.isActive==1}">
                                                                        <div class="form-check horizontal-radio">
                                                                            <label class="form-check-label">
                                                                                Active
                                                                            </label>
                                                                            <input class="form-check-input" type="radio" name="status" value="1" checked>
                                                                        </div>
                                                                        <div class="form-check horizontal-radio">
                                                                            <label class="form-check-label">
                                                                                Inactive
                                                                            </label>
                                                                            <input class="form-check-input" type="radio" name="status" value="0">
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="form-check horizontal-radio">
                                                                            <label class="form-check-label">
                                                                                Active
                                                                            </label>
                                                                            <input class="form-check-input" type="radio" name="status" value="1">
                                                                        </div>
                                                                        <div class="form-check horizontal-radio">
                                                                            <label class="form-check-label">
                                                                                Inactive
                                                                            </label>
                                                                            <input class="form-check-input" type="radio" name="status" value="0" checked>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <%}%>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="mb-3">
                                                                <label class="form-label">Subject Description</label>
                                                                <textarea name="description" id="Description" rows="3" class="form-control" value="${listSubject.description}">${listSubject.description}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <input type="hidden" name="subject_id" value="${listSubject.subjectId}">
                                                    <input type="hidden" name="service" value="subjectDetailUpdate">
                                                    <button type="submit" name="submit" id="update-button" type="button" value="Update" class="btn btn-primary">Confirm</button>

                                                </form>

                                                <!--End Tab 1 content-->
                                            </div>
                                            <!--end tab 1-->
                                        </div>
                                        <!--End tab content-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--end of main-->
                    <!-- Footer Start -->
                    <%@include file="../layout/footer.jsp" %>
                    <!--end footer-->
                </div>
            </main>
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