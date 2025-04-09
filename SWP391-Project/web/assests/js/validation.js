
// Function to validate the email address format
            function validateEmail(email) {
                // Regular expression for a valid email address
                var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
                if (emailRegex.test(email)) {
                    Toastify({
                        text: "Email is invalid!",
                        duration: 3000, // 3 seconds
                        close: true,
                        gravity: "right",
                        backgroundColor: "rgba(255, 255, 255, 0.4)",
                    }).showToast();
                }
                return emailRegex.test(email);
            }

            // Function to validate the phone number format (you can customize it based on your requirements)
            function validatePhoneNumber(phoneNumber) {
                // Regular expression for a valid phone number (10 digits)
                var phoneRegex = /^0\d{9}$/;
                if (emailRegex.test(phoneNumber)) {
                    Toastify({
                        text: "Phone is invalid!",
                        duration: 3000, // 3 seconds
                        close: true,
                        gravity: "right",
                        backgroundColor: "rgba(255, 255, 255, 0.4)",
                    }).showToast();
                }
                return phoneRegex.test(phoneNumber);
            }

            function validateName(name) {
                // Regular expression to match only letters (A-Z, a-z)
                var nameRegex = /^[A-Za-z]+$/;
                if (emailRegex.test(name)) {
                    Toastify({
                        text: "Phone is invalid!",
                        duration: 3000, // 3 seconds
                        close: true,
                        gravity: "right",
                        backgroundColor: "rgba(255, 255, 255, 0.4)",
                    }).showToast();
                }
                return nameRegex.test(name);
            }


            // Function to perform form validation
            function validateForm() {
                var name = document.getElementById("name").value;
                var email = document.getElementById("email").value;
                var phone = document.getElementById("phone").value;
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("password-confirm").value;

                // Basic validation for the "Name" field (non-empty)
                if (name.trim() === ""|| !validateName(name)) {
                    alert("Please enter your name.");
                    return false;
                }

                // Basic validation for the "Email Address" field (non-empty and valid email format)
                if (email.trim() === "" || !validateEmail(email)) {
                    alert("Please enter a valid email address.");
                    return false;
                }

                // Basic validation for the "Phone Number" field (non-empty and valid phone format)
                if (phone.trim() === "" || !validatePhoneNumber(phone)) {
                    alert("Please enter a valid phone number (10 digits).");
                    return false;
                }

                // Basic validation for the "Password" field (non-empty)
                if (password.trim() === "") {
                    alert("Please enter a password.");
                    return false;
                }

                // Basic validation for the "Confirm Password" field (non-empty and matching the "Password" field)
                if (confirmPassword.trim() === "" || confirmPassword !== password) {
                    alert("Passwords do not match.");
                    return false;
                }

                // If all validations pass, the form will be submitted
                return true;
            }

            