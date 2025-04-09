<%--
    Document   : verification
    Created on : Sep 17, 2023, 10:43:14 PM
    Author     : Đàm Quang Chiến
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Project Portal Management</title>
        <link rel="shortcut icon" href="assests/images/logo.png">
        <link rel="stylesheet" href="assests/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
              integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <style>
            body{
                background-color: #DBE7FE
            }
            .form-check{
                display: none;
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>      
    </head>

    <body>

        <div class="container mt-5 d-flex justify-content-center">

            <c:if test="${not empty requestScope.failMsg}">
                <div class="alert alert-warning" role="alert">
                    <span class="p-3">${requestScope.failMsg}</span>
                </div>
            </c:if>
            <div class="card w-50">
                <div class="card-header text-center bg-primary text-white">
                    <h2 class="card-title">Welcome to Our Platform</h2>
                </div>
                <div class="card-body">

                    <form  action="../../register" method="post">

                        <!-- Choose Verification Method -->
                        <div class="mb-3">
                            <h5 class="card-title">Choose Verification Method:</h5>
                            <div class="form-check">
                                <c:if test="${requestScope.regisType == 'email'}">
                                    <input type="radio" name="verificationMethod" id="emailMethod" value="email"
                                           class="form-check-input" required checked">
                                    <label for="email" class="form-check-label">Email</label>
                                </c:if>
                            </div>
                            <div class="form-check">
                                <c:if test="${requestScope.regisType == 'phone'}">
                                    <input type="radio" id="smsMethod" name="verificationMethod" value="sms"
                                           class="form-check-input" required checked">
                                    <label for="sms" class="form-check-label">SMS</label>
                                </c:if>
                            </div>
                        </div>
                        <div id="verification-form"></div>
                        <!-- Button to Send Verification Code -->
                        <button type="submit" class="btn btn-primary btn-block" onclick="sendVerifyCode(event)">Send Verification Code</button>
                    </form>

                    <!-- Verification Code Input -->
                    <form id="verify-form" action="register" method="post">
                        <input id="email" type="hidden" name="email" value="${email}">
                        <input id="register" type="hidden" name="mode" value="email-register">
                        <input id="name" type="hidden" name="name" value="${name}">
                        <input id="phone" type="hidden" name="phone" value="${phone}">
                        <input id="pass" type="hidden" name="password" value="${password}">
                        <div class="mt-4">
                            <label for="verificationCode" class="form-label">Enter Verification Code:</label>
                            <input type="text" id="verificationCode" name="verificationCode" class="form-control"
                                   required>
                        </div>
                        <button id="btn-verify" type="submit" class="btn btn-success btn-block mt-3">Verify Code</button>

                    </form>
                </div>
            </div>
        </div>
        <script src="https://www.gstatic.com/firebasejs/9.12.1/firebase-app-compat.js"></script>
        <script src="https://www.gstatic.com/firebasejs/9.12.1/firebase-auth-compat.js"></script>
        <script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
        <script src="assests/js/bootstrap.bundle.min.js"></script>
        <script src="assests/js/bootstrap.min.js"></script>
        <script src="https://www.gstatic.com/firebasejs/9.12.1/firebase-app-compat.js"></script>
        <script src="https://www.gstatic.com/firebasejs/9.12.1/firebase-auth-compat.js"></script>
        <script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>

                            $(document).ready(function () {
                                let email = document.getElementById("emailMethod");
                                console.log(email.checked);
                                $("#verificationCode").val("");
                                var verifyButton = document.getElementById('btn-verify');
                                if (email.value != "") {
                                    document.getElementById('verification-form').style.display = 'none';
                                    verifyButton.onclick = null; // Remove the onclick function
                                    $("#register").val("email-register");
                                } else {
                                    document.getElementById('verification-form').style.display = 'block';
                                    render();
                                    $("#register").val("register");
                                    // Add an onclick function for the "Verify Code" button
                                    verifyButton.onclick = function (event) {
                                        event.preventDefault();
                                        var code = document.getElementById('verificationCode').value;
                                        window.confirmationResult.confirm(code).then(function () {
                                            $("#verify-form").submit();
                                        }).catch(function () {
                                            // Handle failure
                                            Toastify({
                                                text: "Verification code does not match!",
                                                duration: 3000, // 3 seconds
                                                close: true,
                                                gravity: "right",
                                                backgroundColor: "#f8d7da",
                                                style: {
                                                    color: "#58151c"
                                                }
                                            }).showToast();
                                        });
                                    };
                                }
                            });

                            // Your web app's Firebase configuration\
                            //chien
                            const firebaseConfig = {
                                apiKey: "",
                                authDomain: "swp391-3fcbc.firebaseapp.com",
                                projectId: "swp391-3fcbc",
                                storageBucket: "swp391-3fcbc.appspot.com",
                                messagingSenderId: "691277329952",
                                appId: "1:691277329952:web:1e280a9bab40c640de2e45",
                                measurementId: "G-MVNE99TDXQ"
                            };

                            firebase.initializeApp(firebaseConfig);

                            function render() {
                                window.recaptchaVerifier = new firebase.auth.RecaptchaVerifier('verification-form');
                                recaptchaVerifier.render();
                            }

                            function phoneAuth() {
                                var rawPhoneNumber = document.getElementById('phone').value;

                                // Remove the leading '0' and add '+84' at the beginning

                                let formattedPhoneNumber = rawPhoneNumber.startsWith('0') ? '+84' + rawPhoneNumber.slice(1) : '+' + rawPhoneNumber;
                                alert(formattedPhoneNumber);
                                firebase.auth().signInWithPhoneNumber(formattedPhoneNumber, window.recaptchaVerifier).then(function (confirmationResult) {
                                    window.confirmationResult = confirmationResult;
                                    coderesult = confirmationResult;
                                }).catch(function (error) {
                                    alert(error.message);
                                });

                            }

                            function sendVerifyCode(event) {
                                event.preventDefault();

                                // Get the selected verification method
                                let name = document.querySelector("#name").value;
                                let email = document.querySelector("#email").value;
                                if (email != "") {

                                    // Send an AJAX request to the server
                                    alert("You want to send verify code to " + email + "?");
                                    $.ajax({
                                        type: "POST",
                                        url: "register",
                                        data: {
                                            mode: "sendVerifyCode",
                                            name: name,
                                            email: email
                                        },
                                        success: function () {
                                            // This function will be executed if the request is successful
                                            Toastify({
                                                text: "Verification code sent successfully!",
                                                duration: 3000, // 3 seconds
                                                close: true,
                                                gravity: "right",
                                                backgroundColor: "#5cb85c",
                                            }).showToast();
                                        },
                                        error: function (xhr, status, error) {
                                            // This function will be executed if the request encounters an error
                                            console.error("AJAX Error:", status, error);
                                            // You can handle the error here, e.g., show an error message
                                            Toastify({
                                                text: "Error sending verification code: " + error,
                                                duration: 3000, // 3 seconds
                                                close: true,
                                                gravity: "right",
                                                backgroundColor: "#d9534f",
                                            }).showToast();
                                        }
                                    });

                                } else {
                                    Toastify({
                                        text: "Verification code sent successfully!",
                                        duration: 3000, // 3 seconds
                                        close: true,
                                        gravity: "right",
                                        backgroundColor: "#5cb85c",
                                    }).showToast();
                                    phoneAuth();
                                }

                            }
        </script>
    </body>
</html>
