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


            <%--<%@include file="../layout/subjectManagerSidebar.jsp" %>--%>
            <%@include file="../layout/adminSideBar.jsp" %>

            <!<!-- Main -->
            <main class="page-content bg-light">

                <!-- HEADER -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End of HEADER -->

                <!-- BODY -->
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <!--searchBar-->
                                    <div class="search-bar p-0 d-none d-md-block ms-2 ">
                                        <div id="search" class="menu-search mb-0">
                                            <form action="manageSubjectController" role="search" method="get" id="searchform" class="searchform">
                                                <input type="hidden" name="service" value="SearchSubject_Code" >
                                                <div>
                                                    <input type="text" class="form-control border rounded-pill" name="search_code" id="name" placeholder="Search Keywords...">
                                                    <input type="submit" id="searchsubmit" value="Search">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <!-- End searchbar -->


                                    <!--StartTable-->
                                    <div class="table-responsive bg-white shadow rounded">
                                        <table id="myTable" class="table mb-0 table-center table-bordered">
                                            <thead>
                                                <tr>
                                                    <th class="border-bottom p-3" style="min-width: 50px;">
                                                        ID</th>
                                                    <th onclick="sortTable(1)" class="border-bottom p-3" style="min-width: 180px;">
                                                        Subject Code</th>
                                                    <th onclick="sortTable(2)" class="border-bottom p-3" style="min-width: 150px;">
                                                        Subject Name</th>                                                         
                                                    <th class="border-bottom p-3" style="min-width: 150px;">
                                                        Manager</th>
                                                    <th class="border-bottom p-3" style="min-width: 150px;">
                                                        Update At</th>
                                                    <th onclick="sortTable(3)" class="border-bottom p-3" style="min-width: 150px;">
                                                        Status</th>
                                                    <th class="border-bottom p-3"
                                                        style="min-width: 200px; text-align: center;">
                                                        Actions</th>
                                                </tr>
                                            </thead>
                                            <c:forEach items="${listSubject}" var="su">
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
                                                        <td class="p-3"> ${su.updateAt}</td>
                                                        <c:choose>
                                                            <c:when test="${su.isActive==1}">    
                                                                <td><span class="badge bg-soft-success">Active</span></td>
                                                            </c:when>          
                                                            <c:otherwise>    
                                                                <td><span class="badge bg-soft-danger">InActive</span></td>
                                                            </c:otherwise>
                                                        </c:choose> 
                                                        <td class="text-center p-3">
                                                            <a href="manageSubjectController?service=displayDetails&subjectID=${su.subjectId}"
                                                               class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-exclamation-circle"></i></a>

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
                        <!-- PAGINATION START -->
                        <div class="col-12 mt-4">
                            <div class="d-md-flex align-items-center text-center justify-content-between">
                                <span class="text-muted me-3">Showing 1 - 10 out of 50</span>
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <c:forEach begin="1" end="${endP}" var="i">
                                        <li class="page-item"><a class="page-link" href="manageSubjectController?service=display&index=${i}">${i}</a>
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