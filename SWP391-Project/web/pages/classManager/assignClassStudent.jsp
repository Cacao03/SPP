<%-- 
    Document   : assignClassMilestone
    Created on : Oct 8, 2023, 5:21:47 PM
    Author     : Đàm Quang Chiến
--%>


<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <!-- Date picker -->
        <link rel="stylesheet" href="assests/css/flatpickr.min.css">
        <link href="assests/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assests/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assests/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assests/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            #nav-class-students {
                background-color: #007bff; /* Change to your desired background color */
                color: #fff !important; /* Change to your desired text color */
                /* Add any other styles you want to apply to the active link */
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
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Assigned Class Setting</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="classManager">Assigned Classes Management</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Class Students</li>
                                </ul>
                            </nav>
                        </div>
                        <c:if test="${not empty requestScope.fail}">
                            <div class="alert alert-warning" role="alert">
                                <span class="p-3">${requestScope.fail}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty requestScope.success}">
                            <div class="alert alert-success" role="alert">
                                <span class="p-3">${requestScope.success}</span>
                            </div>
                        </c:if>

                        <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">

                            <div class="avatar-profile d-flex margin-nagative mt-n5 position-relative ps-3">
                                <div class="mt-4 ms-3 pt-3 w-75 d-flex">
                                    <h3 class="mt-3">${requestScope.assignClass.classCode}</h3>
                                </div>
                            </div>    
                            <div class="row ">
                                <div class="col-12">
                                    <div class="card border-0 rounded-0 p-2">

                                        <%@include file="../layout/assignedClassNavigation.jsp" %>
                                        <div class="row w-100 align-items-center">
                                            <!-- Search Bar -->
                                            <div class="col-md-4">
                                                <form role="search" method="get" action="classManager" class="search-form">
                                                    <div class="input-group">
                                                        <input type="text" class="form-control rounded-pill" name="searchVal" value="${searchVal}" id="name" placeholder="Search Keywords...">
                                                        <input type="hidden" class="form-control rounded-pill" name="isFilter" value="search">
                                                        <input type="hidden" name="mode" value="classStudent">
                                                        <input type="hidden" name="classId" value="${assignClass.classId}">
                                                        <div class="input-group-append">
                                                            <button type="submit" class="btn btn-pills" title="Search">
                                                                <i class="fas fa-search"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="col-md-7">
                                                <!-- Filter 1 -->
                                                <form action="classManager" method="GET" id="sortForm">
                                                    <!-- Hidden input fields for additional parameters -->
                                                    <input type="hidden" name="mode" value="classStudent">
                                                    <input type="hidden" name="sortType" value="">
                                                    <input type="hidden" name="classId" value="${assignClass.classId}">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <select class="form-select" id="filter1" onchange="sortForm('project')" name="sortVal">
                                                                <option value="" hidden="">Filter Groups</option>
                                                                <option value="">All Groups</option>
                                                                <%
                                                                    ResultSet listProject = (ResultSet) request.getAttribute("listProject");
                                                                    while (listProject.next()) {
                                                                %>
                                                                <option value="<%=listProject.getInt("project_id")%>"><%=listProject.getString("project_code")%></option>
                                                                <%
                                                                    }
                                                                %>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <select class="form-select" id="filter2" name="sortVal1" onchange="sortForm('status')">
                                                                <option value="" hidden="">Filter Status</option>
                                                                <option value="">All Statuses</option>
                                                                <option value="1">Active</option>
                                                                <option value="0">In Active</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <!-- Dropdown Menu -->
                                            <div class="col-md-1 d-flex justify-content-end p-0">
                                                <div class="dropdown">

                                                    <i class="fas fa-ellipsis-v dropdown-toggle" style="cursor: pointer" data-toggle="dropdown"></i>

                                                    <div class="dropdown-menu " style="margin-right: 20px">

                                                        <!-- Anchor tag that triggers the input field when clicked -->
                                                        <a class="dropdown-item" href="/SWP391-Project/template/Template.rar">Download Import Template</a>
                                                        <a href="#" class="dropdown-item" id="importLink">Import Excel File</a>

                                                        <!-- Hidden form to be submitted via JavaScript -->
                                                        <form id="uploadForm" action="classManager" method="post" enctype="multipart/form-data" style="display:none;">
                                                            <input type="hidden" name="mode" value="import">
                                                            <input type="hidden" name="classId" value="${assignClass.classId}">
                                                            <input type="file" id="fileUpload" name="file" style="display:none;" />
                                                        </form>
                                                        <a class="dropdown-item" href="classManager?mode=classStudent&option=export&classId=${assignClass.classId}">Export to excel file</a>
                                                        <button onclick="getListStudent(${assignClass.classId})" class="dropdown-item">Add New Student</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-content mt-2" id="pills-tabContent">
                                            <div class="tab-pane fade show active" id="pills-overview" role="tabpanel"
                                                 aria-labelledby="overview-tab">
                                                <table id="myTable" class="table mb-0 table-hover table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <th onclick ="sortTable(0)" class="border-bottom p-3" style=" cursor: pointer">
                                                                No.<i class="fas fa-sort"></i></th>                                               
                                                            <th onclick ="sortTable(1)" class="border-bottom p-3" style="min-width: 180px; cursor: pointer">
                                                                Student Name<i class="fas fa-sort"></i></th>   
                                                            <th onclick ="sortTable(2)" class="border-bottom p-3 " style="min-width: 150px; cursor: pointer">
                                                                Group<i class="fas fa-sort"></i></th>
                                                            <th onclick ="sortTable(3)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer">
                                                                Status<i class="fas fa-sort"></i></th>
                                                            <th class="border-bottom p-3"style="min-width: 100px;">Actions</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${requestScope.listClassSt}" var="classSt" varStatus="status">
                                                            <tr>
                                                                <td class="p-3">
                                                                    ${status.index + 1}
                                                                </td>
                                                                <td class="p-3">
                                                                    ${classSt.studentName}
                                                                </td>
                                                                <td class="p-3">
                                                                    ${classSt.groupName}
                                                                </td>
                                                                <c:if test="${classSt.isActive == 1}">
                                                                    <td class="p-3 text-success">Active</td>
                                                                </c:if>
                                                                <c:if test="${classSt.isActive == 0}">
                                                                    <td class="p-3 text-danger">InActive</td>
                                                                </c:if>
                                                                <td>
                                                                    <button onclick="updateStudent(${assignClass.classId}, ${classSt.id}, ${classSt.groupId})"
                                                                            class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-eye"></i></button>  
                                                                        <c:choose>
                                                                            <c:when test="${classSt.isActive == 1}">
                                                                            <a href="classManager?mode=classStudent&option=changeStatus&classId=${classSt.classId}&stId=${classSt.id}&status=0" class="btn btn-icon btn-pills btn-soft-danger" title="Inactive"  data-bs-toggle="modal" data-bs-target="#confirmationModal">
                                                                                <i class="uil uil-times icons"></i>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="classManager?mode=classStudent&option=changeStatus&classId=${classSt.classId}&stId=${classSt.id}&status=1" class="btn btn-icon btn-pills btn-soft-success" title="Active" data-bs-toggle="modal" data-bs-target="#confirmationModal">
                                                                                <i class="uil uil-check icons"></i>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>

                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>

                                                <div class="row text-center">
                                                    <div class="col-12 mt-4">
                                                        <div class="d-md-flex align-items-center text-center justify-content-between">
                                                            <span class="text-muted me-3"></span>
                                                            <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                                                <c:forEach begin="1" end="${endP}" var="i">
                                                                    <li class="page-item"><a class="page-link" href="classManager?mode=classStudent&classId=${assignClass.classId}&index=${i}&sortType=${sortType}&sortValue=${sortValue}">${i}</a></li>         
                                                                    </c:forEach>
                                                            </ul>
                                                        </div>
                                                    </div><!--end col-->
                                                </div>	
                                            </div><!--end teb pane-->
                                        </div><!--end tab content-->
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>
                    </div>
                </div><!--end container-->
                <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-labelledby="confirmationModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmationModalLabel">Confirmation</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to save changes?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" id="confirmAction">Confirm</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="addStudentModal" tabindex="-1" role="dialog" aria-labelledby="addStudentModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmationModalLabel">Add New Student</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body" id="modal-list-student">

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" onclick="submitAddForm()" id="addStudentBtn">Confirm</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="updateStudentModal" tabindex="-1" role="dialog" aria-labelledby="updateStudentModal" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmationModalLabel">Update Student</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body" id="modal-update-student">

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" onclick="submitUpdateForm()" id="addStudentBtn">Update</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- END OF BODY -->



                <!-- Footer Start -->
                <%@include file ="../layout/footer.jsp" %>
                <!--end footer-->


            </main>
            <!--End Page-content" -->
        </div>
        <!-- End of page-wrapper -->


        <!-- javascript -->
        <script src="assests/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assests/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assests/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assests/js/app.js"></script>

        <script>
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
                                    $(document).on('change', '#masterCheckbox', function () {
                                        $('.userCheckbox').prop('checked', $(this).is(':checked'));
                                    });
                                    $(document).on('change', '.userCheckbox', function () {
                                        if ($('.userCheckbox:checked').length === $('.userCheckbox').length) {
                                            $('#masterCheckbox').prop('checked', true);
                                        } else {
                                            $('#masterCheckbox').prop('checked', false);
                                        }
                                    });
                                    function submitAddForm() {
                                        $('#userForm').submit();
                                    }
                                    function submitUpdateForm() {
                                        $('#modalUpdateForm').submit();
                                    }
                                    function getListStudent(classId) {
                                        $.ajax({
                                            url: "classManager?mode=classStudent&option=getListStudent&classId=" + classId,
                                            type: "GET",
                                        }).done(function (result) {
                                            $("#modal-list-student").html(result);
                                            $('#addStudentModal').modal('show');
                                        }).fail(function (jqXHR, textStatus, errorThrown) {
                                            console.error("Request failed: " + textStatus + ", " + errorThrown);
                                        });
                                    }
                                    function updateStudent(classId, classStId, projectId) {
                                        $.ajax({
                                            url: "classManager?mode=classStudent&option=update&classId=" + classId + "&stId=" + classStId + "&$projectId="+projectId,
                                            type: "GET",
                                        }).done(function (result) {
                                            $("#modal-update-student").html(result);
                                            $('#updateStudentModal').modal('show');
                                        }).fail(function (jqXHR, textStatus, errorThrown) {
                                            console.error("Request failed: " + textStatus + ", " + errorThrown);
                                        });
                                    }
                                    function sortForm(type) {
                                        // Get the sortType hidden input and update its value based on the changed select element
                                        document.querySelector('input[name="sortType"]').value = type;
                                        // Submit the form                                        
                                        document.getElementById("sortForm").submit();
                                    }
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
                                    function sortTable2(n) {
                                        var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                                        table = document.getElementById("myTable2");
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
                                    function searchStudent(searchKey) {
                                        // Convert search key to lowercase for case-insensitive search
                                        searchKey = searchKey.toLowerCase();

                                        // Get all rows in the table body
                                        var tableRows = document.querySelectorAll("#myTable2 tbody tr");

                                        // Loop through each row and check if it contains the search key
                                        for (var i = 0; i < tableRows.length; i++) {
                                            var rowCells = tableRows[i].querySelectorAll("td");
                                            var rowVisible = false;

                                            // Loop through each cell in the row and check if it contains the search key
                                            for (var j = 0; j < rowCells.length; j++) {
                                                var cellText = rowCells[j].textContent.toLowerCase();

                                                if (cellText.indexOf(searchKey) !== -1) {
                                                    rowVisible = true;
                                                    break;
                                                }
                                            }

                                            // Show or hide the row based on whether it contains the search key
                                            if (rowVisible) {
                                                tableRows[i].style.display = "";
                                            } else {
                                                tableRows[i].style.display = "none";
                                            }
                                        }
                                    }

        </script>
    </body>
</html>
