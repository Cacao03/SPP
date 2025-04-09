<%-- 
    Document   : userUpdate
    Created on : Sep 20, 2023, 11:24:27 PM
    Author     : FPT
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.ClassDAO,model.Class,model.User,model.Setting,model.Subject,java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
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
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assests/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>  
        <style>
            #nav-class-setting {
                background-color: #007bff; /* Change to your desired background color */
                color: #fff !important; /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
            }
        </style>
    </head>
    <body>
        <%
            Vector<Class> vector = (Vector<Class>) request.getAttribute("data2");
            Class cl = vector.get(0);
            ResultSet Rs = (ResultSet) request.getAttribute("Rs");
            ResultSet Rs2 = (ResultSet) request.getAttribute("Rs2");
            ResultSet Rs3 = (ResultSet) request.getAttribute("Rs3");
        %>
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
            <%--<%@include file="../layout/subjectManagerSidebar.jsp" %>--%>
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
                            <h5 class="mb-0">Class Details</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="ClassController">Class List</a></li>
                                    <li class="breadcrumb-item active"><a href="#">Class Details</a></li>
                                </ul>
                            </nav>
                        </div>

                        <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">

                            <div class="ms-3 pt-3">
                                <h3 class="mb-0"><%=cl.getClassCode()%> </h3>
                            </div>
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="card border-0 rounded-0 p-4">
                                        <%@include file="../layout/assignedClassNavigation.jsp" %>


                                        <div class="tab-content p-4" id="pills-tabContent">
                                            <div class="tab-pane fade show active" id="pills-overview" role="tabpanel" aria-labelledby="overview-tab">
                                                
                                                <div class="card p-4 rounded shadow border-0">
                                                    <% if (cl.getStatus() != 2) {%>
                                                    <form action="ClassController" id="update-form" enctype="multipart/form-data">                     
                                                        <input type ="hidden" name ="service" value ="updateClass">
                                                        <%} else {%>
                                                        <form  inert action="ClassController"  enctype="multipart/form-data">                     
                                                            <input type ="hidden" name ="service" value ="updateClass">
                                                            <%}%>

                                                            <div class="row" class="mt-4">                       
                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">

                                                                        <input name="cid" id="cid" type="hidden" value ="<%=cl.getClassId()%>" readonly class="form-control" placeholder="Class Id:">

                                                                    </c:when>
                                                                    <c:otherwise>

                                                                        <input style="background-color: #E9ECEF; opacity:0.7" name="cid" id="cid" type="hidden" value ="<%=cl.getClassId()%>" readonly class="form-control" placeholder="Class Id:">

                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="code">Class Code</label>
                                                                                <input name="code" id="code" type="text" value ="<%=cl.getClassCode()%>" required class="form-control" placeholder="Class code:">                                                                               
                                                                            <span id="error"></span>
                                                                            </div>                     
                                                                        </div><!--end col-->
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="code">Class Code</label>
                                                                                <input style="background-color: #E9ECEF; opacity:0.7" name="code" id="code" type="text" value ="<%=cl.getClassCode()%>" readonly class="form-control" placeholder="Class code:">                                 
                                                                            </div>
                                                                        </div><!--end col-->
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                       
                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="semester">Semester</label>
                                                                                <select class="form-select select2input" name="semester">
                                                                                    <%while (Rs.next()) {
                                                                                    %>
                                                                                    <option value="<%=Rs.getInt(1)%>" <%=Rs.getInt(1) == cl.getSemesterId() ? "selected" : ""%>><%=Rs.getString(2)%></option>

                                                                                    <%}%>   
                                                                                </select>
                                                                            </div> 
                                                                        </div><!--end col-->
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="semester">Semester</label>
                                                                                <select style="opacity:0.7" class="form-select select2input" name="semester" id="semester">
                                                                                    <%while (Rs.next()) {
                                                                                    %>
                                                                                    <option value="<%=Rs.getInt(1)%>" <%=Rs.getInt(1) == cl.getSemesterId() ? "selected" : ""%>><%=Rs.getString(2)%></option>

                                                                                    <%}%>   
                                                                                </select>
                                                                            </div> 
                                                                        </div><!--end col-->
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="subject">Subject</label>
                                                                                <select class="form-select select2input" name="subject">
                                                                                    <%while (Rs3.next()) {
                                                                                    %>
                                                                                    <option value="<%=Rs3.getInt(1)%>" <%=Rs3.getInt(1) == cl.getSubjectId() ? "selected" : ""%>><%=Rs3.getString(2)%></option>

                                                                                    <%}%>   
                                                                                </select>
                                                                            </div>                                                                               
                                                                        </div><!--end col-->
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="subject">Subject</label>
                                                                                <select style="opacity:0.7" class="form-select select2input" name="subject" id="subject">
                                                                                    <%while (Rs3.next()) {
                                                                                    %>
                                                                                    <option value="<%=Rs3.getInt(1)%>" <%=Rs3.getInt(1) == cl.getSubjectId() ? "selected" : ""%>><%=Rs3.getString(2)%></option>

                                                                                    <%}%>   
                                                                                </select>
                                                                            </div>                                                                               
                                                                        </div><!--end col-->
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="manager">Class Manager</label>

                                                                                <select class="form-select select2input" name="manager" >
                                                                                    <%while (Rs2.next()) {
                                                                                    %>
                                                                                    <option value="<%=Rs2.getInt(1)%>" <%=Rs2.getInt(1) == cl.getManagerId() ? "selected" : ""%>><%=Rs2.getString(2)%></option>

                                                                                    <%}%>   
                                                                                </select>
                                                                            </div>
                                                                        </div><!--end col-->
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="col-md-6">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="manager">Class Manager</label>

                                                                                <select style="opacity:0.7" class="form-select select2input" name="manager" id="manager">
                                                                                    <%while (Rs2.next()) {
                                                                                    %>
                                                                                    <option value="<%=Rs2.getInt(1)%>" <%=Rs2.getInt(1) == cl.getManagerId() ? "selected" : ""%>><%=Rs2.getString(2)%></option>

                                                                                    <%}%>   
                                                                                </select>
                                                                            </div>
                                                                        </div><!--end col-->
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <div class="col-md-6">
                                                                    <div class="mb-3">
                                                                        <label class="form-label" for="gitlab">Gitlab Url</label>

                                                                        <input name="gitlab" id="gitlab" type="text" value ="<%=cl.getGitlabId()%>" class="form-control" placeholder="Gitlab url:">
                                                                    </div>
                                                                </div><!--end col-->


                                                                <div class="col-md-6">
                                                                    <div class="mb-3">
                                                                        <label class="form-label" for="acctoken">Access Token</label>
                                                                        <input name="acctoken" id="acctoken" type="password" value ="<%=cl.getAccessToken()%>" class="form-control" placeholder="Access Token:">
                                                                    </div>
                                                                </div><!--end col-->

                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">
                                                                        <%if (cl.getStatus() == 0) {%>
                                                                        <div class="col-md-6" style="display:grid">
                                                                            <div class="mb-3">
                                                                                <div class="row ms-5 mt-2">
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Pending</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="0" checked>
                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Started</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="1">

                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Closed</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="2">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div><!--end col-->
                                                                        <%} else if (cl.getStatus() == 1) {%>
                                                                        <div class="col-md-6" style="display:grid">
                                                                            <div class="mb-3">
                                                                                <div class="row ms-5 mt-2">
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Pending</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="0">
                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Started</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="1" checked>

                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Closed</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="2">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div><!--end col-->

                                                                        <%} else {%>
                                                                        <div class="col-md-6" style="display:grid">
                                                                            <div class="mb-3">
                                                                                <div class="row ms-5 mt-2">
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Pending</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="0">
                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Started</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="1">

                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Closed</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="2" checked>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div><!--end col-->
                                                                        <%}%>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <%if (cl.getStatus() == 0) {%>
                                                                        <div class="col-md-6" style="display:grid">
                                                                            <div class="mb-3">
                                                                                <div class="row ms-5 mt-2">
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Pending</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="0" checked>
                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Started</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="1" disabled>

                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Closed</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="2" disabled>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div><!--end col-->
                                                                        <%} else if (cl.getStatus() == 1) {%>
                                                                        <div class="col-md-6" style="display:grid">
                                                                            <div class="mb-3">
                                                                                <div class="row ms-5 mt-2">
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Pending</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="0" disabled>
                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Started</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="1" checked>

                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Closed</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="2" disabled>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div><!--end col-->

                                                                        <%} else {%>
                                                                        <div class="col-md-6" style="display:grid">
                                                                            <div class="mb-3">
                                                                                <div class="row ms-5 mt-2">
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Pending</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="0" disabled>
                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Started</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="1" disabled>

                                                                                    </div>
                                                                                    <div class="form-check col-md-4">
                                                                                        <label class="form-check-label">Closed</label>
                                                                                        <input class="form-check-input" type="radio" name="status" value="2" checked>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div><!--end col-->
                                                                        <%}%>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">

                                                                        <div class="col-md-12">
                                                                            <div class="mb-3">
                                                                                <label class="form-label" for="details">Details</label>
                                                                                <textarea name="details" id="details" rows="3" class="form-control" ><%=cl.getClassDetails() == null ? "" : cl.getClassDetails()%></textarea>
                                                                            </div>
                                                                        </div>
                                                                    </div><!--end row-->
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label" for="details">Details</label>
                                                                            <textarea style="background-color: #E9ECEF; opacity:0.7" readonly name="details" id="details" rows="3" class="form-control" ><%=cl.getClassDetails() == null ? "" : cl.getClassDetails()%></textarea>
                                                                        </div>
                                                                    </div>
                                                                    </div><!--end row-->
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <button type="submit" name="submit3" value="" class="btn btn-primary">Confirm Changes</button>                                                                                       
                                                        </form>
                                                </div>            
                                            </div> <!--end panel-->
                                            <div class="modal fade" id="syncModal" tabindex="-1" role="dialog" aria-labelledby="syncModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered" role="document">
                                                    <div class="modal-content">
                                                        <!--                            <div class="modal-header">
                                                                                        <h5 class="modal-title" id="syncModalLabel">Sync with GitLab</h5>
                                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                                                    </div>-->
                                                        <div class="p-2">
                                                            <form id="syncForm" action="gitsync" method="post">
                                                                <input type="hidden" name="classId" value="${requestScope.assignClass.classId}">
                                                                <input type="hidden" name="mode" value="setting">
                                                                <label class="form-label">Gitlab URL:</label>
                                                                <input name="gitUrl" id="gitUrl" type="text"
                                                                       class="form-control" placeholder="Enter your Gitlab URL here..."
                                                                       value="${requestScope.assignClass.gitLabId}"
                                                                       required>
                                                                <label class="form-label">Access Token:</label>
                                                                <input name="accessToken" id="accessToken" type="text"
                                                                       class="form-control" placeholder="Enter your Access Token here..."
                                                                       value="<%=cl.getAccessToken()%>"
                                                                       required>
                                                            </form>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                            <button type="button" class="btn btn-success" id="SyncAction">Submit</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>  
                                    </div><!--end row-->
                                </div><!--end teb pane-->
                            </div><!--end tab content-->
                        </div>
                    </div><!--end row-->
                    <!-- Footer Start -->
                    <%@include file="../layout/footer.jsp" %>
                    <!--end footer-->
            </main>
        </div>
    </div>
    </body>



    <!-- javascript -->
    <script src="assests/js/jquery.min.js"></script>
    <script src="assests/js/bootstrap.bundle.min.js"></script>
    <!-- simplebar -->
    <script src="assests/js/simplebar.min.js"></script>
    <!-- Select2 -->
    <script src="assests/js/select2.min.js"></script>
    <script src="assests/js/select2.init.js"></script>
    <!-- Icons -->
    <script src="assests/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="assests/js/app.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
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
    <script>
        $('#semester').prop('disabled', true);
        $('#subject').prop('disabled', true);
        $('#manager').prop('disabled', true);
        $('#update-form').on('submit', function () {
            $('#semester').prop('disabled', false);
            $('#subject').prop('disabled', false);
            $('#manager').prop('disabled', false);
        });
    </script>
    <style>
        /* Add CSS for the toast */
        #toast {
            display: none;
            position: fixed;
            top: 150px;
            right: 50px;
            background-color: #4CAF50;
            color: #fff;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
        }
    </style>


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


    <%-- JavaScript code to check URL parameters and display the toast message --%>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            var urlParams = new URLSearchParams(window.location.search);
            var isSuccess = urlParams.get("success");
            var error = document.getElementById("error");
            if (isSuccess === "true") {
                displayToast("Class updated successfully!", true);
            } else if (isSuccess === "false") {   
                error.textContent="Class code is existed!";
                error.style.color = "red";
            }
        });
    </script>
</body>

</html>

