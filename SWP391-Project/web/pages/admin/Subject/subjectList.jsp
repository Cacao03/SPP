<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dal.SubjectDAO,model.Subject, model.User, java.sql.ResultSet" %>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">

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
            #toast {
                display: none;
                position: fixed;
                top: 80px;
                right: 25px;
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

        <!-- page-wrapper -->
        <div class="page-wrapper doctris-theme toggled">

            <!-- Sidebar wrapper -->
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
                        <div class="row">
                            <div class="col-xl-9 col-md-2">
                                <h5 class="mb-0">Subject Management</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="subjectController?service=listAll">Subject Management</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Subject list</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->

                        </div><!--end row-->    
                        <div class ="row" style="display: flex;">        
                            <c:if test="${sessionScope.user.roleId==14}">
                                <div class="col-md-2 mt-5" style="float:right">
                                    <form action="SubjectController">
                                        <input type="hidden" name="service" value="checkStatus">
                                        <div class="row ">
                                            <div class=""> 

                                                <select name="checkActive" class="form-select" id="checkActive" onchange="this.form.submit()">
                                                    <option value="" hidden="">Status Filter:</option>
                                                    <option value="display">All</option>
                                                    <option value="1">Active</option>
                                                    <option value="0">Inactive</option>
                                                </select>
                                            </div>
                                        </div>
                                    </form>
                                </div>                           
                            </c:if>

                            <c:if test="${sessionScope.user.roleId==15}">
                                <div class="col-md-2 mt-5" style="float:right">
                                    <form action="manageSubjectController">
                                        <input type="hidden" name="service" value="checkStatus">
                                        <div class="row ">
                                            <div class=""> 
                                                <select name="checkActive" class="form-select" id="checkActive" onchange="this.form.submit()">
                                                    <option value="" hidden="">Status Filter:</option>
                                                    <option value="display">All</option>
                                                    <option value="1">Active</option>
                                                    <option value="0">Inactive</option>
                                                </select>
                                            </div>
                                        </div>
                                    </form>
                                </div>                
                            </c:if>
                            <c:if test="${sessionScope.user.roleId==14}">
                                <div class="col-md-2 mt-5" style="float:right">
                                    <form action="manageSubjectController">
                                        <input type="hidden" name="service" value="filterManager">
                                        <div class="row ">
                                            <div class=""> 
                                                <select name="checkManager" class="form-select" id="checkManager" onchange="this.form.submit()">
                                                    <option value="" hidden="">Manager Filter:</option>
                                                    <option value="display">All</option>
                                                    <c:forEach items="${data3}" var="us">
                                                        <option value="${us.userId}">${us.fullName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </form>
                                </div>                
                            </c:if>



                            <div class="search-bar p-0 d-none d-lg-block col-md-2 mt-5 ml-auto">
                                <div id="search" class="menu-search mb-0">
                                    <form role="search" method="get" id="searchform" class="searchform">
                                        <input type="hidden" name="service" value="SearchSubject_Code" >
                                        <div>
                                            <input type="text" class="form-control border rounded-pill" name="search_code" id="name" placeholder="Search Keywords...">
                                            <input type="submit" id="searchsubmit" value="Search">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <c:if test="${sessionScope.user.roleId==14}">
                                <div class="text-md-end col-md-6 mt-5">
                                    <a href="SubjectController?service=insertSubject" class="btn btn-primary" >Add Subject</a>
                                </div><!--end col-->
                            </c:if>
                        </div>
                        <div class="table-responsive bg-white shadow rounded">
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
                                        displayToast("Updated subject successfully!", true);
                                    } else if (isSuccess === "false") {
                                        displayToast("Failed to update subject!", false);
                                    } else if (isSuccess === "true1") {
                                        displayToast("Add subject successfully!", true);
                                    } else if (isSuccess === "false1") {
                                        displayToast("Failed to add subject!", false);
                                    }
                                });
                            </script>
                            <table id="myTable" class="table mb-0 table-center table-bordered">
                                <thead>
                                    <tr>
                                        <th class="border-bottom p-3" style="min-width: 50px;">
                                            ID</th>
                                        <th onclick="sortTable(1)" class="border-bottom p-3" style="min-width: 180px;">
                                            Subject Code<i class="uil uil-sort"></i></th>
                                        <th onclick="sortTable(2)" class="border-bottom p-3" style="min-width: 150px;">
                                            Subject Name<i class="uil uil-sort"></i></th>                                                         
                                        <th class="border-bottom p-3" style="min-width: 150px;">
                                            Manager</th>
                                        <th onclick="sortTable(3)" class="border-bottom p-3" style="min-width: 150px;">
                                            Status<i class="uil uil-sort"></i></th>
                                        <th class="border-bottom p-3"
                                            style="min-width: 200px; text-align: center;">
                                            Actions</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${data}" var="su">
                                    <tbody>
                                        <tr>
                                            <th class="p-3">
                                                ${su.subjectId}</th>
                                            <td class="p-3">
                                                <a href="#" class="text-dark">
                                                    <div class="d-flex align-items-center">
                                                        <span class="ms-2">
                                                            ${su.subjectCode}
                                                        </span>
                                                    </div>
                                                </a>
                                            </td>
                                            <td class="p-3">
                                                ${su.subjectName}</td> 
                                                <c:forEach items="${manageN}" var="us">
                                                    <c:if test="${su.managerID==us.userId}">
                                                    <td class="p-3">
                                                        ${us.fullName}</td>
                                                    </c:if>
                                                </c:forEach>  
                                                <c:choose>
                                                    <c:when test="${su.isActive==1}">    
                                                    <td><span class="badge bg-soft-success">Active</span></td>
                                                </c:when>          
                                                <c:otherwise>    
                                                    <td><span class="badge bg-soft-danger">InActive</span></td>
                                                </c:otherwise>                                                        
                                            </c:choose>
                                            <c:if test="${sessionScope.user.roleId==14}">
                                                <td class="text-center p-3">
                                                    <a href="SubjectController?service=updateSubject&id=${su.subjectId}" class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-pen"></i></a>
                                                    <a href="manageSubjectController?service=displayDetails&subjectID=${su.subjectId}"class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-eye"></i></a>
                                                        <c:choose>
                                                            <c:when test="${su.isActive==1}">
                                                            <a data-bs-toggle="modal" data-bs-target="#inactive-${su.subjectId}"
                                                               class="btn btn-icon btn-pills btn-soft-danger"
                                                               title="Inactive "
                                                               ><i class="uil uil-times icons"></i></a>
                                                            <div class="modal" id="inactive-${su.subjectId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                    <div class="modal-content p-3">

                                                                        <div class="modal-body border-0 text-center p-2">
                                                                            <h1 class="text-danger display-1"><i class="uil uil-times-circle"></i></h1>
                                                                            <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                            <p>Do you really want to Deactivate this user? This process cannot be undone.</p>
                                                                        </div>
                                                                        <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                            <a href="SubjectController?service=changeStatus&id=${su.subjectId}&status=${su.isActive}" type="button" class="btn btn-danger">Deactivate</a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div> 
                                                        </c:when>
                                                        <c:otherwise>   
                                                            <a data-bs-toggle="modal" data-bs-target="#active-${su.subjectId}"
                                                               class="btn btn-icon btn-pills btn-soft-success"
                                                               title="Active "
                                                               >
                                                                <i class="uil uil-check icons"></i>
                                                            </a>

                                                            <div class="modal" id="active-${su.subjectId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                    <div class="modal-content p-3">

                                                                        <div class="modal-body border-0 text-center p-2">
                                                                            <h1 class="text-success display-1"><i class="uil uil-check-circle"></i></h1>
                                                                            <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                            <p>Do you really want to Activate this user? This process cannot be undone.</p>
                                                                        </div>
                                                                        <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                            <a href="SubjectController?service=changeStatus&id=${su.subjectId}&status=${su.isActive}" type="button" class="btn btn-success">Activate</a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>   
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:if>

                                            <c:if test="${sessionScope.user.roleId==15}">
                                                <td class="text-center p-3">
                                                    <a href="manageSubjectController?service=displayDetails&subjectID=${su.subjectId}"
                                                       class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-eye"></i></a>

                                                </td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- END OF BODY -->
                        <c:if test="${sessionScope.user.roleId==14}">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3"></span>

                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:forEach begin="1" end="${endPAdmin}" var="i">
                                            <li class="page-item"><a class="page-link" href="SubjectController?service=display&index=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>

                                </div>
                            </div><!--end col-->
                            <!-- PAGINATION END -->
                        </c:if>
                        <c:if test="${sessionScope.user.roleId==15}">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3"></span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:forEach begin="1" end="${endPSubManager}" var="i">
                                            <li class="page-item"><a class="page-link" href="manageSubjectController?service=display&index=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <!-- PAGINATION END -->
                        </c:if>
                        <!-- Footer Start -->
                        <%@include file="../../layout/footer.jsp" %>
                        <!--end footer-->

                    </div>
                </div>
            </main>
            <!--End Page-content" -->
        </div>
    </body>
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