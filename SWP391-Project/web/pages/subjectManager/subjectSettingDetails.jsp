<%-- 
    Document   : SubjectSettingDetails
    Created on : Oct 15, 2023, 12:21:03 PM
    Author     : hungd
--%>

<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.SubjectDAO,model.Subject, model.User,model.IssueSetting, java.sql.ResultSet" %>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
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
        <style>
            .card {
                width: 100%;

            }
            .card-body {
                padding: 1rem;
            }
        </style>
    </head>
    <body>
        <%String mode = (String) request.getAttribute("mode");%>
        <div class="page-wrapper doctris-theme toggled">

            <!-- sidebar-wrapper  -->
            <%--<%@include file="../layout/subjectmanagerSideBar.jsp" %>--%>
            <%@include file="../layout/adminSideBar.jsp" %>

            <!-- Start Main -->
            <main class="page-content bg-light">
                <!-- NavBar -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End Navbar-->
                <%if(mode.equals("subject")){%>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Subject Setting Update</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">SUBJECT</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">SUBJECT SETTING UPDATE</li>
                                </ul>
                            </nav>
                        </div>
                        <div class="card p-4 rounded shadow border-0">
                            <div class="card-body p-1">
                                <form class="mt-4" >

                                    <div class="row">                                  
                                        <input name="setting_id" id="ass_id" type="hidden" class="form-control" value="${subjectSetting.setting_id}" readonly="">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Setting Type</label>
                                                <input pattern=".{3,20}" title="must be 3 to 20 characters" name="type" id="part" type="text" class="form-control" value="${subjectSetting.title}" required="">
                                            </div> 
                                        </div><!--end col-->

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Setting Name</label>
                                                <input pattern=".{3,20}" title="must be 3 to 20 characters" name="status" id="weight" type="text" class="form-control" placeholder="" value="${subjectSetting.status}">
                                            </div>                                                                               
                                        </div><!--end col-->                                                                                                                     
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Description of setting</label>
                                                <textarea name="Description" id="Description" rows="4" class="form-control" value="${subjectSetting.description}">${subjectSetting.description}</textarea>
                                            </div>
                                        </div>
                                    </div><!--end row-->
                                    <input type="hidden" name="subject_id" value="${subjectSetting.subject_id}">
                                    <input type="hidden" name="service" value="subjectSettingUpdate">
                                    <button type="submit" name="submit" id="update-button" type="button" value="Update" class="btn btn-primary">Confirm</button>
                                  
                                    </div>
                                </form>
                            </div>

                        </div>

                    </div>
                </div><!--end container-->
                <%}else if(mode.equals("class")){%>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Class Setting Update</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">CLASS</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">CLASS SETTING UPDATE</li>
                                </ul>
                            </nav>
                        </div>
                        <div class="card p-4 rounded shadow border-0">
                            <div class="card-body p-1">
                                <form class="mt-4" >

                                    <div class="row">                                  
                                        <input name="setting_id" id="ass_id" type="hidden" class="form-control" value="${classSetting.setting_id}" readonly="">

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Setting Type</label>
                                                <input pattern=".{3,20}" title="must be 3 to 20 characters" name="type" id="part" type="text" class="form-control" value="${classSetting.title}" required="">
                                            </div> 
                                        </div><!--end col-->

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Setting Name</label>
                                                <input pattern=".{3,20}" title="must be 3 to 20 characters" name="status" id="weight" type="text" class="form-control" placeholder="" value="${classSetting.status}">
                                            </div>                                                                               
                                        </div><!--end col-->                                                                                                                     
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Description of setting</label>
                                                <textarea name="Description" id="Description" rows="4" class="form-control" value="${classSetting.description}">${classSetting.description}</textarea>
                                            </div>
                                        </div>
                                    </div><!--end row-->
                                    <input type="hidden" name="subjectID" value="${classSetting.subject_id}">
                                    <input type="hidden" name="classID" value="${classSetting.class_id}">
                                    <input type="hidden" name="service" value="classSettingUpdate">
                                    <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updatemodal">Update</a>
                                    <div class="modal" id="updatemodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                            <div class="modal-content p-3">

                                                <div class="modal-body border-0 text-center p-2">
                                                    <h1 class="text-primary display-1"><i class="uil uil-question-circle"></i></h1>
                                                    <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                    <p>Do you really want to Update this class? This process cannot be undone.</p>
                                                </div>
                                                <div class="modal-footer border-0 align-items-center justify-content-center">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    <button type="submit" name="submit" id="update-button" type="button" value="Update" class="btn btn-primary">Confirm</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                        </div>

                    </div>
                </div><!--end container-->
                <%}else if(mode.equals("project")){%>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Project Setting Update</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">PROJECT</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">PROJECT SETTING UPDATE</li>
                                </ul>
                            </nav>
                        </div>
                        <div class="card p-4 rounded shadow border-0">
                            <div class="card-body p-1">
                                <form class="mt-4" >

                                    <div class="row">                                  
                                        <input name="setting_id" id="ass_id" type="hidden" class="form-control" value="${projectSetting.setting_id}" readonly="">

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Setting Type</label>
                                                <input pattern=".{3,20}" title="must be 3 to 20 characters" name="type" id="part" type="text" class="form-control" value="${projectSetting.title}" required="">
                                            </div> 
                                        </div><!--end col-->

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Setting Name</label>
                                                <input pattern=".{3,20}" title="must be 3 to 20 characters" name="status" id="weight" type="text" class="form-control" placeholder="" value="${projectSetting.status}">
                                            </div>                                                                               
                                        </div><!--end col-->                                                                                                                     
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Description of setting</label>
                                                <textarea name="Description" id="Description" rows="4" class="form-control" value="${projectSetting.description}">${projectSetting.description}</textarea>
                                            </div>
                                        </div>
                                    </div><!--end row-->
                                    <input type="hidden" name="projectID" value="${projectSetting.project_id}">
                                   
                                    <input type="hidden" name="service" value="projectSettingUpdate">
                                    <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updatemodal">Update</a>
                                    <div class="modal" id="updatemodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                            <div class="modal-content p-3">

                                                <div class="modal-body border-0 text-center p-2">
                                                    <h1 class="text-primary display-1"><i class="uil uil-question-circle"></i></h1>
                                                    <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                    <p>Do you really want to Update this class? This process cannot be undone.</p>
                                                </div>
                                                <div class="modal-footer border-0 align-items-center justify-content-center">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    <button type="submit" name="submit" id="update-button" type="button" value="Update" class="btn btn-primary">Confirm</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                        </div>

                    </div>
                </div><!--end container-->
                <%}%>

                <!-- Footer Start -->
                <%@include file="../layout/footer.jsp" %>
                <!--end footer-->
                <!-- End View model -->
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