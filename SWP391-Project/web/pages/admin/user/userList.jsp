<%-- 
    Document   : user_list
    Created on : Sep 17, 2023, 6:26:12 PM
    Author     : FPT
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.UserDAO,model.User,model.Setting,java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE html>
<html lang="en">

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

    </head>

    <body>
        <%
            List <User> list=(List<User>)request.getAttribute("data");
            List <Setting> list1=(List<Setting>)request.getAttribute("data1");
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


                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="col-xl-9 col-md-6">
                                <h5 class="mb-0">User Management</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="UserController?service=listAll">User Management</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">User list</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->

                        </div><!--end row-->    
                        
                        <div class="d-flex align-items-center row ">
                        
                            <div class="col-md-2 mt-4" style="float:right">
                            <form action="UserController">
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
                            <div class="col-md-2 mt-4" style="float:right">
                                <form action="UserController">
                                    <input type="hidden" name="service" value="filterRole">
                                    <div class="row ">
                                        <div class=""> 
                                            <select name="checkRole" class="form-select" id="checkRole" onchange="this.form.submit()">
                                                <option value="" hidden="">Role Filter:</option>
                                                <option value="display">All</option>
                                                <c:forEach items="${data1}" var="st">

                                                    <option value="${st.settingId}">${st.settingName}</option>


                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>    
                            <div class="col-md-2 search-bar p-0 d-none d-lg-block mt-4" >
                                <div id="search" class="menu-search mb-0">
                                    <form role="search" method="post" id="searchform" class="searchform" action="UserController?service=searchName">
                                        <div>
                                            <input value ="${name}" type="text" class="form-control border rounded-pill" name="name" id="name" placeholder="Search Keywords...">
                                            <input type="submit" id="searchsubmit" value="Search">
                                        </div>
                                    </form>
                                </div>
                            </div>    
                           
                            <div class="text-md-end col-md-6 mt-4">
                                <a href="UserController?service=addUser" class="btn btn-primary">Add New User</a>
                            </div><!--end col-->
                    </div>
                        
                         
                        
                        <div class="table-responsive bg-white shadow rounded">

                                        <table id="myTable" class="table mb-0 table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <th class="border-bottom p-3" style="min-width: 50px;">ID<i class="uil uil-sort"></i>
                                                    </th>
                                                    <th onclick ="sortTable(1)" class="border-bottom p-3" style="min-width: 180px; cursor: pointer">
                                                        Full Name<i class="uil uil-sort"></i></th>                                               
                                                    <th onclick ="sortTable(2)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer">Email<i class="uil uil-sort"></i>
                                                    </th>
                                                    <th onclick ="sortTable(3)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer">
                                                        Role<i class="uil uil-sort"></i></th>
                                                    
                                                    <th onclick ="sortTable(4)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer">
                                                        Status<i class="uil uil-sort"></i></th>
                                                    <th class="border-bottom p-3"style="min-width: 100px;">Actions</th>
                                                        
                                                </tr>
                                            </thead>
   
                                            <c:forEach items="${data}" var="us">
                                                
                                            <tbody>
                                                <tr>
                                                    <td class="p-3">
                                                    ${us.userId}
                                                    </td>
                                                    <td class="p-3">
                                                        <a href="#" class="text-dark">
                                                            <div class="d-flex align-items-center">
                                                                <span class="ms-2">
                                                                    ${us.fullName}
                                                                </span>
                                                            </div>
                                                        </a>
                                                    </td>
                                                    <td class="p-3">${us.email}</td>
                                                    <c:forEach items="${data1}" var="st">
                                                    <c:if test="${us.roleId==st.settingId}">
                                                    <td class="p-3">
                                                    ${st.settingName}
                                                    </td>
                                                    </c:if>
                                                    </c:forEach>  
                                                    
                                                    <c:choose>
                                                    <c:when test="${us.isActive==1}">                                               
                                                    <td><span class="badge bg-soft-success">Active</span></td>
                                                    </c:when>          
                                                    <c:otherwise>    
                                                    <td><span class="badge bg-soft-danger">InActive</span></td>
                                                    </c:otherwise>
                                                    </c:choose>
                                                    <td class="p-3">
                                                        <a href="UserController?service=updateUser&uid=${us.userId}"
                                                           <c:if test="${us.roleId==14}">
                                                           class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-eye"></i></a>   
                                                           </c:if>
                                                           <c:if test="${us.roleId!=14}">
                                                           class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-pen"></i></a>   
                                                           </c:if>
                                                           <c:if test="${us.roleId!=14}">
                                                           <c:choose>
                                                       
                                                        <c:when test="${us.isActive==1}">
                                                        <a data-bs-toggle="modal" data-bs-target="#stop-${us.userId}"
                                                           class="btn btn-icon btn-pills btn-soft-danger"
                                                           title="Inactive "
                                                           ><i class="uil uil-times icons"></i></a>
                                                           
                                                           <div class="modal" id="stop-${us.userId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                               <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                   <div class="modal-content p-3">

                                                                       <div class="modal-body border-0 text-center p-2">
                                                                           <h1 class="text-danger display-1"><i class="uil uil-times-circle"></i></h1>
                                                                           <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                           <p>Do you really want to Deactivate this user? This process cannot be undone.</p>
                                                                       </div>
                                                                       <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                           <a href="UserController?service=changeStatus&id=${us.userId}&status=${us.isActive}" type="button" class="btn btn-danger">Deactivate</a>
                                                                       </div>
                                                                   </div>
                                                               </div>
                                                           </div> 
                                                        </c:when>
                                                        <c:otherwise>   
                                                        <a data-bs-toggle="modal" data-bs-target="#start-${us.userId}"
                                                           class="btn btn-icon btn-pills btn-soft-success"
                                                           title="Active "
                                                           >
                                                            <i class="uil uil-check icons"></i>
                                                        </a>
                                                           
                                                        <div class="modal" id="start-${us.userId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                                <div class="modal-content p-3">

                                                                    <div class="modal-body border-0 text-center p-2">
                                                                        <h1 class="text-success display-1"><i class="uil uil-check-circle"></i></h1>
                                                                        <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                        <p>Do you really want to Activate this user? This process cannot be undone.</p>
                                                                    </div>
                                                                    <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                        <a href="UserController?service=changeStatus&id=${us.userId}&status=${us.isActive}" type="button" class="btn btn-success">Activate</a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>   
                                                        </c:otherwise>
                                                        </c:choose>
                                                           </c:if>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                               
                                            </tbody>
                                        </table>
                                    </div>
                                            <c:choose>
                                            <c:when test ="${service.equals('searchName')}">
                                                <c:forEach begin="1" end="${endP}" var="i">
                                                    <a href="UserController?service=searchName&index=${i}&name=${name}}">${i}</a>           
                                                    </c:forEach>
                                            </c:when>
                                                    <c:otherwise>
                                                        <div class="row text-center">
                                            <div class="col-12 mt-4">
                                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                                    <span class="text-muted me-3"></span>
                                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                                    <c:forEach begin="1" end="${endP}" var="i">
                                                    <li class="page-item"><a class="page-link" href="UserController?listAll&index=${i}">${i}</a></li>         
                                                    
                                                    </c:forEach>
                                                    </ul>
                                                </div>
                                            </div><!--end col-->
                                                    </div>
                                                    </c:otherwise>
                                        </c:choose>
                    </div>
                </div><!--end container-->

                <!-- END OF BODY -->


                <!-- Footer Start -->
                <%@include file="../../layout/footer.jsp" %>
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
    <style>
        /* Add CSS for the toast */
        #toast {
            display: none;
                position: fixed;
                top: 100px;
                right: 30px;
                background-color: #4CAF50;
                color: #fff;
                padding: 15px;
                border-radius: 5px;
                text-align: center;
        }
    </style>

    
    <!-- JavaScript function to display toast -->
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
        setTimeout(function() {
            toast.style.display = "none";
        }, 3000);  // Display the toast for 3 seconds
    }
    </script>

    <!-- HTML element for the toast -->
    <div id="toast"></div>


    <%-- JavaScript code to check URL parameters and display the toast message --%>
    <script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        var urlParams = new URLSearchParams(window.location.search);
        var isSuccess = urlParams.get("success");
        
        if (isSuccess === "true") {
            displayToast("User added successfully!", true);
        } else if (isSuccess === "false") {
            displayToast("Failed to add User!", false);
        }
    });
    </script>
    </body>

</html>