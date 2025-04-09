<%-- 
    Document   : navbar
    Created on : Sep 25, 2023, 9:53:15 PM
    Author     : Đàm Quang Chiến
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <div class="top-header">
        <div class="header-bar d-flex justify-content-between border-bottom">
            <div class="d-flex align-items-center">

                <div id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2">
                    <i class="uil uil-bars"></i>
                </div>

            </div>

            <ul class="list-unstyled mb-0">
                <li class="list-inline-item mb-0 ms-1">
                    <div class="dropdown dropdown-primary">
                        <button type="button" class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle"
                                data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="ri-user-line"></i>
                        </button>
                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                             style="min-width: 200px;">
                            <a class="dropdown-item text-dark">
                                <span class="mb-0 d-inline-block me-1">
                                    <i class="uil uil-user align-middle h6"></i>
                                </span>
                                ${sessionScope.user.getFullName()}
                            </a>
                           
                            </a>

                            <a class="dropdown-item text-dark" href="UserProfileController?service=showProfile&uid=${sessionScope.user.getUserId()}"><span
                                    class="mb-0 d-inline-block me-1"><i
                                        class="uil uil-setting align-middle h6"></i></span> Profile Overview</a>
                            <a class="dropdown-item text-dark" href="UserProfileController?service=changePass&uid=${sessionScope.user.getUserId()}"><span
                                    class="mb-0 d-inline-block me-1"><i
                                        class="uil uil-lock-alt align-middle h6"></i></span> Change Password</a>            
                            <div class="dropdown-divider border-top"></div>
                            <a class="dropdown-item text-dark" href="logout"><span
                                    class="mb-0 d-inline-block me-1"><i
                                        class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</html>