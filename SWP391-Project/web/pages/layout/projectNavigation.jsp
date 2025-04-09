<%-- 
    Document   : projectNavigation
    Created on : Nov 5, 2023, 4:35:06 PM
    Author     : TRAN DUNG
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="p-4">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded" id="pills-tab" role="tablist">
                        <%
                            String project_id = (String) request.getAttribute("project_id");
                            String class_id = (String) request.getAttribute("class_id");
                            String mode = (String) request.getAttribute("mode");

                        %>
                        <%if (role != 18) {%>
                        <li class="nav-item">
                            <a class="nav-link rounded <%if(mode.equals("general")){%> active <%}%>"  href="ManageProjectController?service=updateProject&project_id=<%=project_id%>&class_id=<%=class_id%>" role="tab" aria-controls="pills-smart" aria-selected="flase">
                                <div class="text-center pt-1 pb-1">
                                    <h4 class="title font-weight-normal mb-0">General</h4>
                                </div>
                            </a><!--end nav link-->
                        </li><!--end nav item-->

                        <li class="nav-item">
                            <a class="nav-link rounded <%if(mode.equals("mile")){%> active <%}%>" href="classManager?mode=classMilestone&classId=${requestScope.class_id}&projectId=<%=project_id%>" role="tab" aria-controls="pills-smart" aria-selected="false">
                                <div class="text-center pt-1 pb-1">
                                    <h4 class="title font-weight-normal mb-0">Milestone</h4>
                                </div>
                            </a><!--end nav link-->
                        </li><!--end nav item-->

                        <li class="nav-item">
                            <a class="nav-link rounded"  href="IssueSettingController?service=displayProjectSetting&projectID=<%=project_id%>&mode=project" role="tab" aria-controls="pills-apps" aria-selected="false">
                                <div class="text-center pt-1 pb-1">
                                    <h4 class="title font-weight-normal mb-0">Issue Setting</h4>
                                </div>
                            </a><!--end nav link-->
                        </li><!--end nav item-->
                       
                        <%}%>
                    </ul><!--end nav pills-->
                </div><!--end col-->
            </div><!--end row-->
    </body>
</html>
