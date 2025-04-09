<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .dropdown-toggle::after {
            display: none !important;
        }
    </style>
    <style>
        #toast {
            display: none;
            position: fixed;
            top: 90px;
            right: 50px;
            background-color: #4CAF50;
            color: #fff;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
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
        <div class="page-wrapper doctris-theme toggled bg-light">

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
                        <!--bread crums-->
                        <div class="row mb-2">
                            <div class="col-xl-9 col-md-6">
                                <h5 class="mb-0">Project Management</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="">Project Management</a></li>
                                        <li class="breadcrumb-item"><a href="ManageProjectController">Select Class</a></li>
                                        <li class="breadcrumb-item active" aria-current="page"><a href="ManageProjectController?service=ProjectList&class_id=${class_id}">Project List</a></li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                            <div class="col-xl-9 col-md-6">

                            </div>
                        </div>   
                        <!--end of bread crums-->
                        <script type="text/javascript">

                            document.addEventListener("DOMContentLoaded", function () {
                                var urlParams = new URLSearchParams(window.location.search);
                                var success = urlParams.get("rs");
                                if (success === "u1") {
                                    displayToast("Update successfully!", true);
                                } else if (success === "u0") {
                                    displayToast("Failed to update!", false);
                                } else if (success === "a1") {
                                    displayToast("Added successfully!", true);
                                } else if (success === "a0") {
                                    displayToast("Failed to add!", false);
                                }
                            });
                        </script>
                        <!--modal add project-->
                        <%
                            ResultSet rsClassCode = (ResultSet) request.getAttribute("rsClassCode");
                            ResultSet rsAllMentorName = (ResultSet) request.getAttribute("rsAllMentorName");
                            ResultSet rsAllCo_MentorName = (ResultSet) request.getAttribute("rsAllCo_MentorName");
                        %>
                        <div class="modal" id="addProject" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header border-bottom p-3">
                                        <h5 class="modal-title" id="exampleModalLabel">Project Add</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-3">
                                        <form class="mt-4" action="ManageProjectController">
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
                                                        <div class="form-check">
                                                            <label class="form-check-label">
                                                                Active
                                                            </label>
                                                            <input class="form-check-input" type="radio" disabled>
                                                        </div>
                                                        <div class="form-check">
                                                            <label class="form-check-label">
                                                                Inactive
                                                            </label>
                                                            <input class="form-check-input" type="radio" name="Status" value="0" checked readonly="">
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Group Name:</label>
                                                        <input required="" name="group_name" pattern=".{2,20}" title="Between 1 to 20 characters" type="text" class="form-control" >
                                                    </div> 
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Project Code:</label>
                                                        <input required="" name="project_code" pattern=".{3,10}" title="Between 3 to 10 characters" type="text" class="form-control" >
                                                    </div>                                                                               
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">English Name:</label>
                                                        <input required="" name="en_name" pattern=".{5,30}" title="Between 5 to 30 characters" type="text" class="form-control" >
                                                    </div> 
                                                </div><!--end col-->
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Vietnamese Name:</label>
                                                        <input required="" name="vi_name" pattern=".{5,30}" title="Between 5 to 30 characters"  type="text" class="form-control" >
                                                    </div>                                                                               
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Mentor:</label>
                                                        <select required name="Mentor_id" class="form-select" id="">
                                                            <option value="" hidden="">Select mentor</option>
                                                            <%while (rsAllMentorName.next()) {%>
                                                            <option value="<%=rsAllMentorName.getInt("user_id")%>"><%=rsAllMentorName.getString("full_name")%></option>
                                                            <%}%>
                                                        </select>
                                                    </div> 
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Co-mentor:</label>
                                                        <select required name="Co-mentor_id" class="form-select" id="">
                                                            <option value="" hidden="">Select co-mentor</option>
                                                            <%while (rsAllCo_MentorName.next()) {%>
                                                            <option value="<%=rsAllCo_MentorName.getInt("user_id")%>"><%=rsAllCo_MentorName.getString("full_name")%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>                                                                               
                                                </div>

                                                <div class="col-md-6">

                                                </div>

                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Description:</label>
                                                        <textarea name="project_descript" id="comments" rows="4" class="form-control" ></textarea>
                                                    </div>
                                                </div>
                                            </div><!--end row-->

                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <input type="hidden" name="service" class="btn btn-primary" value="addProject">
                                                    <Button type="submit" name="submit" class="btn btn-primary">Save changes</button>
                                                </div><!--end col-->
                                            </div><!--end row-->
                                        </form><!--end form-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--end of modal add project -->

                        <!--confirm freeze modal-->
                        <%
                            String class_id = request.getParameter("class_id");
                            String freezeResult = (String) request.getAttribute("freezeResult");
                        %>

                        <div class="modal" id="confirmFreeze" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                <div class="modal-content p-3">

                                    <div class="modal-body border-0 text-center p-2">
                                        <h1 class="text-danger display-1"><i class="ri-close-circle-line"></i></h1>
                                        <h4 class="modal-title" id="confirmDelete">Are you sure</h4>
                                        <p>Do you really want to FREEZE these project's member list? This process cannot be undone.</p>
                                    </div>
                                    <div class="modal-footer border-0 align-items-center justify-content-center">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <a type="button" class="btn btn-danger" href="ManageProjectController?service=Freeze&class_id=<%=class_id%>">Freeze</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--end of confim freeze modal-->

                        <div class="card p-4 rounded shadow border-0">


                            <div class="row p-2">
                                <%if (freezeResult.equals("fail")) {%>
                                <div class="alert alert-danger alert-dismissible fade show  " role="alert">
                                    <strong>Fail to Freeze!</strong> Make sure your waiting list empty.
                                    <button type="button" class="btn-close me-1 p-1 mt-2 " data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <%} else if (freezeResult.equals("success")) {%>
                                <div class="alert alert-success alert-dismissible fade show  " role="alert">
                                    <strong>Freeze Successfully</strong>
                                    <button type="button" class="btn-close me-1 p-1 mt-2 " data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </div>
                            <%}%>

                            <div class="row">
                                <div class="col-sm-12 col-md-4 mt-3 mt-sm-0">

                                </div>

                                <%if (role != 18) {%>
                                <div class="col-sm-12 col-md-2 mt-3 mt-sm-0">
                                    <div class="d-grid">
                                        <a data-bs-toggle="modal" data-bs-target="#addProject" class="btn btn-primary" >+ Add Project</a>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-2 mt-3 mt-sm-0">
                                    <div class="d-grid">
                                        <a data-bs-toggle="modal" data-bs-target="#confirmFreeze" class="btn btn-danger" >Freeze</a>
                                    </div>
                                </div> 
                                <div class="col-sm-12 col-md-2 mt-3 mt-sm-0">
                                    <div class="d-grid">
                                        <a href="ManageProjectController?service=export&class_id=<%=class_id%>" class="btn btn-success" >Export to Excel File</a>
                                    </div>
                                </div> 
                                <div class="col-sm-12 col-md-2 mt-3 mt-sm-0">
                                    <button class="btn btn-warning dropdown-toggle " type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                        Import with Excel File <i class="uil uil-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="ManageProjectController?service=getTemplate&class_id=<%=class_id%>" >Download template</a>
                                        <a class="dropdown-item"  href="#" id="importLink">Import excel file</a>


                                        <form id="uploadForm" action="ManageProjectController" method="post" enctype="multipart/form-data" style="display:none;">
                                            <input type="hidden" name="service" value="import">
                                            <input type="hidden" name="class_id" value="<%=class_id%>">
                                            <input type="file" id="fileUpload"  name="file" style="display:none;" />
                                        </form>
                                    </ul>
                                    <%}%>
                                </div>
                            </div>
                            <div class="row">
                                <div class="accordion" id="accordionExample">
                                    <div class=" table-responsive rounded">
                                        <table class="table table-bordered table-center bg-white mb-0">
                                            <thead class="">
                                                <tr class="">
                                                    <th class=" p-4" style="min-width: 180px;">
                                                        <span>Name</span>
                                                        <a disabled="" class="  btn btn-icon"></i></a>
                                                    </th>
                                                    <th class=" p-4" style="min-width: 180px;">Email</th>
                                                    <th class=" p-4" style="min-width: 180px;">Phone</th>
                                                    <th class=" p-4" style="min-width: 180px;">Status</th>
                                                    <th class=" p-4 text-end" style="min-width: 100px;">
                                                        <a disabled="" class="  btn btn-icon"></i></a>
                                                        <a disabled="" class="  btn btn-icon"></i></a>
                                                        Actions

                                                    </th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!--waiting list-->
                            <div class="row justify-content-between align-items-center ">
                                <div class="accordion" id="accordionWaitingList">
                                    <div class="accordion-item border rounded mt-2 mb-3">
                                        <h2 class="accordion-header " id="heading-WaitingList">
                                            <button class="accordion-button bg-light border-0  collapsed" type="button"
                                                    data-bs-toggle="collapse" data-bs-target="#collapse-WaitingList"
                                                    aria-expanded="false" aria-controls="collapse-WaitingList" >
                                                <div class="text-danger">Waiting List</div>
                                            </button>
                                        </h2>
                                        <div id="collapse-WaitingList" class="accordion-collapse border-0 collapse"
                                             aria-labelledby="collapse-WaitingList" data-bs-parent="#accordionWaitingList">
                                            <div class="accordion-body text-muted">
                                                <div class=" table-responsive rounded">
                                                    <table class="table table-borderless table-center bg-white mb-0">
                                                        <tbody>
                                                            <%
                                                                ResultSet rsProjectForAdd = (ResultSet) request.getAttribute("rsProjectForAdd");
                                                                ResultSet rsWaitingList = (ResultSet) request.getAttribute("rsWaitingList");
                                                                while (rsWaitingList.next()) {
                                                            %>
                                                            <tr>
                                                                <td class="mx-3">
                                                                    <a href="#" class="text-dark">
                                                                        <div class="d-flex align-items-center">                                                     
                                                                            <span class="ms-3 me-2"><%=rsWaitingList.getString("full_name")%></span>
                                                                            <a disabled="" class="  btn btn-icon"></i></a>
                                                                        </div>
                                                                    </a>
                                                                </td>
                                                                <td class="p-3"><%=rsWaitingList.getString("email")%></td>
                                                                <td class="p-3"><%=rsWaitingList.getString("mobile")%></td>
                                                                <%
                                                                    if (rsWaitingList.getInt("is_active") == 1) {
                                                                %>
                                                                <td class="p-3"><span class="badge bg-soft-success">Active</span></td>
                                                                <%} else {%>
                                                                <td class="p-3"><span class="badge bg-soft-danger">Inactive</span></td>
                                                                <%}%>
                                                                <td class="text-end ">
                                                                    <a disabled="" class="  btn btn-icon "></i></a>
                                                                    <a disabled="" class="  btn btn-icon"></i></a>
                                                                    <a disabled="" class="  btn btn-icon "></i></a>
                                                                        <%if (role != 18) {%>
                                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-success" data-bs-toggle="modal" data-bs-target="#add"><i class="uil uil-plus"></i></a>
                                                                        <%}%>
                                                                </td>
                                                            </tr>
                                                            <!--modal add-->
                                                        <div class="modal fade" id="add" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered">
                                                                <div class="modal-content">
                                                                    <div class="modal-header border-bottom p-3">
                                                                        <h5 class="modal-title" id="exampleModalLabel">Add member</h5>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="container">
                                                                            <form class="m-2" action="ManageProjectController">
                                                                                <div class="form-group m-2">
                                                                                    <label for="exampleInputEmail1">To:</label>
                                                                                    <select name="project_id" class="form-select">
                                                                                        <option value="" hidden="">Select Group Here</option>
                                                                                        <%while (rsProjectForAdd.next()) {%>
                                                                                        <option value="<%=rsProjectForAdd.getString(1)%>"><%=rsProjectForAdd.getString(2)%></option>
                                                                                        <%}%>
                                                                                    </select>
                                                                                </div>
                                                                                <div class="row mt-5 mb-2 mx-2 ">
                                                                                    <input type="hidden" name="class_id" value="<%=rsWaitingList.getString("class_id")%>"></input>
                                                                                    <input type="hidden" name="student_id" value="<%=rsWaitingList.getString("student_id")%>"></input>
                                                                                    <input type="hidden" name="service" value="addMember"></input>
                                                                                    <input type="submit" class="btn btn-primary" value="Save change"></input>
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--end of modal add-->
                                                        <%}%>
                                                        </tbody>
                                                    </table>
                                                </div>   
                                            </div>
                                        </div>
                                    </div>

                                    <!--end of waiting list-->
                                    <!--project list-->
                                    <div class="row justify-content-between align-items-center mb-2">
                                        <div class="col-sm-12 col-md-5 ">
                                            <div class="mb-0 position-relative">
                                            </div>
                                        </div><!--end col-->
                                        <div class="col-sm-12 col-md-2 mt-4 mt-sm-0">

                                        </div>
                                        <!--end col-->
                                    </div>



                                    <%
                                        ResultSet rsProject = (ResultSet) request.getAttribute("rsProject");
                                        ProjectDAO dao = new ProjectDAO();
                                        while (rsProject.next()) {
                                            String className = dao.getClassNamebyID(rsProject.getInt("class_id"));
                                            String mentorName = dao.getMentorNamebyID(rsProject.getInt("mentor_id"));
                                            String co_mentorName = dao.getMentorNamebyID(rsProject.getInt("co_mentor_id"));
                                            String leaderName = dao.getLeaderNamebyProjectID(rsProject.getInt("project_id"));
                                    %>
                                    <div class="accordion-item border rounded mt-2">
                                        <h2 class="accordion-header" id="heading-<%=rsProject.getString(2)%>">
                                            <div class="d-flex">
                                                <button class="accordion-button border-0 bg-light collapsed" type="button"
                                                        data-bs-toggle="collapse" data-bs-target="#collapse-<%=rsProject.getString(2)%>"
                                                        aria-expanded="false" aria-controls="collapse-<%=rsProject.getString(2)%>" >
                                                    <!--Project 1-->
                                                    <%=className%>: <%=rsProject.getString("group_name")%> - <%=rsProject.getString(2)%>
                                                </button>
                                                <button class="btn btn dropdown-toggle bg-light" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="uil uil-ellipsis-v"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                                                    <li><a class="dropdown-item" href="ManageProjectController?service=updateProject&project_id=<%=rsProject.getString(1)%>&class_id=<%=rsProject.getInt("class_id")%>">View Detail</a></li>
                                                        <%if (role != 18) {%>
                                                    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#confirmDeleteProject-<%=rsProject.getString(1)%>" id="delete-<%=rsProject.getString(1)%>">Delete</a></li>
                                                        <%}%>
                                                </ul>
                                            </div>
                                        </h2>

                                        <div id="collapse-<%=rsProject.getString(2)%>" class="accordion-collapse border-0 collapse"
                                             aria-labelledby="heading-<%=rsProject.getString(2)%>" data-bs-parent="#accordionExample">
                                            <div class="accordion-body text-muted">
                                                <!--end of tab genaral-->
                                                <!--tab member-->
                                                <div class="row justify-content-between align-items-center mb-2">
                                                    <div class="col-sm-12 col-md-5 ">
                                                        <div class="mb-0 position-relative">
                                                        </div>
                                                    </div><!--end col-->

                                                </div>
                                                <div class=" table-responsive rounded">
                                                    <table class="table table-borderless table-center bg-white mb-0">
                                                        <!--                                                            <thead>
                                                                                                                        <tr>
                                                                                                                            <th class=" p-3" style="min-width: 180px;">Name</th>
                                                                                                                            <th class=" p-3" style="min-width: 180px;">Email</th>
                                                                                                                            <th class=" p-3" style="min-width: 180px;">Status</th>
                                                                                                                            <th class=" p-3 text-end" style="min-width: 100px;">Actions</th>
                                                                                                                        </tr>
                                                                                                                    </thead>-->
                                                        <tbody>
                                                            <%
                                                                ResultSet rsProjectForMove = (ResultSet) request.getAttribute("rsProjectForMove");
                                                                ResultSet rsProjectMember = dao.getProjectMember(rsProject.getString("project_id"));
                                                                while (rsProjectMember.next()) {
                                                            %>
                                                            <tr>
                                                                <td class="mx-3">
                                                                    <a href="#" class="text-dark">
                                                                        <div class="d-flex align-items-center">

                                                                            <span class="ms-3 me-2"><%=rsProjectMember.getString("full_name")%> </span>
                                                                            <%
                                                                                if (rsProjectMember.getInt("is_leader") == 1) {
                                                                            %>
                                                                            <a disabled="" class="  btn btn-icon btn-pills btn-warning"><i class=" uil uil-star"></i></a>
                                                                                <%} else {%>
                                                                            <a disabled="" class="  btn btn-icon btn-pills btn-warning invisible"><i class="uil uil-star"></i></a>
                                                                                <%}%>
                                                                        </div>
                                                                    </a>
                                                                </td>
                                                                <td class="p-3"><%=rsProjectMember.getString("email")%></td>
                                                                <td class="p-3"><%=rsProjectMember.getString("mobile")%></td>
                                                                <%
                                                                    if (rsProjectMember.getInt("is_active") == 1) {
                                                                %>
                                                                <td class="p-3"><span class="badge bg-soft-success">Active</span></td>
                                                                <%} else {%>
                                                                <td class="p-3"><span class="badge bg-soft-danger">Inactive</span></td>
                                                                <%}%>

                                                                <td class="text-end ">
                                                                    <%
                                                                        if (rsProjectMember.getInt("is_leader") != 1 && rsProjectMember.getInt("is_active") == 1) {
                                                                    %>
                                                                    <a title="Set as Leader" href="ManageProjectController?service=setLeader&project_id=<%=rsProjectMember.getString("project_id")%>&student_id=<%=rsProjectMember.getString("student_id")%>&class_id=<%=rsProjectMember.getString("class_id")%>" class="btn btn-icon btn-pills btn-soft-warning"><i class="uil uil-star"></i></a>
                                                                        <%}%>
                                                                        <%if (role != 18) {%>

                                                                    <%
                                                                        if (rsProject.getInt("status") != 1) {
                                                                    %>
                                                                    <a title="Move" href="ManageProjectController?service=moveMember&student_id=<%=rsProjectMember.getString("student_id")%>&class_id=<%=rsProjectMember.getString("class_id")%>" class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-exchange"></i></a>
                                                                        <%
                                                                            if (rsProjectMember.getInt("is_active") == 1) {
                                                                        %>
                                                                    <a title="Activate" href="ManageProjectController?service=setStatus&project_id=<%=rsProjectMember.getString("project_id")%>&student_id=<%=rsProjectMember.getString("student_id")%>&class_id=<%=rsProjectMember.getString("class_id")%>&status=0" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-times"></i></a>
                                                                        <%} else {%>
                                                                    <a title="Inactivate" href="ManageProjectController?service=setStatus&project_id=<%=rsProjectMember.getString("project_id")%>&student_id=<%=rsProjectMember.getString("student_id")%>&class_id=<%=rsProjectMember.getString("class_id")%>&status=1" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-check"></i></a>
                                                                        <%}%>
                                                                    <a title="Kick from group" href="ManageProjectController?service=removeMember&project_id=<%=rsProjectMember.getString("project_id")%>&student_id=<%=rsProjectMember.getString("student_id")%>&class_id=<%=rsProjectMember.getString("class_id")%>" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-trash-alt"></i></a>
                                                                        <%}%>
                                                                </td>
                                                                <%}%>

                                                            </tr>
                                                            <%}%>


                                                        </tbody>
                                                    </table>
                                                </div>
                                                <!--end of tab member-->

                                                <!-- delete project confirm modal -->

                                                <!--end of delete project confirm modal-->
                                            </div>
                                        </div>
                                    </div>


                                    <div class="modal" id="confirmDeleteProject-<%=rsProject.getString(1)%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                            <div class="modal-content p-3">

                                                <div class="modal-body border-0 text-center p-2">
                                                    <h1 class="text-danger display-1"><i class="ri-close-circle-line"></i></h1>
                                                    <h4 class="modal-title" id="confirmDelete">Are you sure</h4>
                                                    <p>Do you really want to delete these records? This process cannot be undone.</p>
                                                </div>
                                                <div class="modal-footer border-0 align-items-center justify-content-center">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    <a type="button" class="btn btn-danger" href="ManageProjectController?service=deleteProject&project_id=<%=rsProject.getString(1)%>">Delete</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>
                                <!--modal add member-->

                                <!--modal move member-->

                            </div>
                            <!-- end of accardion item -->

                        </div>


                    </div>
                    <script type="text/javascript">
                        document.getElementById('importLink').addEventListener('click', function (event) {
                            event.preventDefault();
                            let fileUpload = document.getElementById('fileUpload');
                            fileUpload.click(); // Trigger the hidden file input
                        });
                        document.getElementById('fileUpload').addEventListener('change', function () {
                            if (this.files.length > 0) {
                                document.getElementById('uploadForm').submit(); // Submit the form when a file is chosen
                            }
                        });
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
                            }, 2000);  // Display the toast for 3 seconds
                        }
                    </script>
                    <div id="toast" class=""></div>                            



                </div>
                <%@include file="../../layout/footer.jsp" %>

        </div>
        <!-- Footer Start -->
        <!--end footer-->
    </main>
</div>


</body>
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
</html>