<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dal.SubjectDAO,model.Subject, model.User, model.IssueSetting, model.Class, java.sql.ResultSet"
        %>
<%@page import="java.util.List" %>
<%@page import="java.util.Vector" %>
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
        <link href="assests/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="assests/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assests/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.cs
              <!-- Select2 -->
              <link href=" assests/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="assests/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assests/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="assests/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <% String mode = (String) request.getAttribute("mode"); %>
        <%if (mode.equals("class") || mode.equals("subject")) {%>
        <style>
            #nav-class-issue {
                background-color: #007bff;
                /* Change to your desired background color */
                color: #fff !important;
                /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
            }

            #nav-subject-setting {
                background-color: #007bff;
                /* Change to your desired background color */
                color: #fff !important;
                /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
            }

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
        <%} else if (mode.equals("project")) {%>
        <style>
            #nav-class-setting {
                background-color: #007bff;
                /* Change to your desired background color */
                color: #fff !important;
                /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
            }

            #toast {
                display: none;
                position: fixed;
                top: 100px;
                right: 50px;
                background-color: #4CAF50;
                color: #fff;
                padding: 15px;
                border-radius: 5px;
                text-align: center;
            }
        </style>
        <%}%>
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
            <!-- Sidebar wrapper -->
            <%@include file="../layout/adminSideBar.jsp" %>
            <!-- End of sidebar-wrapper  -->
            <!-- Start Page-content -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End of HEADER -->
                <div class="container-fluid">
                    <div class="layout-specing">
                        <c:if
                            test="${sessionScope.user.roleId==16||sessionScope.user.roleId==14||sessionScope.user.roleId==15}">
                            <%if (mode.equals("class")) {%>
                            <% Vector<Class> vector = (Vector<Class>) request.getAttribute("classData");
                                Class cl = vector.get(0);
                            %>
                            <div class="d-md-flex justify-content-between">
                                <h5 class="mb-0">Class Details</h5>
                                <nav aria-label="breadcrumb"
                                     class="d-inline-block mt-4 mt-sm-0">
                                    <ul
                                        class="breadcrumb bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a
                                                href="ClassController">Class
                                                List</a></li>
                                        <li class="breadcrumb-item active"><a
                                                href="#">Class Details</a></li>
                                    </ul>
                                </nav>
                            </div>
                            <div
                                class="card bg-white rounded shadow overflow-hidden mt-4 border-0">
                                <div class="ms-3 pt-3">
                                    <h3 class="mb-0">
                                        <%=cl.getClassCode()%>
                                    </h3>
                                </div>
                                <%}%>
                            </c:if>
                            <c:if
                                test="${sessionScope.user.roleId==15||sessionScope.user.roleId==14||sessionScope.user.roleId==16}">
                                <%if (mode.equals("subject")) {%>
                                <% Vector<Subject> vector = (Vector<Subject>) request.getAttribute("subjectData");
                                    Subject sub = vector.get(0);
                                %>
                                <div class="d-md-flex justify-content-between">
                                    <h5 class="mb-0">Subject Settings</h5>
                                    <nav aria-label="breadcrumb"
                                         class="d-inline-block mt-4 mt-sm-0">
                                        <ul
                                            class="breadcrumb bg-transparent rounded mb-0 p-0">
                                            <li class="breadcrumb-item"><a
                                                    href="ClassController">Subject
                                                    List</a></li>
                                            <li class="breadcrumb-item active"><a
                                                    href="#">Subject Setting</a></li>
                                        </ul>
                                    </nav>
                                </div>
                                <div
                                    class="card bg-white rounded shadow overflow-hidden mt-4 border-0">
                                    <div class="ms-3 pt-3">
                                        <h3 class="mb-0">
                                            <%=sub.getSubjectCode()%>
                                        </h3>
                                    </div>
                                    <%}%>
                                </c:if>
                                <c:if
                                    test="${sessionScope.user.roleId==14||sessionScope.user.roleId==15||sessionScope.user.roleId==16}">

                                    <%if (mode.equals("project")) {%>
                                    <div class="row mb-3">
                                        <div class="col-xl-9 col-md-6">
                                            <h5 class="mb-0">Project Management</h5>

                                            <nav aria-label="breadcrumb"
                                                 class="d-inline-block mt-2">
                                                <ul
                                                    class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                                    <li class="breadcrumb-item"><a href="">Project
                                                            Management</a></li>
                                                    <li class="breadcrumb-item"><a
                                                            href="ManageProjectController">Select
                                                            Class</a></li>
                                                    <li class="breadcrumb-item "><a
                                                            href="ManageProjectController?service=ProjectList&class_id=${class_id}">Project
                                                            List</a></li>
                                                    <li class="breadcrumb-item active"
                                                        aria-current="page">Project Details</li>
                                                </ul>
                                            </nav>
                                        </div><!--end col-->
                                    </div>
                                    <div class="bg-white component-wrapper border-0 rounded shadow">
                                        <div class="p-4 border-bottom">
                                            <h5 class="mb-0"> Project details </h5>
                                        </div>
                                        <%}%>
                                    </c:if>

                                    <div class="row">
                                        <div class="col-12">
                                            <div class="card border-0 rounded-0 p-4">
                                                <!--searchBar-->
                                                <div class="row ">
                                                    <c:if
                                                        test="${sessionScope.user.roleId==15||sessionScope.user.roleId==14||sessionScope.user.roleId==16}">
                                                        <%if (mode.equals("subject")) {%>
                                                        <%@include file="../layout/subjectDetailNavigation.jsp" %>
                                                        <%}%>
                                                        <%if (mode.equals("class")) {%>
                                                        <%@include file="../layout/assignedClassNavigation.jsp" %>
                                                        <%}%>
                                                        <%if (mode.equals("project")) {%>
                                                        <% String projectID = (String) request.getAttribute("projectID");
                                                            String classID = (String) request.getAttribute("classID");
                                                        %>
                                                        <div class="row">
                                                            <div
                                                                class="col-lg-12">
                                                                <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded"
                                                                    id="pills-tab"
                                                                    role="tablist">
                                                                    <li
                                                                        class="nav-item">
                                                                        <a class="nav-link rounded"
                                                                           href="ManageProjectController?service=updateProject&project_id=<%=projectID%>&class_id=<%=classID%>"
                                                                           role="tab"
                                                                           aria-controls="pills-smart"
                                                                           aria-selected="false">
                                                                            <div
                                                                                class="text-center pt-1 pb-1">
                                                                                <h4
                                                                                    class="title font-weight-normal mb-0">
                                                                                    General
                                                                                </h4>
                                                                            </div>
                                                                        </a><!--end nav link-->
                                                                    </li>
                                                                    <!--end nav item-->
                                                                    <% ResultSet rsProject = (ResultSet) request.getAttribute("rsProject");
                                                                        while (rsProject.next()) {%>
                                                                    <li
                                                                        class="nav-item">
                                                                        <a class="nav-link rounded"
                                                                           href="ManageProjectController?service=listMilestones&project_id=<%=rsProject.getString(1)%>"
                                                                           role="tab"
                                                                           aria-controls="pills-smart"
                                                                           aria-selected="false">
                                                                            <div
                                                                                class="text-center pt-1 pb-1">
                                                                                <h4
                                                                                    class="title font-weight-normal mb-0">
                                                                                    Milestone
                                                                                </h4>
                                                                            </div>
                                                                        </a><!--end nav link-->
                                                                    </li>
                                                                    <!--end nav item-->
                                                                    <li
                                                                        class="nav-item">
                                                                        <a class="nav-link rounded active"
                                                                           id="pills-cloud-tab"
                                                                           data-bs-toggle="pill"
                                                                           href="IssueSettingController?service=displayProjectSetting&projectID=<%=rsProject.getString(1)%>&mode=project"
                                                                           role="tab"
                                                                           aria-controls="pills-cloud"
                                                                           aria-selected="true">
                                                                            <div
                                                                                class="text-center pt-1 pb-1">
                                                                                <h4
                                                                                    class="title font-weight-normal mb-0">
                                                                                    Issue Setting
                                                                                </h4>
                                                                            </div>
                                                                        </a><!--end nav link-->
                                                                    </li>
                                                                    <!--end nav item-->
                                                                    <%}%>
                                                                </ul>
                                                                <!--end nav pills-->
                                                            </div>
                                                            <!--end col-->
                                                        </div><!--end row-->

                                                        <%}%>
                                                    </c:if>

                                                    <!-- Search -->
                                                    <%if (mode.equals("subject")) {%>
                                                    <div class="search-bar p-4 d-none d-md-block ">
                                                        <div id="search" class="menu-search mb-0">
                                                            <form action="IssueSettingController"
                                                                  role="search" method="get"
                                                                  id="searchform" class="searchform">
                                                                <% String subject_id = request.getParameter("subjectID");
                                                                %>
                                                                <input type="hidden" name="service"
                                                                       value="searchSubjectSetting">
                                                                <input type="hidden"
                                                                       name="subjectID"
                                                                       value="<%=subject_id%>">
                                                                <input type="hidden" name="mode"
                                                                       value="subject">
                                                                <div>
                                                                    <input type="text"
                                                                           class="form-control border rounded-pill"
                                                                           name="titleNstatus"
                                                                           id="name"
                                                                           placeholder="Search Keywords...">
                                                                    <input type="submit"
                                                                           id="searchsubmit"
                                                                           value="Search">
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <%} else if (mode.equals("class")) {%>
                                                    <div class="search-bar p-4 d-none d-md-block ">
                                                        <div id="search" class="menu-search mb-0">
                                                            <form action="IssueSettingController"
                                                                  role="search" method="get"
                                                                  id="searchform" class="searchform">
                                                                <% String subject_id = request.getParameter("subjectID");
                                                                    String class_id = request.getParameter("classId");
                                                                %>
                                                                <input type="hidden"
                                                                       name="service"
                                                                       value="searchClassSetting">
                                                                <input type="hidden"
                                                                       name="subjectID"
                                                                       value="<%=subject_id%>">
                                                                <input type="hidden"
                                                                       name="classId"
                                                                       value="${assignClass.classId}">
                                                                <input type="hidden" name="mode"
                                                                       value="class">
                                                                <div>
                                                                    <input type="text"
                                                                           class="form-control border rounded-pill"
                                                                           name="titleNstatus"
                                                                           id="name"
                                                                           placeholder="Search Keywords...">
                                                                    <input type="submit"
                                                                           id="searchsubmit"
                                                                           value="Search">
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <%}%>

                                                    <c:if
                                                        test="${sessionScope.user.roleId==14||sessionScope.user.roleId==15||sessionScope.user.roleId==16}">
                                                        <%if (mode.equals("project")) {%>
                                                        <div
                                                            class="search-bar p-4 d-none d-md-block ">
                                                            <div id="search"
                                                                 class="menu-search mb-0">
                                                                <form
                                                                    action="IssueSettingController"
                                                                    role="search"
                                                                    method="get"
                                                                    id="searchform"
                                                                    class="searchform">

                                                                    <% String projectID = request.getParameter("projectID");
                                                                    %>
                                                                    <input type="hidden"
                                                                           name="service"
                                                                           value="searchProjectSetting">
                                                                    <input type="hidden"
                                                                           name="projectID"
                                                                           value="<%=projectID%>">
                                                                    <input type="hidden"
                                                                           name="mode"
                                                                           value="project">

                                                                    <div>
                                                                        <input
                                                                            type="text"
                                                                            class="form-control border rounded-pill"
                                                                            name="titleNstatus"
                                                                            id="name"
                                                                            placeholder="Search Keywords...">
                                                                        <input
                                                                            type="submit"
                                                                            id="searchsubmit"
                                                                            value="Search">
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                        <%}%>
                                                    </c:if>
                                                    <!-- End searchbar -->

                                                    <!-- Filter -->
                                                    <%if (mode.equals("subject")) {%>
                                                    <div class="col-md-2 mt-4">
                                                        <form
                                                            action="IssueSettingController">
                                                            <c:forEach
                                                                items="${listSubjectSetting}"
                                                                var="sd">
                                                                <input type="hidden"
                                                                       name="service"
                                                                       value="filterIssueSubject">
                                                                <input type="hidden"
                                                                       name="subjectID"
                                                                       value="${sd.subject_id}">
                                                                <input type="hidden"
                                                                       name="mode"
                                                                       value="subject">

                                                            </c:forEach>
                                                            <select name="issueType"
                                                                    class="form-select"
                                                                    id="checkActive"
                                                                    onchange="this.form.submit()">
                                                                <option value="" hidden="">
                                                                    Setting Type:</option>
                                                                <option value="display">All
                                                                </option>
                                                                <c:forEach
                                                                    items="${requestScope.listType}"
                                                                    var="v">
                                                                    <option
                                                                        value="${v.title}">
                                                                        ${v.title}</option>
                                                                    </c:forEach>
                                                            </select>
                                                        </form>
                                                    </div>
                                                    <div class="col-md-2 mt-4">
                                                        <form
                                                            action="IssueSettingController">
                                                            <c:forEach
                                                                items="${listSubjectSetting}"
                                                                var="sd">
                                                                <input type="hidden"
                                                                       name="service"
                                                                       value="filterIssueSubject">
                                                                <input type="hidden"
                                                                       name="subjectID"
                                                                       value="${sd.subject_id}">
                                                                <input type="hidden"
                                                                       name="mode"
                                                                       value="subject">
                                                            </c:forEach>
                                                            <select name="issueStatus"
                                                                    class="form-select"
                                                                    id="checkActive"
                                                                    onchange="this.form.submit()">
                                                                <option value="" hidden="">
                                                                    Setting Name:</option>
                                                                <option value="display">All
                                                                </option>
                                                                <c:forEach
                                                                    items="${requestScope.listStatus}"
                                                                    var="s">
                                                                    <option
                                                                        value="${s.status}">
                                                                        ${s.status}</option>
                                                                    </c:forEach>
                                                            </select>
                                                        </form>
                                                    </div>
                                                    <div
                                                        class="col-lg-5 col-md-2 mt-4 d-flex align-items-end justify-content-end">
                                                        <div style="float: right;"
                                                             class="d-grid ms-3">
                                                            <a class="btn btn-primary"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#addSetting">Add
                                                                new issue setting</a>
                                                        </div>
                                                    </div>
                                                    <%} else if (mode.equals("class")) {%>

                                                    <div class="col-md-2 mt-4">
                                                        <form
                                                            action="IssueSettingController">
                                                            <c:forEach
                                                                items="${listSubjectSetting}"
                                                                var="sd">
                                                                <input type="hidden"
                                                                       name="service"
                                                                       value="filterIssueClass">
                                                                <input type="hidden"
                                                                       name="subjectID"
                                                                       value="${sd.subject_id}">
                                                                <input type="hidden"
                                                                       name="classID"
                                                                       value="${sd.class_id}">
                                                                <input type="hidden"
                                                                       name="mode"
                                                                       value="class">
                                                            </c:forEach>
                                                            <select name="issueType"
                                                                    class="form-select"
                                                                    id="checkActive"
                                                                    onchange="this.form.submit()">
                                                                <option value=""
                                                                        hidden="">Setting Type:</option>
                                                                <option value="display">
                                                                    All</option>
                                                                    <c:forEach
                                                                        items="${requestScope.listType}"
                                                                        var="v">
                                                                    <option
                                                                        value="${v.title}">
                                                                        ${v.title}
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                        </form>
                                                    </div>
                                                    <div class="col-md-2 mt-4">
                                                        <form
                                                            action="IssueSettingController">
                                                            <c:forEach
                                                                items="${listSubjectSetting}"
                                                                var="sd">
                                                                <input type="hidden"
                                                                       name="service"
                                                                       value="filterIssueClass">
                                                                <input type="hidden"
                                                                       name="subjectID"
                                                                       value="${sd.subject_id}">
                                                                <input type="hidden"
                                                                       name="classID"
                                                                       value="${sd.class_id}">
                                                                <input type="hidden"
                                                                       name="mode"
                                                                       value="class">
                                                            </c:forEach>
                                                            <select name="issueStatus"
                                                                    class="form-select"
                                                                    id="checkActive"
                                                                    onchange="this.form.submit()">
                                                                <option value=""
                                                                        hidden="">Setting Name:</option>
                                                                <option value="display">
                                                                    All</option>
                                                                    <c:forEach
                                                                        items="${requestScope.listStatus}"
                                                                        var="s">
                                                                    <option
                                                                        value="${s.status}">
                                                                        ${s.status}
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                        </form>
                                                    </div>
                                                    <div
                                                        class="col-lg-5 col-md-2 mt-4 d-flex align-items-end justify-content-end">
                                                        <div style="float: right;"
                                                             class="d-grid ms-3">
                                                            <a class="btn btn-primary"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#addSetting">Add
                                                                new issue setting</a>
                                                        </div>
                                                    </div>
                                                    <%} else if (mode.equals("project")) {%>
                                                    <div class="col-md-2 mt-4">
                                                        <form
                                                            action="IssueSettingController">
                                                            <c:forEach
                                                                items="${listSubjectSetting}"
                                                                var="sd">
                                                                <input type="hidden"
                                                                       name="service"
                                                                       value="filterIssueProject">
                                                                <input type="hidden"
                                                                       name="projectID"
                                                                       value="${sd.project_id}">
                                                                <input type="hidden"
                                                                       name="mode"
                                                                       value="project">
                                                            </c:forEach>
                                                            <select name="issueType"
                                                                    class="form-select"
                                                                    id="checkActive"
                                                                    onchange="this.form.submit()">
                                                                <option value=""
                                                                        hidden="">Setting
                                                                    Type:</option>
                                                                <option
                                                                    value="display">
                                                                    All</option>
                                                                    <c:forEach
                                                                        items="${requestScope.listType}"
                                                                        var="v">
                                                                    <option
                                                                        value="${v.title}">
                                                                        ${v.title}
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                        </form>
                                                    </div>
                                                    <div class="col-md-2 mt-4">
                                                        <form
                                                            action="IssueSettingController">
                                                            <% String projectID = request.getParameter("projectID");
                                                            %>
                                                            <input type="hidden"
                                                                   name="service"
                                                                   value="filterIssueProject">
                                                            <input type="hidden"
                                                                   name="projectID"
                                                                   value="<%=projectID%>">
                                                            <input type="hidden"
                                                                   name="mode"
                                                                   value="project">

                                                            <select
                                                                name="issueStatus"
                                                                class="form-select"
                                                                id="checkActive"
                                                                onchange="this.form.submit()">
                                                                <option value=""
                                                                        hidden="">
                                                                    Setting Name:
                                                                </option>
                                                                <option
                                                                    value="display">
                                                                    All</option>
                                                                    <c:forEach
                                                                        items="${requestScope.listStatus}"
                                                                        var="s">
                                                                    <option
                                                                        value="${s.status}">
                                                                        ${s.status}
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                        </form>
                                                    </div>
                                                    <div
                                                        class="col-lg-5 col-md-2 mt-4">
                                                        <div style="float: right; margin-bottom: 20px "
                                                             class="d-grid">
                                                            <a class="btn btn-primary"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#addSetting">Add new issue
                                                                setting</a>
                                                        </div>
                                                    </div>
                                                    <%}%>
                                                    <!--end col-->
                                                </div>
                                                <!-- End filter -->

                                                <!--StartTable-->
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
                                                        }, 2000);  // Display the toast for 3 seconds
                                                    }
                                                </script>
                                                <div id="toast"></div>
                                                <div class="table-responsive bg-white shadow rounded">
                                                    <script type="text/javascript">
                                                        document.addEventListener("DOMContentLoaded", function () {
                                                            var urlParams = new URLSearchParams(window.location.search);
                                                            var success = urlParams.get("success");
                                                            if (success === "true") {
                                                                displayToast("updated successfully!", true);
                                                            } else if (success === "false") {
                                                                displayToast("Failed to update!", false);
                                                            } else if (success === "true1") {
                                                                displayToast("Added successfully!", true);
                                                            } else if (success === "false1") {
                                                                displayToast("Failed to add!", false);
                                                            }
                                                        });
                                                    </script>
                                                    <div class="tab-pane fade show active">
                                                        <table
                                                            class="table mb-0 table-hover table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th class="border-bottom p-3"
                                                                        style="min-width: 50px;">ID</th>
                                                                    <th class="border-bottom p-3"
                                                                        style="display: none;"
                                                                        style="min-width: 50px;">Setting ID
                                                                    </th>
                                                                    <% List<IssueSetting> listSubjectSetting
                                                                                = (List<IssueSetting>) request.getAttribute("listSubjectSetting");
                                                                        boolean isClassId = false;
                                                                        boolean isSubjectId = false;
                                                                        boolean isProjectId = false;
                                                                        int settingIdCounter = 1;
                                                                        for (IssueSetting issue
                                                                                : listSubjectSetting) {

                                                                            if (issue.getClass_id() != 0) {
                                                                                isClassId = true;
                                                                            }
                                                                            if (issue.getSubject_id() != 0) {
                                                                                isSubjectId = true;
                                                                            }
                                                                            if (issue.getProject_id() != 0) {
                                                                                isProjectId = true;
                                                                                break;
                                                                            }
                                                                        }
                                                                        if (isSubjectId == true) {
                                                                    %>
                                                                    <th class="border-bottom p-3"
                                                                        style="min-width: 50px;">
                                                                        Subject ID</th>
                                                                        <% }
                                                                            if (isClassId == true) { %>
                                                                    <th class="border-bottom p-3"
                                                                        style="min-width: 50px;">
                                                                        Class ID</th>
                                                                        <% }
                                                                            if (isProjectId == true) { %>
                                                                    <th class="border-bottom p-3"
                                                                        style="min-width: 50px;">
                                                                        Project ID</th>
                                                                        <% }%>
                                                                    <th class="border-bottom p-3"
                                                                        style="min-width: 150px;">
                                                                        Setting Type</th>
                                                                    <th class="border-bottom p-3"
                                                                        style="min-width: 150px;">
                                                                        Setting Name
                                                                    </th>
                                                                    <th class="border-bottom p-3"
                                                                        style="min-width: 150px;">
                                                                        Status</th>
                                                                    <th class="border-bottom p-3"
                                                                        style="min-width: 200px; text-align: center;">
                                                                        Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach items="${listSubjectSetting}"
                                                                           var="ls">
                                                                    <tr>

                                                                        <td class="p-3">
                                                                            <%= settingIdCounter%>
                                                                        </td>
                                                                        <td class="p-3"
                                                                            style="display: none;">
                                                                            ${ls.setting_id}</td>
                                                                            <c:if test="${ls.subject_id!= 0}">
                                                                            <td>${ls.subject_id}</td>
                                                                        </c:if>
                                                                        <c:if test="${ls.class_id!= 0}">
                                                                            <td>${ls.class_id}</td>
                                                                        </c:if>
                                                                        <c:if test="${ls.project_id!=0}">
                                                                            <td>${ls.project_id}</td>
                                                                        </c:if>
                                                                        <td class="p-3">${ls.title}</td>
                                                                        <td class="p-3">${ls.status}</td>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${ls.isActive==1}">
                                                                                <td><span

                                                                                        class="badge bg-soft-success">Active</span>
                                                                                </td>
                                                                            </c:when>
                                                                            <c:when
                                                                                test="${ls.isActive==0}">
                                                                                <td><span

                                                                                        class="badge bg-soft-danger">InActive</span>
                                                                                </td>
                                                                            </c:when>
                                                                        </c:choose>
                                                                        <% settingIdCounter++; %>
                                                                        <c:if
                                                                            test="${sessionScope.user.roleId==15||sessionScope.user.roleId==14}">
                                                                            <%if (mode.equals("subject")) {%>
                                                                            <td
                                                                                class="text-center p-3">
                                                                                <a href="IssueSettingController?service=subjectSettingUpdate&setting_id=${ls.setting_id}&subjectID=${ls.subject_id}&mode=subject"
                                                                                   class="btn btn-icon btn-pills btn-soft-primary"><i
                                                                                        class="uil uil-pen"></i></a>
                                                                                    <c:choose>
                                                                                        <c:when test="${ls.isActive==1}">
                                                                                        <a data-bs-toggle="modal" data-bs-target="#inactive-${ls.setting_id}"
                                                                                           class="btn btn-icon btn-pills btn-soft-danger"
                                                                                           title="Inactive "
                                                                                           ><i class="uil uil-times icons"></i></a>
                                                                                        <div class="modal" id="inactive-${ls.setting_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                            <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                                                <div class="modal-content p-3">

                                                                                                    <div class="modal-body border-0 text-center p-2">
                                                                                                        <h1 class="text-danger display-1"><i class="uil uil-times-circle"></i></h1>
                                                                                                        <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                                        <p>Do you really want to Deactivate this Issue Setting? This process cannot be undone.</p>
                                                                                                    </div>
                                                                                                    <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                                        <a href="IssueSettingController?service=changeStatus&settingId=${ls.setting_id}&isActive=1&subjectID=${ls.subject_id}&mode=subject" type="button" class="btn btn-danger">Deactivate</a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div> 
                                                                                    </c:when>
                                                                                    <c:otherwise>   
                                                                                        <a data-bs-toggle="modal" data-bs-target="#active-${ls.setting_id}"
                                                                                           class="btn btn-icon btn-pills btn-soft-success"
                                                                                           title="Active "
                                                                                           >
                                                                                            <i class="uil uil-check icons"></i>
                                                                                        </a>

                                                                                        <div class="modal" id="active-${ls.setting_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                            <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                                                <div class="modal-content p-3">

                                                                                                    <div class="modal-body border-0 text-center p-2">
                                                                                                        <h1 class="text-success display-1"><i class="uil uil-check-circle"></i></h1>
                                                                                                        <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                                        <p>Do you really want to Activate this Issue Setting? This process cannot be undone.</p>
                                                                                                    </div>
                                                                                                    <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                                        <a href="IssueSettingController?service=changeStatus&settingId=${ls.setting_id}&isActive=0&subjectID=${ls.subject_id}&mode=subject" type="button" class="btn btn-success">Activate</a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>   
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                                <%}%>
                                                                            </c:if>
                                                                            <c:if
                                                                                test="${sessionScope.user.roleId==14||sessionScope.user.roleId==15||sessionScope.user.roleId==16}">
                                                                                <%if (mode.equals("class")) {%>
                                                                            <td
                                                                                class="text-center p-3">
                                                                                <a href="IssueSettingController?service=classSettingUpdate&setting_id=${ls.setting_id}&subjectID=${ls.subject_id}&classId=${ls.class_id}&mode=class"
                                                                                   class="btn btn-icon btn-pills btn-soft-primary"><i
                                                                                        class="uil uil-pen"></i></a>
                                                                                    <c:choose>
                                                                                        <c:when test="${ls.isActive==1}">
                                                                                        <a data-bs-toggle="modal" data-bs-target="#inactive-${ls.setting_id}"
                                                                                           class="btn btn-icon btn-pills btn-soft-danger"
                                                                                           title="Inactive "
                                                                                           ><i class="uil uil-times icons"></i></a>
                                                                                        <div class="modal" id="inactive-${ls.setting_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                            <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                                                <div class="modal-content p-3">

                                                                                                    <div class="modal-body border-0 text-center p-2">
                                                                                                       <h1 class="text-danger display-1"><i class="uil uil-times-circle"></i></h1>
                                                                                                        <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                                        <p>Do you really want to Deactivate this Issue Setting? This process cannot be undone.</p>
                                                                                                    </div>
                                                                                                    <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                                        <a href="IssueSettingController?service=changeClassSettingStatus&settingId=${ls.setting_id}&subjectID=${ls.subject_id}&classID=${ls.class_id}&mode=class&isActive=1" class="btn btn-danger">Deactivate</a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div> 
                                                                                    </c:when>
                                                                                    <c:otherwise>   
                                                                                        <a data-bs-toggle="modal" data-bs-target="#active-${ls.setting_id}"
                                                                                           class="btn btn-icon btn-pills btn-soft-success"
                                                                                           title="Active "
                                                                                           >
                                                                                            <i class="uil uil-check icons"></i>
                                                                                        </a>
                                                                                        <div class="modal" id="active-${ls.setting_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                            <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                                                <div class="modal-content p-3">

                                                                                                    <div class="modal-body border-0 text-center p-2">
                                                                                                          <h1 class="text-success display-1"><i class="uil uil-check-circle"></i></h1>
                                                                                                        <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                                        <p>Do you really want to Activate this Issue Setting? This process cannot be undone.</p>
                                                                                                    </div>
                                                                                                    <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                                        <a href="IssueSettingController?service=changeClassSettingStatus&settingId=${ls.setting_id}&subjectID=${ls.subject_id}&classID=${ls.class_id}&mode=class&isActive=0" type="button" class="btn btn-success">Activate</a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>   
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                                <%}%>
                                                                            </c:if>

                                                                            <c:if
                                                                                test="${sessionScope.user.roleId==14||sessionScope.user.roleId==15||sessionScope.user.roleId==16}">
                                                                                <%if (mode.equals("project")) {%>
                                                                            <td
                                                                                class="text-center p-3">
                                                                                <a href="IssueSettingController?service=projectSettingUpdate&setting_id=${ls.setting_id}&projectID=${ls.project_id}&mode=project"
                                                                                   class="btn btn-icon btn-pills btn-soft-primary"><i
                                                                                        class="uil uil-pen"></i></a>
                                                                                    <c:choose>
                                                                                        <c:when test="${ls.isActive==1}">
                                                                                        <a data-bs-toggle="modal" data-bs-target="#inactive-${ls.setting_id}"
                                                                                           class="btn btn-icon btn-pills btn-soft-danger"
                                                                                           title="Inactive "
                                                                                           ><i class="uil uil-times icons"></i></a>
                                                                                        <div class="modal" id="inactive-${ls.setting_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                            <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                                                <div class="modal-content p-3">

                                                                                                    <div class="modal-body border-0 text-center p-2">
                                                                                                        <h1 class="text-danger display-1"><i class="uil uil-times-circle"></i></h1>
                                                                                                        <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                                        <p>Do you really want to Deactivate this Issue Setting? This process cannot be undone.</p>
                                                                                                    </div>
                                                                                                    <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                                        <a href="IssueSettingController?service=changeProjectSettingStatus&settingId=${ls.setting_id}&projectID=${ls.project_id}&mode=project&isActive=1" class="btn btn-danger">Deactivate</a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div> 
                                                                                    </c:when>
                                                                                    <c:otherwise>   
                                                                                        <a data-bs-toggle="modal" data-bs-target="#active-${ls.setting_id}"
                                                                                           class="btn btn-icon btn-pills btn-soft-success"
                                                                                           title="Active "
                                                                                           >
                                                                                            <i class="uil uil-check icons"></i>
                                                                                        </a>
                                                                                        <div class="modal" id="active-${ls.setting_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                            <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                                                <div class="modal-content p-3">

                                                                                                    <div class="modal-body border-0 text-center p-2">
                                                                                                         <h1 class="text-success display-1"><i class="uil uil-check-circle"></i></h1>
                                                                                                        <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                                        <p>Do you really want to Activate this Issue Setting? This process cannot be undone.</p>
                                                                                                       
                                                                                                    </div>
                                                                                                    <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                                        <a href="IssueSettingController?service=changeProjectSettingStatus&settingId=${ls.setting_id}&projectID=${ls.project_id}&mode=project&isActive=0" type="button" class="btn btn-success">Activate</a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>   
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                                <%}%>
                                                                            </c:if>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- End Table-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END OF BODY -->
                        <%if (mode.equals("class")) {%>
                        <div style="display: none"></div>
                        <!-- PAGINATION END -->
                        <%} else if (mode.equals("subject")) {%>
                        <div style="display: none"></div>
                        <%}%>
                        <!-- Footer Start -->
                        <%@include file="../layout/footer.jsp" %>
                        <!--end footer-->
                    </div>
                </div>
            </main>
            <!--End Main" -->
            <!-- Model add Setting(subject) -->
            <c:if
                test="${sessionScope.user.roleId==15||sessionScope.user.roleId==14||sessionScope.user.roleId==16}">
                <%if (mode.equals("subject")) {%>
                <div class="modal fade" id="addSetting" tabindex="-1"
                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header border-bottom p-3">
                                <h5 class="modal-title" id="exampleModalLabel">Add new
                                    issue</h5>
                                <button type="button" class="btn-close"
                                        data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-3 pt-4">
                                <form action="IssueSettingController">
                                    <input type="hidden" name="service"
                                           value="addSubjectSetting">
                                    <div class="row">

                                        <% String subject_id = request.getParameter("subjectID");
                                        %>
                                        <input name="subject_id" id="name"
                                               type="hidden" class="form-control"
                                               value="<%=subject_id%>" readonly="">


                                        <div class="col-lg-6 col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Issue
                                                    Type<span
                                                        class="text-danger">*</span></label>
                                                <input name="issueType" id="part"
                                                       type="text" class="form-control"
                                                       placeholder="input type of issue"
                                                       required="">
                                            </div>
                                        </div><!--end col-->
                                        <div class="col-lg-6 col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Issue
                                                    Status<span
                                                        class="text-danger">*</span></label>
                                                <input name="issueStatus"
                                                       id="weight" type="text"
                                                       class="form-control"
                                                       placeholder="input status of issue"
                                                       required="">
                                            </div>
                                        </div><!--end col-->
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label
                                                    class="form-label">Description</label>
                                                <textarea name="description"
                                                          id="description" rows="4"
                                                          class="form-control"
                                                          placeholder="your description..."></textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <button type="submit" name="submit"
                                                        class="btn btn-primary"
                                                        value="">Add Subject
                                                    Setting</button>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <%} else if (mode.equals("class")) {%>
                <div class="modal fade" id="addSetting" tabindex="-1"
                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header border-bottom p-3">
                                <h5 class="modal-title" id="exampleModalLabel">Add
                                    new issue</h5>
                                <button type="button" class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-3 pt-4">
                                <form action="IssueSettingController">
                                    <input type="hidden" name="service"
                                           value="addClassSetting">
                                    <div class="row">

                                        <% String subject_id = request.getParameter("subjectID");
                                            String class_id = request.getParameter("classId");
                                        %>
                                        <input name="subjectId" id="name"
                                               type="hidden" class="form-control"
                                               value="<%=subject_id%>" readonly="">
                                        <input name="classId" id="name"
                                               type="hidden" class="form-control"
                                               value="<%=class_id%>" readonly="">

                                        <div class="col-lg-6 col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Issue
                                                    Type<span
                                                        class="text-danger">*</span></label>
                                                <input name="issueType"
                                                       id="part" type="text"
                                                       class="form-control"
                                                       placeholder="input type of issue"
                                                       required="">
                                            </div>
                                        </div><!--end col-->
                                        <div class="col-lg-6 col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Issue
                                                    Status<span
                                                        class="text-danger">*</span></label>
                                                <input name="issueStatus"
                                                       id="weight" type="text"
                                                       class="form-control"
                                                       placeholder="input status of issue"
                                                       required="">
                                            </div>
                                        </div><!--end col-->
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label
                                                    class="form-label">Description</label>
                                                <textarea name="description"
                                                          id="description" rows="4"
                                                          class="form-control"
                                                          placeholder="your description..."></textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <button type="submit"
                                                        name="submit"
                                                        class="btn btn-primary"
                                                        value="">Add
                                                    Setting</button>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
            </c:if>
            <c:if
                test="${sessionScope.user.roleId==14||sessionScope.user.roleId==15||sessionScope.user.roleId==16}">

                <%if (mode.equals("project")) {%>
                <div class="modal fade" id="addSetting" tabindex="-1"
                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header border-bottom p-3">
                                <h5 class="modal-title" id="exampleModalLabel">Add new
                                    issue</h5>
                                <button type="button" class="btn-close"
                                        data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-3 pt-4">
                                <form action="IssueSettingController">
                                    <input type="hidden" name="service"
                                           value="addProjectSetting">
                                    <div class="row">

                                        <% String projectID = request.getParameter("projectID");
                                        %>
                                        <input name="projectID" id="name"
                                               type="hidden" class="form-control"
                                               value="<%=projectID%>" readonly="">

                                        <div class="col-lg-6 col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Issue
                                                    Type<span
                                                        class="text-danger">*</span></label>
                                                <input name="issueType" id="part"
                                                       type="text" class="form-control"
                                                       placeholder="input type of issue"
                                                       required="">
                                            </div>
                                        </div><!--end col-->
                                        <div class="col-lg-6 col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Issue
                                                    Status<span
                                                        class="text-danger">*</span></label>
                                                <input name="issueStatus"
                                                       id="weight" type="text"
                                                       class="form-control"
                                                       placeholder="input status of issue"
                                                       required="">
                                            </div>
                                        </div><!--end col-->
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label
                                                    class="form-label">Description</label>
                                                <textarea name="description"
                                                          id="description" rows="4"
                                                          class="form-control"
                                                          placeholder="your description..."></textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <button type="submit" name="submit"
                                                        class="btn btn-primary"
                                                        value="">Add Setting</button>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
            </c:if>

            <!-- Model add Setting(Class) -->
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
        <!--       sort-->

    </body>

</html>