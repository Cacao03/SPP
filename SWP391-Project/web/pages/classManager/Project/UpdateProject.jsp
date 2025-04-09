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


                        <div class="row">
                            <div class="bg-white component-wrapper border-0 rounded shadow" >
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0"> Project details </h5>
                                </div>

                                <div class="p-4">
                                    <%
                                        int status = (int) request.getAttribute("status");
                                        String currentMentorName = (String) request.getAttribute("currentMentorName");
                                        String currentCo_MentorName = (String) request.getAttribute("currentCo_MentorName");
                                        ResultSet rsClassCode = (ResultSet) request.getAttribute("rsClassCode");
                                        ResultSet rsAllMentorName = (ResultSet) request.getAttribute("rsAllMentorName");
                                        ResultSet rsAllCo_MentorName = (ResultSet) request.getAttribute("rsAllCo_MentorName");
                                        ResultSet rsProject = (ResultSet) request.getAttribute("rsProject");
                                        while (rsProject.next()) {
                                    %>
                                    <%@include file="../../layout/projectNavigation.jsp" %>
                                    <div class="row pt-2">
                                        <div class="col-12">
                                            <div class="tab-content" id="pills-tabContent">

                                                <form class="mt-2" id="updateForm">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Class Code:</label>
                                                                <select name="class_id" class="form-select" id="">
                                                                    <%while (rsClassCode.next()) {%>
                                                                    <option value="<%=rsClassCode.getInt("class_id")%>" selected><%=rsClassCode.getString("class_code")%></option>
                                                                    <%}%>
                                                                </select>

                                                            </div>
                                                        </div><!--end col-->

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Status:</label>
                                                                <input name="Status" readonly="" type="hidden" class="form-control" value="<%=rsProject.getString("status")%>">
                                                                <%if (rsProject.getString("status").equals("1")) {%>
                                                                <input  readonly="" type="text" class="form-control" value="Active">
                                                                <%} else {%>
                                                                <input  readonly="" type="text" class="form-control" value="Inactive">
                                                                <%}%>
                                                            </div>
                                                        </div><!--end col-->

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Group Name:</label>
                                                                <input <%if (status == 1) {%> readonly="" <%}%>  name="group_name" type="text" pattern=".{2,20}" title="Between 1 to 20 characters" class="form-control" value="<%=rsProject.getString("group_name")%>">
                                                            </div> 
                                                        </div><!--end col-->

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Project Code:</label>
                                                                <input <%if (status == 1) {%> readonly="" <%}%> name="project_code" pattern=".{3,10}" title="Between 3 to 10 characters" type="text" class="form-control" value="<%=rsProject.getString("project_code")%>">
                                                            </div>                                                                               
                                                        </div><!--end col-->

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">English Name:</label>
                                                                <input <%if (status == 1) {%> readonly="" <%}%> name="en_name" pattern=".{5,30}" title="Between 5 to 30 characters" type="text" class="form-control" value="<%=rsProject.getString("project_en_name")%>">
                                                            </div> 
                                                        </div><!--end col-->

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Vietnamese Name:</label>
                                                                <input  <%if (status == 1) {%> readonly="" <%}%> name="vi_name" pattern=".{5,30}" title="Between 5 to 30 characters" type="text" class="form-control" value="<%=rsProject.getString("project_vi_name")%>">
                                                            </div>                                                                               
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Access token:</label>
                                                                <input  <%if (status == 1) {%> readonly="" <%}%> name="access_token"  type="password" class="form-control" value="<%=rsProject.getString("access_token")%>">
                                                            </div>                                                                               
                                                        </div>
                                                            <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Url:</label>
                                                                <input  <%if (status == 1) {%> readonly="" <%}%> name="url"  type="text" class="form-control" value="<%=rsProject.getString("url")%>">
                                                            </div>                                                                               
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Mentor:</label>
                                                                <select name="Mentor_id" class="form-select" id="">
                                                                    <option value="<%=rsProject.getString("mentor_id")%>" hidden="" selected><%=currentMentorName%></option>
                                                                    <%if (status != 1 && role != 18) {%> 
                                                                    <%while (rsAllMentorName.next()) {%>
                                                                    <option value="<%=rsAllMentorName.getInt("user_id")%>"><%=rsAllMentorName.getString("full_name")%></option>
                                                                    <%}%>
                                                                    <%}%>
                                                                </select>
                                                            </div> 
                                                        </div><!--end col-->

                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Co-mentor:</label>
                                                                <select name="Co-mentor_id" class="form-select" id="">
                                                                    <option value="<%=rsProject.getString("co_mentor_id")%>" hidden="" selected><%=currentCo_MentorName%></option>
                                                                    <%if (status != 1 && role != 18) {%> 
                                                                    <%while (rsAllCo_MentorName.next()) {%>
                                                                    <option value="<%=rsAllCo_MentorName.getInt("user_id")%>"><%=rsAllCo_MentorName.getString("full_name")%></option>
                                                                    <%}%>
                                                                    <%}%>

                                                                </select>
                                                            </div>                                                                               
                                                        </div>

                                                        <div class="col-md-6">

                                                        </div>

                                                        <div class="col-md-12">
                                                            <div class="mb-3">
                                                                <label class="form-label">Description: </label>
                                                                <textarea name="project_descript" id="comments" rows="4" class="form-control" ><%=rsProject.getString("project_descript")%></textarea>
                                                            </div>
                                                        </div>
                                                    </div><!--end row-->

                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <input type="hidden" name="project_id" class="btn btn-primary" value="<%=rsProject.getString(1)%>">
                                                            <input type="hidden" name="service" class="btn btn-primary" value="updateProject">
                                                            <Button type="submit" name="submit" value="" class="btn btn-primary">Save changes</button>
                                                        </div><!--end col-->
                                                    </div><!--end row-->
                                                </form><!--end form-->
                                                <%}%>
                                            </div><!--end tab content-->
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </div>
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