<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page import="dal.SubjectDAO,model.Subject, model.User, java.sql.ResultSet" %>
            <%@page import="java.util.List" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <title>Student Project Portal Management</title>

                    <!-- favicon -->
                    <link rel="shortcut icon" href="assests/images/logo.png">
                    <!-- Bootstrap -->
                    <link href="assests/css/bootstrap5.0.min.css" rel="stylesheet" />
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
                            top: 120px;
                            right: 50px;
                            background-color: #4CAF50;
                            color: #fff;
                            padding: 15px;
                            border-radius: 5px;
                            text-align: center;
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


                        <%--<%@include file="../layout/subjectmanagerSideBar.jsp" %>--%>
                            <%@include file="../layout/adminSideBar.jsp" %>

                                <!<!-- Main -->
                                    <main class="page-content bg-light">

                                        <!-- HEADER -->
                                        <%@include file="../layout/navbar.jsp" %>
                                            <!-- End of HEADER -->

                                            <div class="container-fluid">
                                                <div class="layout-specing">

                                                    <div class="d-md-flex justify-content-between">
                                                        <c:forEach items="${listDetails}" var="sd">
                                                            <h1 class="mb-0">Subject setting of ${sd.subjectCode}</h1>

                                                            <nav aria-label="breadcrumb"
                                                                class="d-inline-block mt-4 mt-sm-0">
                                                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                                                    <li class="breadcrumb-item"><a
                                                                            href="./manageSubjectController">Subject
                                                                            List</a></li>
                                                                    <li class="breadcrumb-item active"
                                                                        aria-current="page">${sd.subjectCode}</li>
                                                                </ul>
                                                            </nav>
                                                        </c:forEach>
                                                    </div>


                                                    <div
                                                        class="card bg-white rounded shadow overflow-hidden mt-4 border-0">


                                                        <div class="row">
                                                            <div class="col-12 mt-4">
                                                                <div class="card border-0 rounded-0 p-4">


                                                                    <!--Tab list-->
                                                                    <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded shadow overflow-hidden bg-light"
                                                                        id="pills-tab" role="tablist">

                                                                        <!--Tab 1(row)-->
                                                                        <li class="nav-item">
                                                                            <c:forEach items="${listDetails}" var="sd">
                                                                                <a
                                                                                    href="manageSubjectController?service=displayDetails&subjectID=${sd.subjectId}">
                                                                                    <div class="text-body pt-1 pb-1">
                                                                                        <h4
                                                                                            class="title fw-normal mb-0">
                                                                                            General</h4>
                                                                                    </div>
                                                                                </a>
                                                                            </c:forEach>
                                                                        </li>

                                                                        <!--Tab 2(row)-->

                                                                        <li class="nav-item">
                                                                            <c:forEach items="${listDetails}" var="sd">
                                                                                <a
                                                                                    href="manageSubjectController?service=displayAssignment&subjectID=${sd.subjectId}">
                                                                                    <div class="text-body pt-1 pb-1">
                                                                                        <h4
                                                                                            class="title fw-normal mb-0">
                                                                                            Assignments</h4>
                                                                                    </div>
                                                                                </a>
                                                                            </c:forEach>
                                                                        </li>

                                                                        <!--Tab 3(row)-->
                                                                        <li class="nav-item">
                                                                            <c:forEach items="${listDetails}" var="sd">
                                                                                <a class="nav-link rounded-0 active"
                                                                                    id="review-tab"
                                                                                    data-bs-toggle="pill"
                                                                                    href="manageSubjectController?service=displaySubjectSetting&subjectID=${sd.subjectId}"
                                                                                    role="tab"
                                                                                    aria-controls="pills-review"
                                                                                    aria-selected="false">
                                                                                    <div class="text-center pt-1 pb-1">
                                                                                        <h4
                                                                                            class="title fw-normal mb-0">
                                                                                            Subject Setting</h4>
                                                                                    </div>
                                                                                </a>
                                                                            </c:forEach>
                                                                        </li>
                                                                    </ul>
                                                                    <!--Tab Content-->


                                                                    <!--searchBar-->

                                                                    <div class="row ">

                                                                        <!--searchBar-->
                                                                        <div
                                                                            class="search-bar p-4 d-none d-md-block ms-2 ">
                                                                            <div id="search" class="menu-search mb-0">
                                                                                <form action="manageSubjectController"
                                                                                    role="search" method="get"
                                                                                    id="searchform" class="searchform">
                                                                                    <c:forEach items="${listDetails}"
                                                                                        var="sd">
                                                                                        <input type="hidden"
                                                                                            name="service"
                                                                                            value="searchSubjectSetting">
                                                                                        <input type="hidden"
                                                                                            name="subjectID"
                                                                                            value="${sd.subjectId}">
                                                                                    </c:forEach>
                                                                                    <div>
                                                                                        <input type="text"
                                                                                            class="form-control border rounded-pill"
                                                                                            name="settingName" id="name"
                                                                                            placeholder="Search Keywords...">
                                                                                        <input type="submit"
                                                                                            id="searchsubmit"
                                                                                            value="Search">
                                                                                    </div>
                                                                                </form>
                                                                            </div>
                                                                        </div>
                                                                        <!--filter-->
                                                                        <div class="col-md-2 mt-4">
                                                                            <form action="manageSubjectController">
                                                                                <c:forEach items="${listDetails}"
                                                                                    var="sd">
                                                                                    <input type="hidden" name="service"
                                                                                        value="filterIssueType">
                                                                                    <input type="hidden"
                                                                                        name="subjectID"
                                                                                        value="${sd.subjectId}">
                                                                                </c:forEach>

                                                                                <select name="issueType"
                                                                                    class="form-select" id="checkActive"
                                                                                    onchange="this.form.submit()">
                                                                                    <option value="" hidden="">Issue
                                                                                        Type:</option>
                                                                                    <option value="display">All</option>
                                                                                    <c:forEach
                                                                                        items="${requestScope.listType}"
                                                                                        var="v">
                                                                                        <option value="${v.title}">
                                                                                            ${v.title}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </form>
                                                                        </div>
                                                                        <div class="col-md-2 mt-4">
                                                                            <form action="manageSubjectController">
                                                                                <c:forEach items="${listDetails}"
                                                                                    var="sd">
                                                                                    <input type="hidden" name="service"
                                                                                        value="filterIssueStatus">
                                                                                    <input type="hidden"
                                                                                        name="subjectID"
                                                                                        value="${sd.subjectId}">
                                                                                </c:forEach>
                                                                                <select name="issueStatus"
                                                                                    class="form-select" id="checkActive"
                                                                                    onchange="this.form.submit()">
                                                                                    <option value="" hidden="">Issue
                                                                                        Status:</option>
                                                                                    <option value="display">All</option>
                                                                                    <c:forEach
                                                                                        items="${requestScope.listStatus}"
                                                                                        var="s">
                                                                                        <option value="${s.status}">
                                                                                            ${s.status}</option>
                                                                                    </c:forEach>
                                                                                </select>

                                                                            </form>
                                                                        </div>
                                                                        <!--ADD-->
                                                                        <div class="col-lg-5 col-md-2 mt-4">
                                                                            <div style="float: right; margin-bottom: 20px "
                                                                                class="d-grid">
                                                                                <a class="btn btn-primary"
                                                                                    data-bs-toggle="modal"
                                                                                    data-bs-target="#addSubjectSetting">Add
                                                                                    subject setting</a>
                                                                            </div>
                                                                        </div><!--end col-->
                                                                    </div>


                                                                    <!-- End searchbar -->

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
                                                                    <div
                                                                        class="table-responsive bg-white shadow rounded">
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

                                                                        <div
                                                                            class="table-responsive bg-white shadow rounded">

                                                                            <table class="table mb-0 table-center"
                                                                                id="myTable">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th class="border-bottom p-3"
                                                                                            style="min-width: 50px;">
                                                                                            Setting ID</th>
                                                                                        <th class="border-bottom p-3"
                                                                                            style="min-width: 50px;">
                                                                                            Subject ID</th>
                                                                                        <th onclick="sortTable(3)"
                                                                                            class="border-bottom p-3"
                                                                                            style="min-width: 150px;">
                                                                                            Issue Type <i
                                                                                                class="uil uil-sort"></i>
                                                                                        </th>
                                                                                        <th onclick="sortTable(4)"
                                                                                            class="border-bottom p-3"
                                                                                            style="min-width: 150px;">
                                                                                            Issue Status <i
                                                                                                class="uil uil-sort"></i>
                                                                                        </th>
                                                                                        <th class="border-bottom p-3"
                                                                                            style="min-width: 150px;">
                                                                                            Created At</th>
                                                                                        <th class="border-bottom p-3"
                                                                                            style="min-width: 200px; text-align: center;">
                                                                                            Actions</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <c:forEach
                                                                                        items="${listSubjectSetting}"
                                                                                        var="ls">
                                                                                        <tr>
                                                                                            <td class="p-3">
                                                                                                ${ls.setting_id}</td>
                                                                                            <td class="p-3">
                                                                                                ${ls.subject_id}</td>
                                                                                            <td class="p-3">${ls.title}
                                                                                            </td>
                                                                                            <td class="p-3">${ls.status}
                                                                                            </td>
                                                                                            <td class="p-3">
                                                                                                ${ls.create_at}</td>
                                                                                            <td class="text-center p-3">
                                                                                                <a href="manageSubjectController?service=subjectSettingUpdate&setting_id=${ls.setting_id}&subjectID=${ls.subject_id}"
                                                                                                    class="btn btn-icon btn-pills btn-soft-primary"><i
                                                                                                        class="uil uil-pen"></i></a>
                                                                                                <a data-bs-toggle="modal"
                                                                                                    data-bs-target="#deleteModal-${ls.setting_id}"
                                                                                                    class="btn btn-icon btn-pills btn-soft-danger"
                                                                                                    value=""><i
                                                                                                        class="uil uil-trash-alt"></i></a>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <div class="modal"
                                                                                            id="deleteModal-${ls.setting_id}"
                                                                                            tabindex="-1"
                                                                                            aria-labelledby="exampleModalLabel"
                                                                                            aria-hidden="true">
                                                                                            <div class="modal-dialog modal-lg w modal-dialog-centered "
                                                                                                style="width:400px;">
                                                                                                <div
                                                                                                    class="modal-content p-3">

                                                                                                    <div
                                                                                                        class="modal-body border-0 text-center p-2">
                                                                                                        <h1 style="color: #ffcc00"
                                                                                                            class=" display-1 text-danger">
                                                                                                            <i
                                                                                                                class="ri-close-circle-line"></i>
                                                                                                        </h1>
                                                                                                        <h4 class="modal-title"
                                                                                                            id="exampleModalLabel">
                                                                                                            Are you sure
                                                                                                        </h4>
                                                                                                        <p>Do you really
                                                                                                            want to
                                                                                                            DELETE these
                                                                                                            records?
                                                                                                            This process
                                                                                                            cannot be
                                                                                                            undone.</p>
                                                                                                    </div>
                                                                                                    <div
                                                                                                        class="modal-footer border-0 align-items-center justify-content-center">
                                                                                                        <button
                                                                                                            type="button"
                                                                                                            class="btn btn-secondary"
                                                                                                            data-bs-dismiss="modal">Cancel</button>
                                                                                                        <a href="manageSubjectController?service=deleteSettingById&setting_id=${ls.setting_id}&subjectID=${ls.subject_id}"
                                                                                                            class="btn btn-primary">Confirm</a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:forEach>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                        <!-- End Table-->
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!-- PAGINATION START -->
                                                        <div class="col-12 mt-4">
                                                            <div
                                                                class="d-md-flex align-items-center text-center justify-content-between">
                                                                <span class="text-muted me-3">Showing 1 - 10 out of
                                                                    50</span>
                                                                <ul
                                                                    class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                                                    <c:forEach begin="1" end="${endSubSetting}" var="i">
                                                                        <li class="page-item"><a class="page-link"
                                                                                href="manageSubjectController?service=displaySubjectSetting&index=${i}&subjectID=${pagingSubject2.subject_id}">${i}</a>
                                                                        </li>
                                                                    </c:forEach>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <!-- PAGINATION END -->
                                                    </div>
                                                </div>
                                                <!-- END OF BODY -->

                                                <!-- Footer Start -->
                                                <%@include file="../layout/footer.jsp" %>
                                                    <!--end footer-->

                                    </main>
                                    <!--End Main" -->

                                    <div class="modal fade" id="addSubjectSetting" tabindex="-1"
                                        aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header border-bottom p-3">
                                                    <h5 class="modal-title" id="exampleModalLabel">Add Subject Setting
                                                    </h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body p-3 pt-4">
                                                    <% if (request.getAttribute("noti") !=null) {%>
                                                        <div class="alert alert-danger">
                                                            <%= request.getAttribute("noti")%>
                                                        </div>
                                                        <% }%>
                                                            <form action="manageSubjectController">

                                                                <input type="hidden" name="service"
                                                                    value="addSubjectSetting">
                                                                <div class="row">
                                                                    <div class="col-lg-4">
                                                                        <div class="mb-3">

                                                                            <label class="form-label">Subject ID<span
                                                                                    class="text-danger">*</span></label>
                                                                            <% String
                                                                                subject_id=request.getParameter("subjectID");
                                                                                %>
                                                                                <input name="subject_id" id="name"
                                                                                    type="number" class="form-control"
                                                                                    value="<%=subject_id%>" readonly="">

                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-4 col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Issue Type<span
                                                                                    class="text-danger">*</span></label>
                                                                            <input name="issueType" id="part"
                                                                                type="text" class="form-control"
                                                                                placeholder="input type of issue"
                                                                                required="">
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-4 col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Issue Status<span
                                                                                    class="text-danger">*</span></label>
                                                                            <input name="issueStatus" id="weight"
                                                                                type="text" class="form-control"
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
                                                                                class="btn btn-primary" value="">Add
                                                                                Subject Setting</button>

                                                                        </div>

                                                                    </div><!--end col-->
                                                                </div><!--end row-->

                                                            </form>
                                                </div>
                                            </div>
                                        </div>
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
                    <!--       sort-->
                    <script>
                        function sortTable(n) {
                            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                            table = document.getElementById("myTable");
                            switching = true;
                            //Set the sorting direction to ascending:
                            dir = "asc";
                            /*Make a loop that will continue until
                             no switching has been done:*/
                            while (switching) {
                                //start by saying: no switching is done:
                                switching = false;
                                rows = table.rows;
                                /*Loop through all table rows (except the
                                 first, which contains table headers):*/
                                for (i = 1; i < (rows.length - 1); i++) {
                                    //start by saying there should be no switching:
                                    shouldSwitch = false;
                                    /*Get the two elements you want to compare,
                                     one from current row and one from the next:*/
                                    x = rows[i].getElementsByTagName("TD")[n];
                                    y = rows[i + 1].getElementsByTagName("TD")[n];
                                    /*check if the two rows should switch place,
                                     based on the direction, asc or desc:*/
                                    if (dir == "asc") {
                                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                            //if so, mark as a switch and break the loop:
                                            shouldSwitch = true;
                                            break;
                                        }
                                    } else if (dir == "desc") {
                                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                                            //if so, mark as a switch and break the loop:
                                            shouldSwitch = true;
                                            break;
                                        }
                                    }
                                }
                                if (shouldSwitch) {
                                    /*If a switch has been marked, make the switch
                                     and mark that a switch has been done:*/
                                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                                    switching = true;
                                    //Each time a switch is done, increase this count by 1:
                                    switchcount++;
                                } else {
                                    /*If no switching has been done AND the direction is "asc",
                                     set the direction to "desc" and run the while loop again.*/
                                    if (switchcount == 0 && dir == "asc") {
                                        dir = "desc";
                                        switching = true;
                                    }
                                }
                            }
                        }
                    </script>
                </body>

                </html>