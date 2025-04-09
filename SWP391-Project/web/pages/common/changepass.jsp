<%-- 
    Document   : changepass
    Created on : Sep 21, 2023, 2:49:42 PM
    Author     : Đàm Quang Chiến
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Project Portal Management</title>
        <link rel="shortcut icon" href="assests/images/logo.png">
        <base href="${pageContext.request.contextPath}/">
        <link rel="stylesheet" href="assests/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
              integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>      
    </head>
    <body>
        <c:if test="${not empty requestScope.failMsg}">
            <div class="alert alert-warning" role="alert">
                <span class="p-3">${requestScope.failMsg}</span>
            </div>
        </c:if>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title text-center mb-4">Reset Password</h3>
                            <!-- Reset Password Form -->
                            <form action="reset" method="post" id="reset-password-form">
                                <div class="mb-3">
                                    <label for="new-password" class="form-label">New Password</label>
                                    <input type="password" class="form-control" id="new-password" name="new-password" required>
                                    <input type="hidden" class="form-control" id="account" name="account" value="${requestScope.account}">
                                    <input type="hidden" class="form-control" id="mode" name="mode" value="change-pass">
                                </div>
                                <div class="mb-3">
                                    <label for="confirm-password" class="form-label">Confirm Password</label>
                                    <input type="password" class="form-control" id="confirm-password" name="confirm-password" value="" required>
                                </div>
                                <button type="submit" onclick="changePass(event)" class="btn btn-primary btn-block">Reset Password</button>
                            </form>
                            <!-- End Reset Password Form -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Bootstrap JS and jQuery links here -->

        <script src="assests/js/bootstrap.bundle.min.js"></script>
        <script src="assests/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

        <script>
                                    // Handle form submission
                                    function changePass(e) {
                                        e.preventDefault();

                                        // Get new password and confirm password values
                                        var newPassword = $("#new-password").val();
                                        var confirmPassword = $("#confirm-password").val();

                                        if (!validatePassword(newPassword)) {
                                            displayMessage("Your password must have at least 8 characters, one uppercase letter, and one special character");
                                        } else {
                                            if (newPassword !== confirmPassword) {
                                                displayMessage("Passwords do not match. Please try again.");
                                                return;
                                            }else{
                                                $("#reset-password-form").submit();
                                            }

                                        }
                                    };

                                    function validatePassword(pass) {
                                        // Regular expression to match only letters (A-Z, a-z)
                                        var passRegex = /^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$/;
                                        return passRegex.test(pass);
                                    }

                                    function displayMessage(message) {
                                        // Display the message to the user (e.g., using Toastify or another notification library)
                                        Toastify({
                                            text: message,
                                            duration: 3000, // 3 seconds
                                            close: true,
                                            gravity: "right",
                                            backgroundColor: "#f8d7da",
                                            style: {
                                                color: "#58151c"
                                            }
                                        }).showToast();
                                    }

        </script>
    </body>
</html>
