<%-- 
    Document   : classManagerSideBar
    Created on : Oct 7, 2023, 10:28:23 PM
    Author     : Đàm Quang Chiến
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <nav id="sidebar" class="sidebar-wrapper">
        <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
            <div class="sidebar-brand  ">
                <a href="#" class="d-flex justify-content-center">
                    <img src="assests/images/logo.png" width="130" height="80" class="logo-light-mode" alt="">
                </a>
            </div>

            <ul class="sidebar-menu pt-3">
                <li><a href=""><i class="uil uil-window me-2 d-inline-block"></i>Dashboard</a></li>
                <li><a href="classManager"><i class="uil uil-window me-2 d-inline-block"></i>Class Management</a></li>
                <li><a href="ManageProjectController"><i class="uil uil-subject me-2 d-inline-block"></i>Project Management</a></li>
            </ul>
        </div>
    </nav>
</html>
