<%-- 
    Document   : newUser
    Created on : Sep 20, 2023, 4:58:23 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="model.User"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Student Project Portal Management</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assests/images/logo.png">
        <!-- Bootstrap -->
        <link href="assests/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="assests/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="assests/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="assests/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assests/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assests/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   
    </head>
    <body>
        <%
            Vector<User> vector = (Vector<User>) request.getAttribute("data");
            ResultSet Rs = (ResultSet) request.getAttribute("Rs");
        %>
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <!-- page-wrapper -->
        <div class="page-wrapper doctris-theme toggled">

            <!-- Sidebar wrapper -->
            <%@include file="../../layout/adminSideBar.jsp" %>
            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../../layout/navbar.jsp" %>
                <!-- End of HEADER -->

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Add New User</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">User Management</a></li>
                                    <li class="breadcrumb-item"><a href="UserController?service=listAll">User List</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Add New User</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row d-flex justify-content-center">
                            <div class="col-lg-9 mt-5 ">
                                <div class="card border-0 p-4 rounded shadow ">
                                    <form id="add-form" action="UserController" method ="post" enctype="multipart/form-data">
                                        <input type ="hidden" name ="service" value ="addUser">
                                        <input type ="hidden" name="submit1" value="Add User">

                                        <div class="row " class="mt-4">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="name">Full Name<span class="text-danger">*</span></label>
                                                    <input name="name" id="name" type="text" required class="form-control" placeholder="Full Name :">
                                                <span id="error1"></span>
                                                </div>
                                            </div><!--end col-->


                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="email">Your Email<span class="text-danger">*</span></label>
                                                    <input name="email" id="email" type="email" required class="form-control" placeholder="Your email :">
                                                <span id="error2"></span>
                                                </div> 
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="phone">Phone number<span class="text-danger">*</span></label>
                                                    <input name="phone" id="phone" type="text" class="form-control" placeholder="Phone number :">
                                                <span id="error3"></span>
                                                </div>                                              
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="role">Role</label>
                                                    <select class="form-control department-name select2input" name="role" id="role">
                                                        <%while (Rs.next()) {
                                                                if (Rs.getInt(3) == 2) {
                                                        %>
                                                        <option value="<%=Rs.getInt(1)%>"><%=Rs.getString(2)%></option>

                                                        <%}
                                                                }%>     
                                                    </select>
                                                </div>
                                            </div><!--end col-->



                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="note">Note</label>
                                                    <textarea name="note" id="note" rows="3" class="form-control" placeholder="Note :"></textarea>
                                                </div>
                                            </div>          
                                            <div class="col-md-12 d-grid">
                                            <button id="btn-add" type="submit" class="btn btn-primary"/>Add user</button>
                                            </div>

                                        </div><!--end row-->

                                    </form>
                                </div>
                            </div><!--end col-->                         
                        </div><!--end row-->
                    </div>
                </div>
                <!-- Footer Start -->
                <%@include file="../../layout/footer.jsp" %>
                <!--end footer-->
            </main>
        </div><!--end container-->

                

                <!-- javascript -->
                <script src="assests/js/jquery.min.js"></script>
                <script src="assests/js/bootstrap.bundle.min.js"></script>
                <!-- simplebar -->
                <script src="assests/js/simplebar.min.js"></script>
                <!-- Select2 -->
                <script src="assests/js/select2.min.js"></script>
                <script src="assests/js/select2.init.js"></script>
                <!-- Icons -->
                <script src="assests/js/feather.min.js"></script>
                <!-- Main Js -->
                <script src="assests/js/app.js"></script>
                <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

                <script>

                    // Function to validate the email address format
                    function validateEmail(email) {
                        // Regular expression for a valid email address
                        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
                        return emailRegex.test(email);
                    }

                    // Function to validate the phone number format (you can customize it based on your requirements)
                    function validatePhoneNumber(phoneNumber) {
                        // Regular expression for a valid phone number (10 digits)
                        var phoneRegex = /^0\d{9}$/;

                        return phoneRegex.test(phoneNumber);
                    }

                    function validateName(name) {
                        // Regular expression to match only letters (A-Z, a-z)
                        var nameRegex = /^[A-Za-z\s]+$/;

                        return nameRegex.test(name);
                    }
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

                    async function checkExistence(type, value) {
                        return new Promise(function (resolve, reject) {
                            $.ajax({
                                type: "POST",
                                url: "./verify",
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
                        var email = document.getElementById("email").value;
                        var phone = document.getElementById("phone").value;
                        //var error = document.getElementById("error");
                        var error1 = document.getElementById("error1");
                        var error2 = document.getElementById("error2");
                        var error3 = document.getElementById("error3");

                        var check = true;
                        try {
                            const emailData = await checkExistence("email", email);

                            if (emailData.emailExists) {
                                error2.textContent = "Email has existed!";
                                error2.style.color = "red";
                                check = false;
                            }

                            if (!emailData.domainExists) {
                                error2.textContent = "Email domain is not allowed!";
                                error2.style.color = "red";
                                check = false;
                            }
                            const phoneData = await checkExistence("phone", phone);
//                    alert(emailData.emailExists +" "+phoneData.phoneExists);
                            if (phoneData.phoneExists) {
                                error3.textContent = "Phone has existed!";
                                error3.style.color = "red";
                                check = false;
                            }
                        } catch (error) {
                            console.error(error); // Handle any errors that occurred during the AJAX calls
                        }

                        // Basic validation for the "Name" field (non-empty)
                        if (name.trim() === "" || !validateName(name)) {
                            error1.textContent = "Please enter a valid name!";
                            error1.style.color = "red";
                            check = false;
                        }

                        // Basic validation for the "Email Address" field (non-empty and valid email format)
                        if (email.trim() === "" || !validateEmail(email)) {
                            error2.textContent = "Please enter a valid email!";
                            error2.style.color = "red";
                            check = false;
                        }

                        // Basic validation for the "Phone Number" field (non-empty and valid phone format)
                        if (phone.trim() === "" || !validatePhoneNumber(phone)) {
                            error3.textContent = "Please enter a valid phone number (10 digits)!";
                            error3.style.color = "red";
                            check = false;
                        }
                        
                        // Basic validation for the "Confirm Password" field (non-empty and matching the "Password" field)
                        return check;
                    }



                    // Attach the form validation function to the form's submit event
                    const verify_btn = document.getElementById('btn-add');
                    verify_btn.addEventListener('click', () => {
                        event.preventDefault();

                        validateForm().then(function (checkValue) {
                            // Here, checkValue will be the final result of the form validation
                            if (checkValue) {
                                document.getElementById("add-form").submit();
                            }
                        });
                        error1.textContent="";
                        error2.textContent="";
                        error3.textContent="";
                    });
                    
                </script>
                </body>

                </html>