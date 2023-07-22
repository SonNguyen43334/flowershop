<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>Đăng nhập</title>
        <style>
            /* CSS styles */

            body {
                font-family: Arial, sans-serif;
                background-color: #f1f1f1;
            }

            .container {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
            }

            form {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            button[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #4CAF50;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .error-message {
                color: red;
                margin-bottom: 10px;
            }

            .info-message {
                color: #007bff;
                margin-bottom: 10px;
            }

            p {
                text-align: center;
            }

            .register-link {
                color: #007bff;
                text-decoration: none;
            }

            .google-login-button {
                width: 100%;
                padding: 10px;
                background-color: #dd4b39;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .remember-me {
                margin-bottom: 10px;
            }

            /* CSS cho phần navbar */
            .navbar {
                background-color: #f5f5f5;
                padding: 10px;
                background-color: #000;
            }

            .navbar a {
                margin-right: 10px;
                text-decoration: none;
                color: darkgray;
            }
            .google-login-link {
                display: inline-block;
                background-color: #4285f4;
                color: #fff;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 4px;
                font-weight: bold;
            }

            .google-login-link:hover {
                background-color: #3367d6;
            }
        </style>
    </head>

    <body>
        <div class="navbar">
            <a href="HomepageController">Homepage</a>
            <a href="cart.jsp">Cart</a>
            <!-- <a href="crud.jsp">CRUD</a> -->
            <c:if test="${empty sessionScope.LOGIN_USER}">
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            </c:if>
            <c:if test="${not empty sessionScope.LOGIN_USER}">
                <a href="MainController?action=Logout">Logout</a>
            </c:if>
        </div>
        <div class="container">
            <h1>Đăng nhập</h1>

            <form action="MainController"method="post" id="form" onsubmit="return validateForm()" >
                <label for="username">Tài khoản:</label>
                <input type="text" id="username" name="email" required>

                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required>
                <div class="g-recaptcha" data-sitekey="6LewUv8mAAAAANdYfwvJ8O3sFakzpkNi5n9nrtCj"></div>
                <div id="error"></div>
                <button type="submit" name="action" value="Login" style="margin-top: 10px">Đăng nhập</button>

                <!-- Thêm nút đăng nhập bằng Google -->
                <!--                <button type="button" id="google-login-button" style="margin-top: 10px">Đăng nhập bằng Google</button>-->

                <a href="https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:8082/FlowerShop/GmailLogin&response_type=code
                   &client_id=1062512613606-u8ol5u5hkimg23lrtabobvhdjer1dkb2.apps.googleusercontent.com&approval_prompt=force" class="google-login-link">Đăng nhập với Google</a>

                <p id="error-message" class="error-message"></p>
                <p id="info-message" class="info-message"></p>
            </form>

            <p>Bạn chưa có tài khoản? <a class="register-link" href="register.jsp">Đăng ký</a></p>
        </div>

        <script>
            var error = "<c:out value='${requestScope.error}' />";
            if (error) {
                alert(error);
            }
        </script>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script src="https://accounts.google.com/gsi/client" async defer></script>
        <script>
            function validateForm() {
                var username = document.getElementById("username").value;
                var password = document.getElementById("password").value;
                var errorMessage = document.getElementById("error-message");
                var infoMessage = document.getElementById("info-message");
                var response = grecaptcha.getResponse();
                if (username === "" || password === "")
                {
                    errorMessage.textContent = "Vui lòng nhập đủ thông tin.";
                    infoMessage.textContent = "";
                    return false;
                }

                if (!response) {
                    errorMessage.textContent = "Vui lòng xác nhận reCAPTCHA.";
                    infoMessage.textContent = "";
                    return false;
                }

                // Gửi dữ liệu đăng nhập đến servlet để xử lý
                // Thực hiện các kiểm tra khác (ví dụ: kiểm tra đúng/tài khoản mật khẩu) trong servlet

                // Tiến hành submit form
                document.getElementById("form").submit();
            }
        </script>


    </body>
</html>