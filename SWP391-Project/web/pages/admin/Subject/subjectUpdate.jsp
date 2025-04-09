<%-- 
    Document   : userUpdate
    Created on : Sep 20, 2023, 11:24:27 PM
    Author     : FPT
--%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.User, model.Subject"%>
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

        <style>
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
        </style>
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
            <%@include file="../../layout/adminSideBar.jsp" %>

            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light" >
                <!-- HEADER -->
                <%@include file="../../layout/navbar.jsp" %>
                <!-- End of HEADER -->
                <div class="container-fluid" style="max-width: 850px">
                    <div class="layout-specing">
                        <% 
          Vector<Subject> vector =(Vector<Subject>)request.getAttribute("dataS");
            Subject sub=vector.get(0);
            ResultSet rs1 = (ResultSet)request.getAttribute("Rs1");
            
                        %>
                        <div style="border-radius: 7px" class="container mt-4 bg-white shadow">
                            <h1 class="mb-4">Edit Subject</h1>
                            <% if (request.getAttribute("noti") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("noti") %>
                            </div>
                            <% } %>
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

                            <div id="toast"></div>

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
                            <form action="SubjectController">
                                <input type="hidden" name="service" value="updateSubject">
                                <div class="mb-3">

                                    <input type="hidden" class="form-control" id="subject_id" readonly name="subject_id" value="<%=sub.getSubjectId()%>" required="">
                                </div>
                                <div class="mb-3">
                                    <label for="subject_name" class="form-label">Subject Code<span class="text-danger"> *</span></label>
                                    <input type="text" class="form-control" id="subject_name" name="subject_code" value="<%=sub.getSubjectCode()%>" required>
                                </div>

                                <div class="row mb-3">
                                    <div class="col">
                                        <label for="subject_code" class="form-label">Subject Name<span class="text-danger"> *</span></label>
                                        <input type="text" class="form-control" id="subject_code" name="subject_name" value="<%=sub.getSubjectName()%>" required>
                                    </div>

                                    <div class="col">
                                        <label for="manager" class="form-label">Manager<span class="text-danger"> *</span></label>
                                        <select class="form-select" id="manager" name="manager" required>
                                            <%while(rs1.next()){
                                                if(rs1.getInt(3)==15){%>
                                            <option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
                                            <%}}%>
                                        </select>
                                    </div>

                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="status">Status:</label>
                                    <%if (sub.getIsActive() == 0) {%>
                                    <div class="col-md-6" style="display:grid">
                                        <div class="mb-3">
                                            <div class="row ms-2 mt-2">
                                                <div class="form-check col-md-4">
                                                    <label class="form-check-label">In Active</label>
                                                    <input class="form-check-input" type="radio" name="status" value="0" checked>
                                                </div>
                                                <div class="form-check col-md-4">
                                                    <label class="form-check-label">Active</label>
                                                    <input class="form-check-input" type="radio" name="status" value="1">
                                                </div>
                                            </div>
                                        </div>
                                    </div><!--end col-->
                                    <%} else if (sub.getIsActive() == 1) {%>
                                    <div class="col-md-6"">
                                        <div class="mb-3">
                                            <div class="row ms-2 mt-2">
                                                <div class="form-check col-md-4">
                                                    <label class="form-check-label">In Active</label>
                                                    <input class="form-check-input" type="radio" name="status" value="0">
                                                </div>
                                                <div class="form-check col-md-4">
                                                    <label class="form-check-label">Active</label>
                                                    <input class="form-check-input" type="radio" name="status" value="1" checked>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!--end col-->
                                    <%}%>
                                </div>
                                <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Description</label>
                                                <textarea name="Description" id="Description" rows="3" class="form-control" value="${listSubject.description}">${listSubject.description}</textarea>
                                            </div>
                                        </div>
                                <button style="margin-bottom: 20px" type="submit" name="submit" class="btn btn-primary" value="">Save change</button>
                            </form>
                        </div>



                    </div>
                </div>

                <!-- Footer Start -->
                <%@include file ="../../layout/footer.jsp" %>
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

        <!-- Bao gồm thư viện Bootstrap JavaScript và jQuery (nếu cần) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </body>

</html>