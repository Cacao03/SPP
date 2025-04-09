<%-- 
    Document   : subjectDetailNavigation
    Created on : Oct 28, 2023, 6:47:43 PM
    Author     : hungd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String subject_id = request.getParameter("subjectID");
%>
<ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded shadow overflow-hidden bg-light"
    id="pills-tab" role="tablist">
    <li class="nav-item">
        
        <a class="nav-link rounded-0" id="nav-subject-general"
           href="manageSubjectController?service=displayDetails&subjectID=<%=subject_id%>" role="tab">
            <div class="text-center pt-1 pb-1">
                <h4 class="title fw-normal mb-0">General</h4>
            </div>
        </a><!--end nav link-->
</li><!--end nav item-->

<li class="nav-item">
    <a class="nav-link rounded-0" id="nav-subject-assignment"
       href="manageSubjectController?service=displayAssignment&subjectID=<%=subject_id%>" role="tab" >
        <div class="text-center pt-1 pb-1">
            <h4 class="title fw-normal mb-0">Assignments</h4>
        </div>
    </a><!--end nav link-->
</li><!--end nav item-->
<li class="nav-item">
    <a class="nav-link rounded-0" id="nav-subject-setting"
       href="IssueSettingController?service=displayIssueSetting&subjectID=<%=subject_id%>&mode=subject" role="tab">
        <div class="text-center pt-1 pb-1">
            <h4 class="title fw-normal mb-0">Issue Setting</h4>
        </div>
    </a><!--end nav link-->
</li><!--end nav item-->
</ul><!--end nav pills-->

