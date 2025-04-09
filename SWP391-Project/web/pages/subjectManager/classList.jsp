<%-- 
    Document   : user_list
    Created on : Sep 17, 2023, 6:26:12 PM
    Author     : FPT
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.ClassDAO,model.Class,model.User,model.Setting,model.Subject,java.sql.ResultSet"%>
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
            List<Class> list = (List<Class>) request.getAttribute("data");
            List<Setting> list1 = (List<Setting>) request.getAttribute("data1");
            List<Subject> list2 = (List<Subject>) request.getAttribute("data2");
            List<User> list3 = (List<User>) request.getAttribute("data3");
            ResultSet Rs = (ResultSet) request.getAttribute("Rs");
            ResultSet Rs2 = (ResultSet) request.getAttribute("Rs2");
            ResultSet Rs3 = (ResultSet) request.getAttribute("Rs3");
            List<Setting> list4 = (List<Setting>) request.getAttribute("data4");
            List<Subject> list5 = (List<Subject>) request.getAttribute("data5");
            List<User> list6= (List<User>) request.getAttribute("data6");
        %>
        <%
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage");
            }
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
            <%--<%@include file="../layout/subjectManagerSidebar.jsp" %>--%>
            <%@include file="../layout/adminSideBar.jsp" %>

            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End of HEADER -->


                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="col-xl-9 col-md-2">
                                <h5 class="mb-0">Class Management</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="UserController?service=listAll">Class Management</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Class list</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->

                        </div><!--end row-->    
                        <div class ="row" style="display: flex; justify-content: space-between;">        

                            <div class="col-md-2 mt-5" style="float:right">
                                <form action="ClassController">
                                    <input type="hidden" name="service" value="filterSemester">
                                    <div class="row ">
                                        <div class=""> 
                                            <select name="checkSemester" class="form-select" id="checkSemester" onchange="this.form.submit()">
                                                <option value="" hidden="">Semester Filter:</option>
                                                <option value="display">All</option>
                                                <c:forEach items="${data1}" var="st">

                                                    <option value="${st.settingId}">${st.settingName}</option>


                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>                           

                            <div class="col-md-2 mt-5" style="float:right">
                                <form action="ClassController">
                                    <input type="hidden" name="service" value="filterSubject">
                                    <div class="row ">
                                        <div class=""> 
                                            <select name="checkSubject" class="form-select" id="checkSubject" onchange="this.form.submit()">
                                                <option value="" hidden="">Subject Filter:</option>
                                                <option value="display">All</option>
                                                <c:forEach items="${data2}" var="sb">

                                                    <option value="${sb.subjectId}">${sb.subjectName}</option>


                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>                

                            <div class="col-md-2 mt-5" style="float:right">
                                <form action="ClassController">
                                    <input type="hidden" name="service" value="filterTeacher">
                                    <div class="row ">
                                        <div class=""> 
                                            <select name="checkTeacher" class="form-select" id="checkTeacher" onchange="this.form.submit()">
                                                <option value="" hidden="">Teacher Filter:</option>
                                                <option value="display">All</option>
                                                <c:forEach items="${data3}" var="us">

                                                    <option value="${us.userId}">${us.fullName}</option>


                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div class="col-md-2 mt-5" style="float:right">
                                <form action="ClassController">
                                    <input type="hidden" name="service" value="filterStatus">
                                    <div class="row ">
                                        <div class=""> 
                                            <select name="checkStatus" class="form-select" id="checkStatus" onchange="this.form.submit()">
                                                <option value="" hidden="">Status Filter:</option>
                                                <option value="display">All</option>
                                                <option value="0">Pending</option>
                                                <option value="1">Started</option>
                                                <option value="2">Closed</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>                
                            
                            <div class="search-bar p-0 d-none d-lg-block col-md-2 mt-5" >
                                <div id="search" class="menu-search mb-0">
                                    <form role="search" method="post" id="searchform" class="searchform" action="ClassController?service=searchName">
                                        <div>
                                            <input value ="${name}" type="text" class="form-control border rounded-pill" name="name" id="name" placeholder="Search Keywords...">
                                            <input type="submit" id="searchsubmit" value="Search">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            
                            <div class="text-md-end col-md-2 mt-5">
                                <c:if test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">
                                <a href="ClassController?service=addClass" data-bs-toggle="modal" data-bs-target="#addform" class="btn btn-primary">Add New Class</a>
                                </c:if>
                            </div><!--end col-->
                            
                        </div>
                        <div class="table-responsive bg-white shadow rounded">

                            <table id="myTable" class="table mb-0 table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th class="border-bottom p-3" style="min-width: 50px; cursor: pointer">ID<i class="uil uil-sort"></i>
                                        </th>
                                        <th onclick ="sortTable(1)" class="border-bottom p-3" style="min-width: 180px; cursor: pointer">
                                            Class Code<i class="uil uil-sort"></i></th>                                               
                                        <th onclick ="sortTable(2)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer;">Semester<i class="uil uil-sort"></i>
                                        </th>
                                        <th onclick ="sortTable(3)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer;">
                                            Subject<i class="uil uil-sort"></i></th>
                                        <th onclick ="sortTable(4)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer;">
                                            Class Manager<i class="uil uil-sort"></i></th>
                                        <th onclick ="sortTable(5)" class="border-bottom p-3" style="min-width: 130px; cursor: pointer;">
                                            Status<i class="uil uil-sort"></i></th>
                                        <th class="border-bottom p-3"style="min-width: 50px;">Actions</th>

                                    </tr>
                                </thead>

                                <c:forEach items="${data}" var="cl">

                                    <tbody>
                                        <tr>
                                            <td class="p-3">
                                                ${cl.classId}
                                            </td>
                                            <td class="p-3">
                                                <a href="#" class="text-dark">
                                                    <div class="d-flex align-items-center">
                                                        <span class="ms-2">
                                                            ${cl.classCode}
                                                        </span>
                                                    </div>
                                                </a>
                                            </td>

                                            <c:forEach items="${data1}" var="st">
                                                <c:if test="${cl.semesterId==st.settingId}">
                                                    <td class="p-3">
                                                        ${st.settingName}
                                                    </td>
                                                </c:if>
                                            </c:forEach>  

                                            <c:forEach items="${data2}" var="sb">
                                                <c:if test="${cl.subjectId==sb.subjectId}">
                                                    <td class="p-3">
                                                        ${sb.subjectName}
                                                    </td>
                                                </c:if>
                                            </c:forEach>  

                                            <c:forEach items="${data3}" var="us">
                                                <c:if test="${cl.managerId==us.userId}">
                                                    <td class="p-3">
                                                        ${us.fullName}
                                                    </td>
                                                </c:if>
                                            </c:forEach>  


                                            <c:if test="${cl.status==0}">                                          
                                                <td><span class="badge bg-soft-warning">Pending</span></td>
                                            </c:if>
                                            <c:if test="${cl.status==1}">                                          
                                                <td><span class="badge bg-soft-success">Started</span></td>
                                            </c:if>
                                            <c:if test="${cl.status==2}">                                          
                                                <td><span class="badge bg-soft-danger">Closed</span></td>
                                            </c:if>

                                            <td class="p-3">  
                                                <a href="ClassController?service=updateClass&cid=${cl.classId}"
                                                       class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-pen"></i></a>
                                            <c:if test="${sessionScope.user.roleId==14 || sessionScope.user.roleId==15}">
                                                <c:if test="${cl.status==0}">                            
                                                    <a data-bs-toggle="modal" data-bs-target="#start-${cl.classId}" 
                                                       class="btn btn-icon btn-pills btn-soft-success"
                                                       title="Start"
                                                       >
                                                        <i class="uil uil-play"></i>
                                                    </a>
                                                    <a data-bs-toggle="modal" data-bs-target="#delete-${cl.classId}" 
                                                       class="btn btn-icon btn-pills btn-soft-danger"
                                                       title="Delete"
                                                       >
                                                        <i class="uil uil-trash-alt"></i>
                                                    </a>   
                                                    <div class="modal" id="start-${cl.classId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                            <div class="modal-content p-3">

                                                                <div class="modal-body border-0 text-center p-2">
                                                                    <h1 class="text-success display-1"><i class="uil uil-play"></i></h1>
                                                                    <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                    <p>Do you really want to start this class? This process cannot be undone.</p>
                                                                </div>
                                                                <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                    <a href="ClassController?service=changeStatus&id=${cl.classId}&status=${cl.status}" type="button" class="btn btn-success">Start</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="modal" id="delete-${cl.classId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                            <div class="modal-content p-3">

                                                                <div class="modal-body border-0 text-center p-2">
                                                                    <h1 class="text-danger display-1"><i class="ri-close-circle-line"></i></h1>
                                                                    <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                    <p>Do you really want to delete this class? This process cannot be undone.</p>
                                                                </div>
                                                                <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                    <a href="ClassController?service=delete&id=${cl.classId}" type="button" class="btn btn-danger">Delete</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>           
                                                </c:if>
                                                <c:if test="${cl.status==1}">                      
                                                    <a data-bs-toggle="modal" data-bs-target="#close-${cl.classId}" 
                                                       class="btn btn-icon btn-pills btn-soft-danger"
                                                       title="Close "
                                                       >
                                                        <i class="uil uil-ban"></i>
                                                    </a>
                                                    <div class="modal" id="close-${cl.classId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg w modal-dialog-centered " style="width:400px;">
                                                            <div class="modal-content p-3">

                                                                <div class="modal-body border-0 text-center p-2">
                                                                    <h1 class="text-danger display-1"><i class="uil uil-ban"></i></h1>
                                                                    <h4 class="modal-title" id="exampleModalLabel">Are you sure</h4>
                                                                    <p>Do you really want to Close this class? This process cannot be undone.</p>
                                                                </div>
                                                                <div class="modal-footer border-0 align-items-center justify-content-center">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                    <a href="ClassController?service=changeStatus&id=${cl.classId}&status=${cl.status}" id="close-button" type="button" class="btn btn-danger">Close</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${cl.status==2}">
                                                </c:if>
                                            </c:if>
                                            </td>
                                        </tr>

                                    </c:forEach>

                                </tbody>
                            </table>

                        </div>

                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3"></span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:forEach begin="1" end="${endP}" var="i">
                                            <li class="page-item"><a class="page-link" href="ClassController?listAll&index=${i}">${i}</a></li>         

                                        </c:forEach>
                                    </ul>
                                </div>
                            </div><!--end col-->
                        </div>



                    </div>
                    <div class="modal fade" id="addform" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header border-bottom p-3">
                                    <h5 class="modal-title" id="exampleModalLabel">Add new Class</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body p-3 pt-4">
                                    <form id="add-form" action="ClassController"  enctype="multipart/form-data">
                                        <input type ="hidden" name ="service" value ="addClass">
                                        <div class="row" class="mt-4">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="name">Class Code<span class="text-danger">*</span></label>
                                                    <input name="code" id="code" type="text" required class="form-control" placeholder="Class Code :">
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="semester">Semester</label>
                                                    <select class="form-select " name="semester" id="semester">
                                                        <c:forEach items="${data4}" var="st2">
                                                            <c:if test="${st2.isActive==1}">
                                                            <option value="${st2.settingId}">${st2.settingName}</option>
                                                            </c:if>

                                                        </c:forEach>
                                                    </select>
                                                </div> 
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Subject</label>
                                                    <select class="form-select " name="subject" >
                                                        <c:if test="${sessionScope.user.roleId==14}">
                                                        <c:forEach items="${data5}" var="sb2">
                                                            <c:if test="${sb2.isActive==1}">
                                                            <option value="${sb2.subjectId}">${sb2.subjectName}</option>
                                                            </c:if>

                                                        </c:forEach>
                                                        </c:if>
                                                        <c:if test="${sessionScope.user.roleId==15}"> 
                                                        <c:forEach items="${data2}" var="sb">
                                                            <c:if test="${sb.isActive==1}">
                                                            <option value="${sb.subjectId}">${sb.subjectName}</option>
                                                            </c:if>

                                                        </c:forEach>
                                                        </c:if>
                                                    </select>
                                                </div>                                                                               
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="manager">Class Manager</label>
                                                    <select class="form-select " name="manager" >
                                                        
                                                        <c:forEach items="${data6}" var="us2">
                                                            <c:if test ="${us2.isActive==1}">
                                                            <option value="${us2.userId}">${us2.fullName}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6" style="display:grid">
                                                <div class="mb-3">
                                                    <div class="row ms-3">
                                                        <div class="form-check col-md-4">
                                                            <label class="form-check-label" >Pending</label>
                                                            <input class="form-check-input" type="radio" name="status" value="0" checked>
                                                        </div>
                                                        <div class="form-check col-md-4">
                                                            <label class="form-check-label">Started</label>
                                                            <input class="form-check-input" type="radio" name="status" value="1">

                                                        </div>
                                                        <div class="form-check col-md-4">
                                                            <label class="form-check-label" >Closed</label>
                                                            <input class="form-check-input"type="radio" name="status" value="2">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><!--end col-->


                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="details">Details</label>
                                                    <textarea name="details" id="details" rows="3" class="form-control" placeholder="Details :"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-md-12 d-grid">
                                            <button type="submit" name="submit2" value=" " class="btn btn-primary">Add class</button>
                                            </div>
                                        </div><!--end row-->


                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- Add New Appointment End -->
                    </div>
                </div><!--end container-->

                <!-- END OF BODY -->


                <!-- Footer Start -->
                <%@include file="../layout/footer.jsp" %>
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
                                            const classId = document.querySelector('#start').getAttribute('data-class-id');
        </script>
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
                top: 120px;
                right: 50px;
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
            displayToast("Class added successfully!", true);
        } else if (isSuccess === "false") {
            displayToast("Class code is existed, failed to add Class!", false);
        }
    });
    </script>

    </body>

</html>