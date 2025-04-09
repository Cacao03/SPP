<%-- 
    Document   : register
    Created on : Sep 17, 2023, 9:24:03 PM
    Author     : Đàm Quang Chiến
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   
        <style>
            .errorMsg{
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container d-flex align-items-center" style="min-height: 100vh">
            <div class="">
                <div class="row card-body p-md-3 justify-content-center mt-5">
                    <div class="col-md-6 d-flex align-items-center">
                        <form id="register-form" method="get" action="register" class="w-100">
                            <div class="mb-3 row">
                                <label for="name" class="col-md-4 col-form-label text-md-end"></label>
                                <div class="col-md-8">
                                    <h3 class="text-center pl-3 mb-3">Sign up</h3>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="name" class="col-md-4 col-form-label text-md-end">Name</label>
                                <div class="col-md-8">
                                    <input id="name" type="text" class="form-control" name="name" value="" required autofocus>
                                    <span class="errorMsg" id="errName"></span>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label class="col-md-4 col-form-label text-md-end">Register by</label>
                                <div class="col-md-8 d-flex align-items-center">
                                    <input type="radio" name="registrationType" id="emailOption" onclick="changeAccount(event.target.value)" value="email" checked> Email
                                    <input type="radio" name="registrationType" style="margin-left: 12px" id="phoneOption" onclick="changeAccount(event.target.value)" value="phone"> Phone
                                </div>
                            </div>
                            <div class="mb-3 row" id="emailInput">
                                <label for="email" class="col-md-4 col-form-label text-md-end">Email Address</label>
                                <div class="col-md-8">
                                    <input id="email" type="email" class="form-control" name="email" value="" required>
                                    <span class="errorMsg" id="errEmail"></span>
                                </div>
                            </div>
                            <div class="mb-3 row" id="phoneInput" style="display: none">
                                <label for="phone" class="col-md-4 col-form-label text-md-end">Phone Number</label>
                                <div class="col-md-8">
                                    <input id="phone" type="number" class="form-control" name="phone" value="" required>
                                    <span class="errorMsg" id="errPhone"></span>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="password" class="col-md-4 col-form-label text-md-end">Password</label>
                                <div class="col-md-8">
                                    <input id="password" type="password" class="form-control" name="password" required>
                                    <span class="errorMsg" id="errPass"></span>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="password-confirm" class="col-md-4 col-form-label text-md-end">Confirm Password</label>
                                <div class="col-md-8">
                                    <input id="password-confirm" type="password" class="form-control" name="password_confirmation" required>
                                    <span class="errorMsg" id="errRePass"></span>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <p class="text-center col-md-4 offset-md-8" style="font-size: 0.85rem">
                                    <a href="pages/common/login.jsp">Already have an account?</a>
                                </p>
                            </div>
                            <div class="mb-3 row">
                                <div class="col-md-8 offset-md-4">
                                    <button id="btn-register" type="submit" class="btn btn-primary w-100">Register</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <a href="index.html"> 
                            <img class="img-fluid rounded" src="assests/images/logo.png" alt="title">
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <script src="assests/js/bootstrap.bundle.min.js"></script>
        <script src="assests/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <!--<script type="text/javascript" src="../../assests/js/validation.js"></script>-->
        <script>

                                        function validateEmail(email) {
                                            // Regular expression for a valid email address
                                            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
                                            return emailRegex.test(email);
                                        }

                                        // Function to validate the phone number format (you can customize it based on your requirements)
                                        function validatePhoneNumber(phoneNumber) {
                                            if (phoneNumber.startsWith('+')) {
                                                phoneNumber = phoneNumber.slice(1);
                                            }
                                            // Regular expression for a valid phone number (10 digits)
                                            var phoneRegex = /^(0|\84)\d{9}$/;

                                            return phoneRegex.test(phoneNumber);
                                        }

                                        function validateName(name) {
                                            // Regular expression to match only letters (A-Z, a-z)
                                            var nameRegex = /^[A-Za-z\s]{1,50}$/;

                                            return nameRegex.test(name);
                                        }
                                        function validatePassword(pass) {
                                            // Regular expression to match only letters (A-Z, a-z)
                                            var passRegex = /^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$/;
                                            return passRegex.test(pass);
                                        }


                                        function displayMessage(message, id) {
                                            const errElement = document.getElementById(id);
                                            errElement.textContent = message;
                                        }

                                        async function checkExistence(type, value) {
                                            return new Promise(function (resolve, reject) {
                                                $.ajax({
                                                    type: "POST",
                                                    url: "verify",
                                                    data: {
                                                        email: type === "email" ? value : "",
                                                        phone: type === "phone" ? value : ""
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


                                        async function validateForm() {
                                            var name = document.getElementById("name").value;
                                            var password = document.getElementById("password").value;
                                            var confirmPassword = document.getElementById("password-confirm").value;

                                            var check = true;

                                            // Check which radio button is selected
                                            var registrationType = document.querySelector('input[name="registrationType"]:checked').value;

                                            let errEmail = "";
                                            let errPhone = "";
                                            let errName = "";
                                            let errPass = "";
                                            let errRePass = "";
                                            if (registrationType === "email") {
                                                var email = document.getElementById("email").value;
                                                try {
                                                    const emailData = await checkExistence("email", email);
                                                    if (emailData.emailExists) {
                                                        errEmail = "Email has existed!";
                                                        check = false;
                                                    }

                                                    if (!emailData.domainExists) {
                                                        errEmail = "Email domain is not allowed!";
                                                        check = false;
                                                    }

                                                } catch (error) {
                                                    console.error(error); // Handle any errors that occurred during the AJAX calls
                                                }

                                                // Basic validation for the "Email Address" field (non-empty and valid email format)
                                                if (email.trim() === "" || !validateEmail(email)) {
                                                    errEmail = "Please enter a valid email!";
                                                    check = false;
                                                }
                                            } else if (registrationType === "phone") {
                                                var phone = document.getElementById("phone").value;
                                                try {
                                                    const phoneData = await checkExistence("phone", phone);
                                                    if (phoneData.phoneExists) {
                                                        errPhone = "Phone has existed!";
                                                        check = false;
                                                    }
                                                } catch (error) {
                                                    console.error(error); // Handle any errors that occurred during the AJAX calls
                                                }

                                                // Basic validation for the "Phone Number" field (non-empty and valid phone format)
                                                if (phone.trim() === "" || !validatePhoneNumber(phone)) {
                                                    errPhone = "Please enter a valid phone number (10 digits)!";
                                                    check = false;
                                                }
                                            }

                                            // Basic validation for the "Name" field (non-empty)
                                            if (name.trim() === "" || !validateName(name)) {
                                                errName = "Please enter a valid name!";
                                                check = false;
                                            }

                                            // Basic validation for the "Password" field (non-empty)
                                            if (password.trim() === "" || !validatePassword(password)) {
                                                errPass = "Your password must have at least 8 characters, one uppercase letter, and one special character";
                                                check = false;
                                            }

                                            // Basic validation for the "Confirm Password" field (non-empty and matching the "Password" field)
                                            if (confirmPassword.trim() === "" || confirmPassword !== password) {
                                                errRePass = "Password does not match";
                                                check = false;
                                            }
                                            displayMessage(errEmail, "errEmail");
                                            displayMessage(errPhone, "errPhone");
                                            displayMessage(errName, "errName");
                                            displayMessage(errPass, "errPass");
                                            displayMessage(errRePass, "errRePass");
                                            return check;
                                        }

                                        // Attach the form validation function to the form's submit event
                                        const verify_btn = document.getElementById('btn-register');
                                        verify_btn.addEventListener('click', () => {
                                            event.preventDefault();

                                            validateForm().then(function (checkValue) {
                                                // Here, checkValue will be the final result of the form validation
                                                if (checkValue) {
                                                    document.getElementById("register-form").submit();
                                                }
                                            });
                                        });

                                        function changeAccount(value) {
                                            let phone = document.getElementById("phoneInput");
                                            let email = document.getElementById("emailInput");

                                            if (value === "phone") {
                                                phone.style.display = "";
                                                email.style.display = "none";
                                            }
                                            if (value === "email") {
                                                phone.style.display = "none";
                                                email.style.display = "";
                                            }
                                        }
        </script>
    </body>
</html>


