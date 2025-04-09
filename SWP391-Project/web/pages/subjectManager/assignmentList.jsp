<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dal.SubjectDAO,model.Subject, model.User, java.sql.ResultSet" %>
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
            .card {
                width: 100%;
                max-width: 1500px;
                margin: 0 auto;
            }

            .card-body {
                padding: 1rem;
            }
            #nav-subject-assignment {
                background-color: #007bff; /* Change to your desired background color */
                color: #fff !important; /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
            }
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
                            <h5 class="mb-0">Subject Assignment</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="ClassController">subject
                                            List</a></li>
                                    <li class="breadcrumb-item active"><a href="#">subject
                                            Assignment</a></li>
                                </ul>
                            </nav>
                        </div>


                        <div
                            class="card bg-white rounded shadow overflow-hidden mt-4 border-0">

                            <div class="ms-3 pt-3">
                                <c:forEach items="${listDetails}" var="sd">
                                    <h3 class="mb-0">${sd.subjectCode} </h3>
                                </c:forEach>
                            </div>
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="card p-4 rounded shadow border-0">
                                        <div class="card-body p-1">

                                            <!--Tab list-->
                                            <%@include file="../layout/subjectDetailNavigation.jsp" %>
                                            <!--Tab Content-->


                                            <!--searchBar-->

                                            <div class="row">
                                                <!-- SearchBar -->
                                                <div class="search-bar p-4 d-none d-md-block ms-2">
                                                    <div id="search" class="menu-search mb-0">

                                                        <form action="manageSubjectController" role="search" method="get" id="searchform" class="searchform">

                                                            <input type="hidden" name="service" value="searchAssignmentName">
                                                            <input type="hidden" name="subjectID" value="<%=subject_id%>">
                                                            <div>
                                                                <input type="text" class="form-control border rounded-pill" name="AssignmentName" id="name"
                                                                       placeholder="Search Keywords...">
                                                                <input type="submit" id="searchsubmit" value="Search">
                                                            </div>
                                                        </form>

                                                    </div>
                                                </div>

                                                <div class="col-md-2 mt-4">
                                                    <form action="manageSubjectController">
                                                        <c:forEach items="${listAssignment}" var="la">
                                                            <input type="hidden" name="service" value="filterStatusAssignment">
                                                            <input type="hidden" name="subjectID" value="${la.subjectID}">
                                                        </c:forEach>
                                                        <select name="checkActive" class="form-select" id="checkActive" onchange="this.form.submit()">
                                                            <option value="" hidden="">Status:</option>
                                                            <option value="display">All</option>
                                                            <option value="1">Active</option>
                                                            <option value="0">In Active</option>
                                                        </select>
                                                    </form>
                                                </div>

                                                <div class="col-lg-7 col-md-2 mt-4">
                                                    <div style="float: right; margin-bottom: 20px" class="d-grid">
                                                        <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAssignment">Add Assignment</a>
                                                    </div>
                                                </div>
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
                                                            displayToast("Assignment updated successfully!", true);
                                                        } else if (success === "false") {
                                                            displayToast("Failed to update assignment!", false);
                                                        } else if (success === "true1") {
                                                            displayToast("Assignment added successfully!", true);
                                                        } else if (success === "false1") {
                                                            displayToast("Failed to add assignment!", false);
                                                        }
                                                    });
                                                </script>

                                                <table class="table mb-0 table-center" id="myTable">
                                                    <thead>
                                                        <tr>
                                                            <th class="border-bottom p-3" style="min-width: 50px;">Assignment ID</th>
                                                            <th onclick="sortTable(1)" class="border-bottom p-3" style="min-width: 50px;">Assignment Name<i class="uil uil-sort"></th>
                                                            <th class="border-bottom p-3" style="min-width: 150px;">Weight</th>
                                                            <th class="border-bottom p-3" style="min-width: 150px;">Status</th>
                                                            <th class="border-bottom p-3" style="min-width: 200px; text-align: center;">Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${listAssignment}" var="la">
                                                            <tr>
                                                                <td class="p-3">${la.assign_id}</td>
                                                                <td class="p-3">${la.assign_name}</td>
                                                                <td class="p-3">${la.weight}%</td>
                                                                <c:choose>
                                                                    <c:when test="${la.is_active==1}">
                                                                        <td><span class="badge bg-soft-success">Active</span></td>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <td><span class="badge bg-soft-danger">InActive</span></td>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <td class="text-center p-3">
                                                                    <a href="manageSubjectController?service=assignmentUpdate&assign_id=${la.assign_id}&subjectID=${la.subjectID}" class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-pen"></i></a>
                                                                    <a data-bs-toggle="modal" data-bs-target="#deleteModal-${la.assign_id}" class="btn btn-icon btn-pills btn-soft-danger" value=""><i class="uil uil-trash-alt"></i></a>
                                                                        <c:choose>
                                                                            <c:when test="${la.is_active==1}">
                                                                            <a data-bs-toggle="modal" data-bs-target="#inactive-${la.assign_id}"
                                                                               class="btn btn-icon btn-pills btn-soft-danger"
                                                                               title="Inactive "
                                                                               ><i class="uil uil-times icons"></i></a>
                                                                            <div class="modal" id="inactive-${la.assign_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                                    <div class="modal-content p-3">

                                                                                        <div class="modal-body border-0 text-center p-2">
                                                                                            <h1 class="text-danger display-1"><i class="uil uil-times-circle"></i></h1>
                                                                                            <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                            <p>Do you really want to Deactivate this Assignment? This process cannot be undone.</p>
                                                                                        </div>
                                                                                        <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                            <a href="manageSubjectController?service=changeStatus&assign_id=${la.assign_id}&isActive=1&subjectID=${la.subjectID}" type="button" class="btn btn-danger">Deactivate</a>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div> 
                                                                        </c:when>
                                                                        <c:otherwise>   
                                                                            <a data-bs-toggle="modal" data-bs-target="#active-${la.assign_id}"
                                                                               class="btn btn-icon btn-pills btn-soft-success"
                                                                               title="Active "
                                                                               >
                                                                                <i class="uil uil-check icons"></i>
                                                                            </a>

                                                                            <div class="modal" id="active-${la.assign_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                                <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                                    <div class="modal-content p-3">

                                                                                        <div class="modal-body border-0 text-center p-2">
                                                                                            <h1 class="text-success display-1"><i class="uil uil-check-circle"></i></h1>
                                                                                            <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                            <p>Do you really want to Activate this Assignment? This process cannot be undone.</p>
                                                                                        </div>
                                                                                        <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                            <a href="manageSubjectController?service=changeStatus&assign_id=${la.assign_id}&isActive=0&subjectID=${la.subjectID}" type="button" class="btn btn-success">Activate</a>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>   
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <div class="modal" id="deleteModal-${la.assign_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                        <div class="modal-dialog modal-lg w modal-dialog-centered" style="width: 400px;">
                                                                            <div class="modal-content p-3">
                                                                                <div class="modal-body border-0 text-center p-2">
                                                                                    <h1 style="color: #ffcc00" class="display-1 text-danger"><i class="ri-close-circle-line"></i></h1>
                                                                                    <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                                    <p>Do you really want to DELETE these records? This process cannot be undone.</p>
                                                                                </div>
                                                                                <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                                    <a href="manageSubjectController?service=deleteAssignmentByID&assign_id=${la.assign_id}&subjectID=${la.subjectID}" class="btn btn-primary">Confirm</a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </td>
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
                        <!-- PAGINATION START -->
                        <div class="col-12 mt-4">
                            <div
                                class="d-md-flex align-items-center text-center justify-content-between">
                                <span class="text-muted me-3"></span>
                                <ul
                                    class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <c:forEach begin="1" end="${endAssign}" var="i">
                                        <li class="page-item">
                                            <a class="page-link" href="manageSubjectController?service=displayAssignment&index=${i}&subjectID=${pagingAssignment2.subjectID}">${i}</a>
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

            <div class="modal fade" id="addAssignment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header border-bottom p-3">
                            <h5 class="modal-title" id="exampleModalLabel">Add Assignment</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-3 pt-4">
                            <c:if test="${successMessage != null}">
                                <div class="alert alert-success">${successMessage}</div>
                            </c:if>
                            <form action="manageSubjectController">
                                <c:forEach items="${listDetails}" var="sd">
                                    <input type="hidden" name="service" value="addAssignment">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Assignment Name<span class="text-danger">*</span></label>
                                                <input pattern=".{4,20}" title="must be 4 to 20 characters" name="AssignmentName" id="name" type="text" class="form-control" placeholder="Assignment Name..." required="">
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Weight<span class="text-danger">*</span></label>
                                                <input name="Weight" id="weight" type="number" class="form-control" placeholder="Weight..." required="">
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Description<span class="text-danger">*</span></label>
                                                <textarea name="Description" id="description" rows="4" class="form-control" placeholder="Your description..."></textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <input type="hidden" name="subjectID" value="${sd.subjectId}"></input>
                                                <button type="submit" name="submit" class="btn btn-primary" value="">Add Assignment</button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
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