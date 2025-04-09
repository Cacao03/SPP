<%-- 
    Document   : userUpdate
    Created on : Sep 20, 2023, 11:24:27 PM
    Author     : FPT
--%>

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
          Vector<String> vectorB =(Vector<String>)request.getAttribute("dataB");
        //ResultSet rsSub=(ResultSet)request.getAttribute("rsSub");
        ResultSet rs1 = (ResultSet)request.getAttribute("Rs1");
        ResultSet rs=(ResultSet)request.getAttribute("rsSub");
        String subject_name = (String)request.getAttribute("subject_name");
        String subject_code = (String)request.getAttribute("subject_code");
          
                        %>



                        <div style="border-radius: 7px"class="container mt-4 bg-white shadow p-4">
                            <h1 class="mb-4">Add Subject</h1>

                            <% if (request.getAttribute("noti") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("noti") %>
                            </div>
                            <% } %>
                            <form action="SubjectController">
                                <input type="hidden" name="service" value="insertSubject">
                                <div class="mb-3">
                                    <label for="subject_name" class="form-label">Subject Name<span class="text-danger"> *</span></label>
                                    <% if (subject_name != null) { %>
                                    <input type="text" class="form-control" id="subject_name" name="subject_name" value="<%=subject_name%>" required>
                                    <% } else {%>
                                    <input type="text" class="form-control" id="subject_name" name="subject_name" required>
                                    <% } %>
                                </div>

                                <div class="mb-3">
                                    <label for="subject_code" class="form-label">Subject Code<span class="text-danger"> *</span></label>
                                    <% if (subject_code != null) { %>
                                    <input type="text" class="form-control" id="subject_code" name="subject_code" value="<%=subject_code%>" required>
                                    <% } else {%>
                                    <input type="text" class="form-control" id="subject_code" name="subject_code" required>
                                    <% } %>
                                </div>

                                <div class="mb-3">
                                    <label for="manager" class="form-label">Manager<span class="text-danger"> *</span></label>
                                    <select class="form-select" id="manager" name="manager" required>

                                        <%while(rs1.next()){%>
                                        <option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>

                                        <%}%>
                                    </select>
                                </div>
                                <div class="col-md-6" style="display:grid">
                                    <div class="mb-3">
                                        <label class="form-label" for="status">Status</label>

                                        <div class="row ms-3">
                                            <div class="form-check col-md-4">
                                                <label class="form-check-label" >Active</label>
                                                <input class="form-check-input" type="radio" name="status" value="1" checked>
                                            </div>
                                            <div class="form-check col-md-4">
                                                <label class="form-check-label">In Active</label>
                                                <input class="form-check-input" type="radio" name="status" value="0">
                                            </div>
                                        </div>
                                    </div>
                                </div><!--end col-->


                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label class="form-label" for="description">Description</label>
                                        <textarea name="description" id="details" rows="3" class="form-control" placeholder="Description..."></textarea>
                                    </div>
                                </div>
                                <button style="margin-bottom: 20px" type="submit" name="submit" class="btn btn-primary" value="">Save Changes</button>
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