
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
        <style>
            #nav-class-milestones {
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
                        <c:if test="${requestScope.projectId ==0}">
                            <div class="d-md-flex justify-content-between">

                                <h5 class="mb-0">Assigned Class Setting</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="classManager">Assigned Classes Management</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Class Milestones</li>
                                    </ul>
                                </nav>
                            </div>
                        </c:if>
                        <c:if test="${requestScope.projectId !=0}">
                            <div class="col-xl-9 col-md-6">
                                <h5 class="mb-0">Project Management</h5>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item"><a href="">Project Management</a></li>
                                        <li class="breadcrumb-item"><a href="ManageProjectController">Select Class</a></li>
                                        <li class="breadcrumb-item " ><a href="ManageProjectController?service=ProjectList&class_id=${class_id}">Project List</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Project Details</li>
                                    </ul>
                                </nav>
                            </div><!--end col-->
                        </c:if>
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
                            <c:if test="${requestScope.projectId ==0}">
                                <div class="avatar-profile d-flex margin-nagative mt-n5 position-relative ps-3">

                                    <div class="mt-4 ms-3 pt-3">
                                        <h3 class="mt-3">${requestScope.assignClass.classCode}</h3>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${requestScope.projectId !=0}">
                                    <div class="p-4 border-bottom">
                                        <h5 class="mb-0"> Project details </h5>
                                    </div>
                            </c:if>
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="card border-0 rounded-0 p-2">
                                        <c:if test="${requestScope.projectId ==0}">
                                            <%@include file="../layout/assignedClassNavigation.jsp" %>
                                        </c:if>
                                        <c:if test="${requestScope.projectId !=0}">
                                            <%@include file="../layout/projectNavigation.jsp" %>
                                        </c:if>
                                        <div class="tab-content mt-2" id="pills-tabContent">
                                            <div class="row">

                                                <div class="col-md-2">
                                                    <form method="get" action="classManager">
                                                        <input type="hidden" name="isFilter" value="status">
                                                        <input type="hidden" name="mode" value="classMilestone">
                                                        <input type="hidden" name="classId" value="${assignClass.classId}">
                                                        <div class=""> 
                                                            <select name="milstoneStatus" class="form-select"  onchange="this.form.submit()">
                                                                <option value="" hidden="">Status Filter:</option>
                                                                <option value="all">All Milestones</option>
                                                                <option value="1">Open</option>
                                                                <option value="0">Closed</option>
                                                            </select>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="col-md-4">
                                                    <form role="search" method="get" action="classManager" class="search-form">
                                                        <div class="input-group">
                                                            <input type="text" class="form-control rounded-pill" name="searchVal" value="${searchVal}" id="name" placeholder="Search Keywords...">
                                                            <input type="hidden" class="form-control rounded-pill" name="isFilter" value="search">
                                                            <input type="hidden" name="mode" value="classMilestone">
                                                            <input type="hidden" name="classId" value="${assignClass.classId}">
                                                            <div class="input-group-append">
                                                                <button type="submit" class="btn btn-pills" title="Search">
                                                                    <i class="fas fa-search"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="col-md-2"></div>
                                                <div class="col-md-4 d-flex justify-content-evenly">
                                                    <form id="syncForm" action="gitsync" method="post">
                                                        <button class="btn btn-success mb-3 p-2">
                                                            <input type="hidden" name="id" value="${requestScope.assignClass.classId}">
                                                            <input name="gitUrl" id="gitUrl" type="hidden"
                                                                   class="form-control"
                                                                   value="${requestScope.assignClass.gitLabId}"
                                                                   required>
                                                            <input name="accessToken" id="accessToken" type="hidden"
                                                                   class="form-control"
                                                                   value="${requestScope.assignClass.accessToken}"
                                                                   required>

                                                            <i class="uil uil-sync icons"></i> Sync with GitLab
                                                        </button>
                                                    </form>
                                                    <button class="btn btn-primary mb-3 p-2 ml-3" onclick="addNewMilestone()">
                                                        <i class="uil uil-plus icons"></i> Add new Milestone
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade show active" id="pills-overview" role="tabpanel"
                                                 aria-labelledby="overview-tab">
                                                <table id="myTable" class="table mb-0 table-hover table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <th onclick ="sortTable(0)" class="border-bottom p-3" style=" cursor: pointer">
                                                                No.<i class="fas fa-sort"></i></th>                                               
                                                            <th onclick ="sortTable(1)" class="border-bottom p-3" style="min-width: 180px; cursor: pointer">
                                                                Title<i class="fas fa-sort"></i></th>   
                                                            <th onclick ="sortTable(2)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer">Start Date<i class="fas fa-sort"></i>
                                                            </th>
                                                            <th onclick ="sortTable(3)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer">
                                                                Due Date<i class="fas fa-sort"></i></th>
                                                            <th onclick ="sortTable(4)" class="border-bottom p-3" style="min-width: 150px; cursor: pointer">
                                                                Status<i class="fas fa-sort"></i>
                                                            </th>
                                                            <th class="border-bottom p-3"style="min-width: 100px;">Actions</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${requestScope.listMilestone}" var="milestone" varStatus="status">
                                                            <tr>
                                                                <td class="p-3">

                                                                    ${status.index + 1}
                                                                </td>
                                                                <td class="p-3">
                                                                    ${milestone.name}
                                                                </td>
                                                                <td class="p-3">
                                                                    ${milestone.startDate}
                                                                </td>
                                                                <td class="p-3">${milestone.dueDate}</td>
                                                                <c:if test="${milestone.isActive == 1}">
                                                                    <td class="p-3 text-success">Open</td>
                                                                </c:if>
                                                                <c:if test="${milestone.isActive == 0}">
                                                                    <td class="p-3 text-danger">Closed</td>
                                                                </c:if>
                                                                <c:if test="${milestone.isActive == 2}">
                                                                    <td class="p-3 text-warning">Pending</td>
                                                                </c:if>
                                                                <td>
                                                                    <button onclick="getMilestoneDetail(${assignClass.classId}, ${milestone.id})"
                                                                            class="btn btn-icon btn-pills btn-soft-primary"><i class="uil uil-pen"></i></button>  
                                                                        <c:choose>
                                                                            <c:when test="${milestone.isActive == 1}">
                                                                            <a href="classManager?mode=classMilestone&option=changeStatus&classId=${assignClass.classId}&mileId=${milestone.id}&status=0&projectId=${projectId}" class="btn btn-icon btn-pills btn-soft-danger" title="Inactive"  data-bs-toggle="modal" data-bs-target="#confirmationModal">
                                                                                <i class="uil uil-ban icons"></i>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="classManager?mode=classMilestone&option=changeStatus&classId=${assignClass.classId}&mileId=${milestone.id}&status=1&projectId=${projectId}" class="btn btn-icon btn-pills btn-soft-success" title="Active" data-bs-toggle="modal" data-bs-target="#confirmationModal">
                                                                                <i class="uil uil-check icons"></i>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <c:if test="${milestone.isActive == 2}">

                                                                        <a href="classManager?mode=classMilestone&option=changeStatus&classId=${assignClass.classId}&mileId=${milestone.id}&statusMethod=delete&projectId=${projectId}" class="btn btn-icon btn-pills btn-soft-warning" title="Delete" data-bs-toggle="modal" data-bs-target="#confirmationModal">
                                                                            <i class="uil uil-trash-alt icons"></i>
                                                                        </a>
                                                                    </c:if> 
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
                                                                    <li class="page-item"><a class="page-link" href="classManager?mode=classMilestone&classId=${assignClass.classId}&index=${i}">${i}</a></li>         
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
                <div class="modal fade" id="updateMilestone" tabindex="-1" role="dialog" aria-labelledby="updateMilestone" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalLabel"></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body" id="modal-update-milestone">

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                                <button type="button" class="btn btn-primary" onclick="submitForm()" id="updateMilestoneSubmit">Update</button>
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
                                    function getMilestoneDetail(classId, milestoneId) {
                                        $.ajax({
                                            url: "classManager?mode=classMilestone&option=update&classId=" + classId + "&mileId=" + milestoneId + "",
                                            type: "GET",
                                        }).done(function (result) {
                                            $('#modalLabel').text("Update Milestone");
                                            $('#updateMilestoneSubmit').text('Update');
                                            $("#modal-update-milestone").html(result);
                                            $('#updateMilestone').modal('show');
                                        }).fail(function (jqXHR, textStatus, errorThrown) {
                                            console.error("Request failed: " + textStatus + ", " + errorThrown);
                                        });
                                    }
                                    function submitForm() {
                                        $('#milestoneForm').submit();
                                    }

                                    function addNewMilestone() {
                                        $('#modalLabel').text("Add New Milestone");
                                        $('#updateMilestoneSubmit').text('Add');
                                        var newModalBody = `
                                            <form id="milestoneForm" action="classManager" method="post">
                                                <input type="hidden" name="mode" value="add">
                                                <div class="mb-3">
                                                    <label class="form-label">Title</label>
                                                    <input name="milestone-title" id="milestone-title" type="text" class="form-control" value="">
                                                    <input type="hidden" name="classId" value="${assignClass.classId}">
                                                    <input type="hidden" name="projectId" value="${projectId}">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Start Date</label>
                                                    <input name="milestone-start-date" id="milestone-start-date" type="date" class="form-control" value="">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Due Date</label>
                                                    <input name="milestone-due-date" id="milestone-due-date" type="date" class="form-control" value="">
                                                </div>
                                                
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Description</label>
                                                        <textarea name="descript" id="descript" rows="4" class="form-control"></textarea>
                                                    </div>
                                                </div>
                                            </form>`;
                                        // Replace the modal body content with the new HTML snippet
                                        $('#modal-update-milestone').html(newModalBody);

                                        // Show the modal
                                        $('#updateMilestone').modal('show');
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

        </script>
    </body>
</html>
