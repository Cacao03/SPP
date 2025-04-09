<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dal.SystemSettingDAO,model.Subject,java.sql.ResultSet,enums.SettingGroup" %>
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
                            <div class="col-xl-9 col-lg-6 col-md-4">
                                <h5 class="mb-0">Setup System Setting </h5>
                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="./SystemSettingController"> > System Setting List</a></li>
                                    </ul>
                                </nav>
                            </div><!--end col-->

                            <div class="col-xl-3 col-lg-6 col-md-8 mt-4 mt-md-0">
                                <div class="justify-content-md-end">
                                    <form>
                                        <div class="row justify-content-between align-items-center">
                                            <div class="col-sm-12 col-md-5">
                                                <div class="mb-0 position-relative">

                                                </div>
                                            </div><!--end col-->

                                            <div class="col-sm-12 col-md-7 mt-4 mt-sm-0">
                                                <div class="d-grid">
                                                    <a href="./SystemSettingController?service=addSystemSetting" class="btn btn-primary" >Add System Setting</a>
                                                </div>
                                            </div>
                                            <!--end col-->
                                        </div><!--end row-->
                                    </form><!--end form-->
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row mt-5"> <!-- ROW2-->
                            <div class="col-md-3">
                                <form action="SystemSettingController">
                                    <input type="hidden" name="service" value="findSysyemSettingbyStatus">
                                    <div class="row ">
                                        <div class=""> 
                                            <!--<input type="" class="form-control" id="Setting_Group" name="Setting_Group" required>-->    
                                            <select name="Status" class="form-select" id="Setting_Group" onchange="this.form.submit()">
                                                <option value="" hidden="">Filtered by Status</option>
                                                <option value="display">All</option>
                                                <option value="1">Activate</option>
                                                <option value="0">Inactivate</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-3">
                                <form action="SystemSettingController">
                                    <input type="hidden" name="service" value="findSysyemSettingbyGroup">
                                    <div class="row ">
                                        <div class=""> 
                                            <!--<input type="" class="form-control" id="Setting_Group" name="Setting_Group" required>-->    
                                            <select name="Setting_Group" class="form-select" id="Setting_Group" onchange="this.form.submit()">
                                                <option value="" hidden="">Filtered by Setting Group</option>
                                                <option value="display">All</option>
                                                <option value="3">Permitted domain</option>
                                                <option value="2">User role</option>
                                                <option value="1">Semester</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive">
                                    <table class="  table  bg-white mb-0 table-hover table-bordered" id="myTable">
                                        <thead class="">
                                            <tr>
                                                <th class="border-bottom p-3 " onclick="sortTable(0)" style="cursor: pointer" style="min-width: 50px;">Setting ID<i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3 " onclick="sortTable(1)" style="cursor: pointer" style="min-width: 50px;">Display Order <i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3" onclick="sortTable(2)" style="cursor: pointer" style="min-width: 180px;">Setting Group<i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3" onclick="sortTable(3)" style="cursor: pointer" >Setting Name<i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3">Description</th>
                                                <th class="border-bottom p-3" onclick="sortTable(5)" style="cursor: pointer">Status<i class="uil uil-sort"></i></th>
                                                <th class="border-bottom p-3" style="min-width: 100px;">Action</th>
                                            </tr>
                                        </thead>

                                        <c:forEach items="${data}" var="setting">
                                            <tbody class="">
                                                <tr>
                                                    <td class="p-3">${setting.settingId}</td>
                                                    <td class="p-3">${setting.displayOrder}</td>

                                                    <c:if test="${setting.settingGroup==1}">
                                                        <td class="p-3"> Semester </td>
                                                    </c:if>
                                                    <c:if test="${setting.settingGroup==2}">
                                                        <td class="p-3"> User role </td>
                                                    </c:if>
                                                    <c:if test="${setting.settingGroup==3}">
                                                        <td class="p-3"> Permitted domain </td>
                                                    </c:if>
                                                    <td class="p-3">${setting.settingName}</td>
                                                    <td class="p-3">${setting.description}</td>
                                                    <c:if test="${setting.isActive==1}">
                                                        <td class="p-3"> <span class="badge bg-soft-success">Active</span> </td>
                                                    </c:if>
                                                    <c:if test="${setting.isActive==0}">
                                                        <td class="p-3"> <span class="badge bg-soft-danger">Inactive</span> </td>
                                                    </c:if>
                                                    <td class=" p-3">
                                                        <a href="SystemSettingController?service=updateSystemSetting&id=${setting.settingId}" 
                                                           class="btn btn-icon btn-pills btn-soft-primary"
                                                           title="Update">
                                                            <i class="uil uil-pen"></i>
                                                        </a>
                                                        <c:if test="${setting.isActive==1}">
                                                            <a
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#confirmChangeStatus-${setting.settingId}"
                                                                class="btn btn-icon btn-pills btn-soft-success"
                                                                title=" Active">
                                                                <i class="uil uil-check icons"></i>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${setting.isActive==0}">
                                                            <a 
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#confirmChangeStatus-${setting.settingId}"
                                                                class="btn btn-icon btn-pills btn-soft-danger"
                                                                title="In Active">
                                                                <i class="uil uil-times icons"></i>
                                                            </a>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <div class="modal" id="confirmChangeStatus-${setting.settingId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                    <div class="modal-content p-3">

                                                        <div class="modal-body border-0 text-center p-2">
                                                            <h1 class="text-danger display-1"><i class="ri-close-circle-line"></i></h1>
                                                            <h4 class="modal-title" id="confirmDelete">Are you sure</h4>
                                                            <p>Do you really want to change status of this setting? This process cannot be undone.</p>
                                                        </div>
                                                        <div class="modal-footer border-0 align-items-center justify-content-center">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                            <a type="button" class="btn btn-danger" href="SystemSettingController?service=changeStatus&id=${setting.settingId}&status=${setting.isActive}">Confirm</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END OF BODY -->
                    <div class="col-12 mt-4">
                        <div class="d-md-flex align-items-center text-center justify-content-between">
                            <span class="text-muted me-3">Showing 1 - 10 out of 50</span>

                            <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                <c:forEach begin="1" end="${endP}" var="i">
                                    <li class="page-item"><a class="page-link" href="SystemSettingController?service=display&index=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>
                    </div><!--end col-->


                    <!-- Footer Start -->
                    <%@include file="../../layout/footer.jsp" %>
                    <!--end footer-->


            </main>
            <!--End Page-content" -->
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