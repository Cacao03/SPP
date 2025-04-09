<%-- 
    Document   : login
    Created on : Sep 17, 2023, 9:56:08 PM
    Author     : Đàm Quang Chiến
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Project Portal Management</title>
        <base href="${pageContext.request.contextPath}/">
        <link rel="shortcut icon" href="assests/images/logo.png">
        <link rel="stylesheet" href="assests/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
              integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <style>
            .login-gg:hover{
                background-color: rgba(109, 120, 123, 0.16); /* Replace with your desired color */
                transition: background-color 0.3s;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <c:if test="${not empty requestScope.msg}">
                <div class="alert alert-warning" role="alert">
                    <span class="p-3">${requestScope.msg}</span>
                </div>
            </c:if>
            <c:if test="${not empty requestScope.success}">
                <div class="alert alert-success" role="alert">
                    <span class="p-3">${requestScope.success}</span>
                </div>
            </c:if>
            <div class="">
                <div class="row card-body p-md-3 ">
                    <div class="col-md-6 d-flex align-items-center flex-column justify-content-center">
                        <form action="login" method="POST" class="w-100">
                            <h3 class="text-center ml-3 mb-3">Sign in</h3>  
                            <div class="form-group">
                                <label for="account">Email or Phone</label>
                                <input type="text" class="form-control" id="account" name="account" onchange="checkInput()" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="d-flex justify-content-end">
                                <p class="mt-3 text-center"><a href="reset">Forgot password?</a></p>
                            </div>
                            <button type="submit" id="loginBtn" class="btn btn-primary btn-block w-100">Login</button>
                        </form>
                        <div class="d-flex justify-content-center">
                            <p class="mt-3 text-center">Don't have an account? <a href="pages/common/register.jsp">Register here</a></p>
                        </div>
                        <div class="w-100">
                            <button class="btn login-gg w-100" onclick="redirectToGoogle()">
                                <i class="fab fa-google" style="color: #577ec1;"></i>
                                <span style="color: #4984bc;">Google</span>
                            </button>


                        </div>
                    </div>
                    <div class="col-md-6">
                        <a href="index.html"> 
                            <img class="img-fluid rounded" src="assests/images/logo.png" alt="title">
                        </a>
                    </div>

                </div>
            </div>
        </div>

        <script src="../../assests/js/bootstrap.bundle.min.js"></script>
        <script src="../../assests/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

        <script>
                                let savedAccount = localStorage.getItem('savedAccount');

                                // Populate the input fields with the saved data
                                if (savedAccount) {
                                    document.getElementById('account').value = savedAccount;
                                }
                            
                                function redirectToGoogle() {
                                    // Define the Google OAuth2 authorization URL
                                    var googleAuthUrl = "https://accounts.google.com/o/oauth2/auth?scope=profile%20email&redirect_uri=http://localhost:8080/SWP391-Project/LoginGoogleHandler&response_type=code&client_id=831398228527-qs2fj9ec814qiram3t1jiam1fbls70ek.apps.googleusercontent.com&approval_prompt=force";

                                    // Redirect the user to the Google OAuth2 authorization URL
                                    window.location.href = googleAuthUrl;
                                }
                                checkInput = () => {
                                    let regex = /^.{0,50}$/;
                                    let account = $("#account").val();
                                    if (!regex.test(account)) {
                                        Toastify({
                                            text: "Please enter account has length less than 50 characters!",
                                            duration: 3000, // 3 seconds
                                            close: true,
                                            gravity: "right",
                                            backgroundColor: "#f8d7da",
                                            style: {
                                                color: "#58151c"
                                            }
                                        }).showToast();
                                        $("#loginBtn").prop("disabled", true);
                                    } else {
                                        $("#loginBtn").prop("disabled", false);
                                    }
                                    localStorage.setItem('savedAccount', account);
                                }
        </script>
        <style>
        /* Add CSS for the toast */
        #toast {
            display: none;
                position: fixed;
                top: 50px;
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
            displayToast("Password changed successfully!", true);
        } else if (isSuccess === "false") {
            displayToast("Failed to change password!", false);
        }
    });
    </script>
    </body>
</html>
