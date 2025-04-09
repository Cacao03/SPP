<%-- 
    Document   : userUpdate
    Created on : Sep 20, 2023, 11:24:27 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.User"%>
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
            ResultSet Rs = (ResultSet) request.getAttribute("Rs");
            Vector<User> vector = (Vector<User>) request.getAttribute("data");
            User us = vector.get(0);
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
            
            <%@include file="../layout/adminSideBar.jsp" %>
           
            <!-- End of sidebar-wrapper  -->

            <!-- Start Page-content -->
            <main class="page-content bg-light">
                <!-- HEADER -->
                <%@include file="../layout/navbar.jsp" %>
                <!-- End of HEADER -->

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">User Profile & Settings</h5>


                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                </ul>
                            </nav>
                        </div>
                        <!--
                        <div class="card bg-white rounded shadow overflow-hidden mt-4 border-0">
                            <div class="p-5 bg-primary bg-gradient"></div>
                            <div class="avatar-profile d-flex margin-nagative mt-n5 position-relative ps-3">
                                <img src="assests/images/doctors/01.jpg" class="rounded-circle shadow-md avatar avatar-medium" alt="">
                                <div class="mt-4 ms-3 pt-3">
                                    <h5 class="mt-3 mb-1">Dr. Calvin Carlo</h5>
                                    <p class="text-muted mb-0">Orthopedic</p>
                                </div>
                            </div>>
                        -->

                        <div class="row">
                            <div class="col-lg-8 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <form id="update-form" action="UserProfileController" method ="post" enctype="multipart/form-data">
                                        
                                        <input type ="hidden" name ="service" value ="showProfile">
                                        <input type ="hidden" name="submit1" value="Update Profile">

                                    <div class="row align-items-center mb-3">
                                        <div class="col-lg-2 col-md-4">

                                            <img src="dataUser/<%=us.getAvatarUrl()%>"  style="float:left" class="avatar avatar-medium rounded-pill shadow mx-auto d-block" alt="">
                                            <!--<a href="" class="btn btn-primary h-50 m-5 " data-bs-toggle="modal" data-bs-target="#editprofile">Upload</a>-->
                                            
                                        </div><!--end col-->
                                        
                                        
                                        <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                                <h5 class="">Upload your picture</h5>
                                                <p class="text-muted mb-0">For best results, use an image at least 600px by 600px in either .jpg or .png format</p>
                                            </div><!--end col-->
                                        
                                        <div class="col-lg-1 col-md-12 text-lg-end text-center mt-4 mt-lg-0 ">
                                            <label style="text-center">
                                            <a class="btn btn-primary">Upload</a>
                                            <input class="form-control" style="display:none" data-buttonText="Upload" id="getFile" type="file" name="file" for="file"/>     
                                            </label>
                                    </div><!--end row-->
                                        <div class="col-lg-3 ms-5"><span id="error4"></span> </div>
                                        
                                        </div>
                                    
                                    
                                        
                                        <input name="uid" id="uid" type="hidden" value ="<%=us.getUserId()%>" readonly class="form-control" placeholder="Full Name :">
                                        <div class="row" class="">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="name">Full Name</label>
                                                    <input name="name" id="name" type="text" value ="<%=us.getFullName()%>" required class="form-control" placeholder="Full Name :">
                                                <span id="error1"></span>    
                                                </div>
                                            </div><!--end col-->
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <input type="hidden" id="oldEmail" name="oldEmail" value ="<%=us.getEmail()%>">
                                                    <label class="form-label" for="email">Email</label>
                                                    <input name="email" id="email" type="text" value ="<%=us.getEmail()%>" required class="form-control" placeholder="Email:">                                 
                                                <span id="error2"></span>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <input type="hidden" id="oldPhone" name="oldPhone" value ="<%=us.getMobile()%>">
                                                    <label class="form-label" for="phone">Phone number</label>
                                                    <input name="phone" id="phone" type="text" value ="<%=us.getMobile()%>" required class="form-control" placeholder="Phone number:">
                                                <span id="error3"></span>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label" for="role">Role:</label>
                                                    <%while (Rs.next()) {
                                                                    if (Rs.getInt(1) == us.getRoleId()) {
                                                            %>
                                                            <p class="form-control" placeholder="Role:"><%=Rs.getString(2)%></p>              
                                                    <%}
                                                            }%>   
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="note">Note</label>
                                                    <textarea name="note" id="note" rows="3" class="form-control" ><%=us.getNote() == null ? "" : us.getNote()%></textarea>
                                                </div>
                                            </div>
                                        </div><!--end row-->

                                        <button type="submit" id="btn-update" type="button" class="btn btn-primary">Confirm Changes</button>
                                    </form>
                                </div>
                                     
                            </div><!--end col-->
                                                                                              
                            <div class="col-lg-4 mt-4">
                                <div class="card rounded border-0 shadow">
                                    <div class="rounded mt-8">
                                        <div class="p-3 border-bottom">
                                            <h6 class="mb-0">Actions:</h6>
                                        </div>

                                        <div class="p-3">
                                            <div class="p-3">
                                                <h5 class="mb-0 text-primary">Change Password:</h5>
                                                <h6 class="mb-0 fw-normal">Do you want to change password? Please press below "Change Password" button</h6>
                                                <div class="mt-4">
                                                    <a href="UserProfileController?service=changePass&uid=${sessionScope.user.getUserId()}" class="btn btn-primary">Change Password</a>
                                                </div><!--end col-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Footer Start -->
                <%@include file="../layout/footer.jsp" %>
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
                                                    var oldEmail = document.getElementById("oldEmail").value;
                                                    var oldPhone = document.getElementById("oldPhone").value;
                                                    var fi=document.getElementById("getFile");
                                                    
                                                    var error1 = document.getElementById("error1");
                                                    var error2 = document.getElementById("error2");
                                                    var error3 = document.getElementById("error3");
                                                    var error4 = document.getElementById("error4");
                                                    
                                                    var check = true;
                                                    try {
                                                        const emailData = await checkExistence("email", email);

                                                        if (emailData.emailExists && oldEmail !== email) {
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
                                                        if (phoneData.phoneExists && oldPhone !== phone) {
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
                                                    
                                                    if (fi.files.length > 0) {
                                                    for ( var i = 0; i <= fi.files.length - 1; i++) {
         
                                                    const fsize = fi.files.item(i).size;
                                                    const file = Math.round((fsize / 1024));
                                                    // The size of the file.
                                                    if (file > 10240) {    
                                                        error4.textContent = "File too big, please select a file less than 10mb";
                                                        error4.style.color = "red";
                                                        check=false;
                                                            }
                                                            else{
                                                            check=true;
                                                            }
                                                        }
                                                    }

                                                    // Basic validation for the "Confirm Password" field (non-empty and matching the "Password" field)
                                                    return check;
                                                }



                                                // Attach the form validation function to the form's submit event
                                                const verify_btn = document.getElementById('btn-update');
                                                verify_btn.addEventListener('click', () => {
                                                    event.preventDefault();

                                                    validateForm().then(function (checkValue) {
                                                        // Here, checkValue will be the final result of the form validation
                                                        if (checkValue) {
                                                            document.getElementById("update-form").submit();
                         
                                                        }
                                                    });
                                                    error1.textContent="";
                                                    error2.textContent="";
                                                    error3.textContent="";
                                                    error4.textContent="";
                                                });
                </script>
                <style>
        /* Add CSS for the toast */
        #toast {
            display: none;
                position: fixed;
                top: 75px;
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
            displayToast("Information updated successfully!", true);
        } else if (isSuccess === "false") {
            displayToast("Failed to update information!", false);
        }
    });
    </script>

                </body>

                </html>
