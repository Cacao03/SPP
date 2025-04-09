<%-- 
    Document   : assignedClassNavigation
    Created on : Oct 8, 2023, 5:42:01 PM
    Author     : Đàm Quang Chiến
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded shadow overflow-hidden bg-light"
    id="pills-tab" role="tablist">

 <li class="nav-item">
        <a class="nav-link rounded-0" id="nav-class-setting"
           href="ClassController?service=updateClass&cid=${assignClass.classId}" role="tab"
           >
            <div class="text-center pt-1 pb-1">
                <h4 class="title fw-normal mb-0">Class Setting</h4>
            </div>
        </a><!--end nav link-->
    </li><!--end nav item-->
    <li class="nav-item">
        <a class="nav-link rounded-0" id="nav-class-milestones"
           href="classManager?mode=classMilestone&classId=${assignClass.classId}" role="tab"
           >
            <div class="text-center pt-1 pb-1">
                <h4 class="title fw-normal mb-0">Class Assignments</h4>
            </div>
        </a><!--end nav link-->
    </li><!--end nav item-->
    <li class="nav-item">
        <a class="nav-link rounded-0" id="nav-class-students"
           href="classManager?mode=classStudent&classId=${assignClass.classId}" role="tab"
           >
            <div class="text-center pt-1 pb-1">
                <h4 class="title fw-normal mb-0">Class Students</h4>
            </div>
        </a><!--end nav link-->
    </li><!--end nav item-->
  <li class="nav-item">
        <a class="nav-link rounded-0" id="nav-class-issue"
           href="IssueSettingController?service=displayClassSetting&classId=${assignClass.classId}&subjectID=${assignClass.subject}&mode=class" role="tab" 
           >
            <div class="text-center pt-1 pb-1">
                <h4 class="title fw-normal mb-0">Issue Setting</h4>
            </div>
        </a><!--end nav link-->
    </li><!--end nav item-->
   


</ul><!--end nav pills-->
