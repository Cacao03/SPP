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
        <base href="${pageContext.request.contextPath}/">
        <link rel="stylesheet" href="assests/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
              integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <style>
            body{
                background-color: #DBE7FE
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>      
    </head>

    <body>

        <c:if test="${not empty requestScope.failMsg}">
            <div class="alert alert-warning" role="alert">
                <span class="p-3">${requestScope.failMsg}</span>
            </div>
        </c:if>
        <div class="container mt-5 d-flex justify-content-center">

            <div class="card w-50">
                <div class="card-header text-center bg-primary text-white">
                    <h2 class="card-title">Reset your account password</h2>
                </div>
                <div class="card-body">

                    <form action="reset" method="post">

                        <!-- Choose Verification Method -->
                        <div class="mb-3">
                            <h5 class="card-title">Choose Verification Method:</h5>
                            <div class="form-check">
                                <input type="radio" id="email" name="verificationMethod" value="email"
                                       class="form-check-input" required checked onchange="changeMethod(event.target.value)">
                                <label for="email" class="form-check-label">Email</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" id="sms" name="verificationMethod" value="sms"
                                       class="form-check-input" required onchange="changeMethod(event.target.value)">
                                <label for="sms" class="form-check-label">SMS</label>
                            </div>
                        </div>
                        <div class="form-input mb-2">
                            <label id="input-verify-label" for="input-verify" class="form-check-label">Enter your email: </label><br>
                            <input class="w-100" type="text" id="input-verify" name="input-verify" value="" required>
                        </div>
                        <div id="verification-form"></div>
                        <!-- Button to Send Verification Code -->
                        <button type="submit" class="btn btn-primary btn-block" onclick="sendVerifyCode(event)">Send Verification Code</button>
                    </form>

                    <!-- Verification Code Input -->
                    <form id="verify-form" action="reset" method="post">
                        <input id="mode" type="hidden" name="mode" value="email-reset">
                        <input id="content" type="hidden" name="content" value="">
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
                                changeMethod(method);
                            });

                            var selectedMethod = document.querySelector('input[name="verificationMethod"]:checked').value;
                            function changeMethod(selectedMethod) {
                                var verifyButton = document.getElementById('btn-verify');
                                $("#verificationCode").val("");
                                if (selectedMethod == "email") {
                                    document.getElementById('verification-form').style.display = 'none';
                                    verifyButton.onclick = null; // Remove the onclick function
                                    $("#input-verify-label").text("Enter your email:")
                                    $("#input-verify").attr("type", "text");
                                    $("#mode").val("email-reset");
                                } else {
                                    $("#input-verify-label").text("Enter your phone number:")
                                    $("#input-verify").attr("type", "number");
                                    $("#mode").val("phone-reset");
                                    document.getElementById('verification-form').style.display = 'block';
                                    render();
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
                            }

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
                                let rawPhoneNumber = document.getElementById("input-verify").value;

                                // Remove the leading '0' and add '+84' at the beginning
                                let formattedPhoneNumber = rawPhoneNumber.startsWith('0') ? '+84' + rawPhoneNumber.slice(1) : '+'+rawPhoneNumber;
                                
                                firebase.auth().signInWithPhoneNumber(formattedPhoneNumber, window.recaptchaVerifier).then(function (confirmationResult) {
                                    window.confirmationResult = confirmationResult;
                                    coderesult = confirmationResult;
                                }).catch(function (error) {
                                    alert(error.message);
                                });
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

                            async function checkExistence(type, value) {
                                return new Promise(function (resolve, reject) {
                                    $.ajax({
                                        type: "POST",
                                        url: "verify",
                                        data: {
                                            email: type === "email" ? value : "",
                                            phone: type === "phone" ? value : "",

                                        },
                                        success: function (data) {
                                            resolve(data); // Resolve the promise with the received data
                                        },
                                        error: function () {
                                            reject("Error occurred"); // Reject the promise if there's an error
                                        }
                                    });
                                });
                            }

                            function validateEmail(email) {
                                // Regular expression for a valid email address
                                var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
                                return emailRegex.test(email);
                            }

                            // Function to validate the phone number format (you can customize it based on your requirements)
                            function validatePhoneNumber(phoneNumber) {
                                
                                // Regular expression for a valid phone number (10 digits)
                                var phoneRegex = /^(0|\84)\d{9}$/;

                                return phoneRegex.test(phoneNumber);
                            }

                            async function sendVerifyCode(event) {
                                event.preventDefault();

                                // Get the selected verification method
                                let verificationMethod = $("input[name='verificationMethod']:checked").val();


                                if (verificationMethod == "email") {
                                    let email = document.getElementById("input-verify").value;
                                    if (validateEmail(email)) {
                                        const emailData = await checkExistence("email", email);
                                        if (emailData.emailExists) {
                                            $("#content").val(email);
                                            $.ajax({
                                                type: "POST",
                                                url: "reset",
                                                data: {
                                                    email: email
                                                },

                                            }).done(function () {
                                                Toastify({
                                                    text: "Verification code sent successfully!",
                                                    duration: 3000, // 3 seconds
                                                    close: true,
                                                    gravity: "right",
                                                    backgroundColor: "#5cb85c",
                                                }).showToast();
                                            });
                                        } else {
                                            displayMessage("Email does not exist")
                                        }
                                    } else {
                                        displayMessage("Email is not valid")
                                    }
                                } else {
                                    let phone = document.getElementById("input-verify").value;
                                    if (validatePhoneNumber(phone)) {
                                        phone = phone.startsWith("84")?"0" + phone.slice(2):phone;  
                                        const phoneData = await checkExistence("phone",phone );
                                        if (phoneData.phoneExists) {
                                            $("#content").val(phone);
                                            Toastify({
                                                text: "Verification code sent successfully!",
                                                duration: 3000, // 3 seconds
                                                close: true,
                                                gravity: "right",
                                                backgroundColor: "#5cb85c",
                                            }).showToast();
                                            phoneAuth();
                                        } else {
                                            displayMessage("Phone does not exist")
                                        }
                                    } else {
                                        displayMessage("Phone number is not valid")
                                    }
                                }

                            }
        </script>
    </body>
</html>
